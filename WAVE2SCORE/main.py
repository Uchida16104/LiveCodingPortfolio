#!/usr/bin/env python3

from __future__ import annotations
import sys
import os
import argparse
import warnings
import csv
import math

# Defensive imports
_missing = []
try:
    import numpy as np
except Exception:
    _missing.append('numpy')
try:
    import librosa
    import librosa.display
except Exception:
    _missing.append('librosa')
try:
    import matplotlib.pyplot as plt
    from matplotlib.patches import Polygon
    from matplotlib.collections import PatchCollection
    from matplotlib import cm
except Exception:
    _missing.append('matplotlib')
try:
    from sklearn.cluster import KMeans
    HAS_SK = True
except Exception:
    HAS_SK = False
try:
    import pretty_midi
    HAS_PRETTY = True
except Exception:
    HAS_PRETTY = False

if _missing:
    print("Missing packages: " + ", ".join(_missing))
    print("Install with: pip install numpy librosa matplotlib")
    sys.exit(1)

# ---------- utilities ----------

def hz_to_midi(hz: float) -> float:
    return 69 + 12 * np.log2(hz / 440.0) if hz > 0 else 0.0


def safe_div(a, b):
    return a / b if b else 0.0


# ---------- enhanced analysis ----------

def analyze_file(path: str, sr=44100, n_fft=4096, hop_length=512, fmin=27.5, fmax=8000.0):
    # Load stereo if possible for pan estimation
    y, sr_loaded = librosa.load(path, sr=sr, mono=False)
    sr = sr_loaded
    # normalize shape handling: librosa returns shape (n,) for mono, (2,n) for stereo
    if y.ndim == 1:
        y_mono = y
        y_l = y_r = y_mono
        stereo = False
    else:
        stereo = True
        # librosa returns shape (channels, samples)
        y_l = y[0]
        y_r = y[1]
        # create a mono mix for many analyses
        y_mono = librosa.to_mono(y)

    duration = y_mono.shape[0]/sr
    print(f"Loaded '{path}': {y_mono.shape[0]} samples, sr={sr}, duration={duration:.2f}s, stereo={stereo}")

    # STFT (magnitude) on mono mix for spectral features
    S = librosa.stft(y_mono, n_fft=n_fft, hop_length=hop_length, window='hann', center=True)
    S_mag = np.abs(S)
    S_db = librosa.amplitude_to_db(S_mag, ref=np.max)
    times = librosa.frames_to_time(np.arange(S_mag.shape[1]), sr=sr, hop_length=hop_length)
    freqs = librosa.fft_frequencies(sr=sr, n_fft=n_fft)

    # frame-level energy (RMS) calculated on mono and stereo per-channel frames
    rms = librosa.feature.rms(S=S_mag, frame_length=n_fft, hop_length=hop_length)[0]
    # compute left/right RMS per frame if stereo
    if stereo:
        # frame-wise RMS for left/right using short-time framing
        frame_count = S_mag.shape[1]
        l_rms = np.zeros(frame_count)
        r_rms = np.zeros(frame_count)
        for i in range(frame_count):
            s = int(max(0, i*hop_length))
            e = int(min(y_l.shape[0], s + n_fft))
            if e> s:
                l_seg = y_l[s:e]
                r_seg = y_r[s:e]
                l_rms[i] = np.sqrt(np.mean(l_seg**2)) if l_seg.size>0 else 0.0
                r_rms[i] = np.sqrt(np.mean(r_seg**2)) if r_seg.size>0 else 0.0
        # pan estimation per frame: (-1 left .. +1 right)
        pan_frame = np.where((l_rms + r_rms) > 0, (r_rms - l_rms) / (r_rms + l_rms), 0.0)
    else:
        pan_frame = np.zeros_like(rms)

    # spectral features
    centroid = librosa.feature.spectral_centroid(S=S_mag, sr=sr, hop_length=hop_length, n_fft=n_fft)[0]
    rolloff = librosa.feature.spectral_rolloff(S=S_mag, sr=sr, roll_percent=0.85, hop_length=hop_length, n_fft=n_fft)[0]
    contrast = librosa.feature.spectral_contrast(S=S_mag, sr=sr, hop_length=hop_length)
    mfcc = librosa.feature.mfcc(y=y_mono, sr=sr, n_mfcc=13, hop_length=hop_length)

    # H/P separation
    y_harm, y_perc = librosa.effects.hpss(y_mono)

    # pitch tracking
    try:
        f0, voiced_flag, voiced_prob = librosa.pyin(y_harm, fmin=fmin, fmax=fmax, sr=sr, frame_length=n_fft, hop_length=hop_length)
        print('pyin OK')
    except Exception:
        f0 = librosa.yin(y_harm, fmin=fmin, fmax=fmax, sr=sr, frame_length=n_fft, hop_length=hop_length)
        voiced_flag = ~np.isnan(f0)
        voiced_prob = np.where(voiced_flag, 1.0, 0.0)
        print('falling back to yin')

    # event segmentation: voiced regions with small gap bridging
    is_voiced = ~np.isnan(f0)
    events = []
    N = len(is_voiced)
    i = 0
    min_gap = int(0.06 * sr / hop_length)  # tolerate ~60ms gaps
    while i < N:
        if not is_voiced[i]:
            i += 1
            continue
        start = i
        while i < N and is_voiced[i]:
            i += 1
        end = i-1
        # extend across tiny gaps
        j = i
        while j < N:
            if is_voiced[j]:
                gap = j - end - 1
                if gap <= min_gap:
                    k = j
                    while k < N and is_voiced[k]:
                        k += 1
                    end = k-1
                    i = k
                    j = k
                    continue
            break

        t0 = times[start]
        t1 = min(times[end] + float(n_fft)/sr, duration)
        f0_seg = f0[start:end+1]
        rms_seg = rms[start:end+1]
        centroid_seg = centroid[start:end+1]
        rolloff_seg = rolloff[start:end+1]
        pan_seg = pan_frame[start:end+1]

        valid = f0_seg[~np.isnan(f0_seg)]
        if valid.size == 0:
            continue
        pitch_hz = float(np.median(valid))
        pitch_midi = hz_to_midi(pitch_hz)
        amp = float(np.mean(rms_seg))
        centroid_mean = float(np.median(centroid_seg))
        rolloff_mean = float(np.median(rolloff_seg))
        pan_mean = float(np.median(pan_seg))

        events.append({
            'start': t0,
            'end': t1,
            'dur': max(0.001, t1-t0),
            'pitch_hz': pitch_hz,
            'pitch_midi': pitch_midi,
            'amp': amp,
            'centroid': centroid_mean,
            'rolloff': rolloff_mean,
            'pan': pan_mean,
        })

    # fallback: onset-based short events
    if not events:
        onsets = librosa.onset.onset_detect(y=y_mono, sr=sr, hop_length=hop_length)
        ot = librosa.frames_to_time(onsets, sr=sr, hop_length=hop_length)
        for t in ot:
            s = t
            e = min(t+0.4, duration)
            events.append({'start': s, 'end': e, 'dur': e-s, 'pitch_hz': 0.0, 'pitch_midi':0.0, 'amp':0.0, 'centroid':0.0, 'rolloff':0.0, 'pan':0.0})

    # Estimate ADSR per event using RMS envelope within event frames
    # ADSR estimation strategy (robust heuristic): compute envelope, detect peaks
    # and threshold crossings to approximate Attack, Decay, Sustain level, Release
    frame_times = times
    for ev in events:
        s_frame = int(max(0, np.searchsorted(frame_times, ev['start']) - 1))
        e_frame = int(min(len(frame_times)-1, np.searchsorted(frame_times, ev['end']) + 1))
        env = rms[s_frame:e_frame+1]
        t_env = frame_times[s_frame:e_frame+1]
        # normalize
        if env.size == 0 or np.max(env) <= 0:
            # null ADSR
            ev['adsr'] = {
                'attack_dur': 0.0, 'decay_dur':0.0, 'sustain_dur':ev['dur'], 'release_dur':0.0,
                'attack_level':0.0, 'decay_level':0.0, 'sustain_level':0.0, 'release_level':0.0,
                'adsr_polygon': []
            }
            continue
        env_n = env / np.max(env)
        # find attack: first rising to 70% of peak
        peak_idx = int(np.argmax(env_n))
        # attack start index: first index where env > 1% of peak before peak
        attack_start = 0
        for k in range(0, peak_idx):
            if env_n[k] > 0.01:
                attack_start = k
                break
        # attack end: index where env reaches 0.9*peak (or peak)
        attack_end = peak_idx
        for k in range(attack_start, peak_idx+1):
            if env_n[k] >= 0.9:
                attack_end = k
                break
        # decay: from attack_end to first index where env <= sustain_threshold (0.6*peak)
        sustain_threshold = 0.6
        decay_end = peak_idx
        for k in range(attack_end, len(env_n)):
            if env_n[k] <= sustain_threshold:
                decay_end = k
                break
        # sustain: region from decay_end to last index before release begins
        # detect release as when env falls below 20% of peak after sustain
        release_start = len(env_n)-1
        for k in range(len(env_n)-1, -1, -1):
            if env_n[k] > 0.2:
                release_start = k
                break
        # convert to times
        attack_dur = max(0.0, t_env[attack_end] - t_env[attack_start])
        decay_dur = max(0.0, t_env[decay_end] - t_env[attack_end])
        release_dur = max(0.0, t_env[-1] - t_env[release_start])
        sustain_dur = max(0.0, ev['dur'] - (attack_dur + decay_dur + release_dur))
        attack_level = float(env_n[attack_end])
        decay_level = float(env_n[decay_end]) if decay_end < len(env_n) else float(env_n[-1])
        sustain_level = float(np.median(env_n[decay_end:release_start+1])) if release_start>=decay_end else float(env_n[-1])
        release_level = float(env_n[-1])
        # build an ADSR polygon with 5 to 7 points to allow complex pentagon-like shape
        # points expressed as (time_relative, level) with time_relative in [0,dur]
        t0 = 0.0
        tA = attack_dur
        tD = attack_dur + decay_dur
        tS = attack_dur + decay_dur + sustain_dur
        tR = attack_dur + decay_dur + sustain_dur + release_dur
        poly = [
            (t0, 0.0),
            (tA * 0.6, attack_level * 0.6),
            (tA, attack_level),
            (tD, decay_level),
            (tS, sustain_level),
            (tR, release_level),
        ]
        # allow slight randomness in vertical to produce non-regular shapes (artistic)
        poly = [(float(x)+ (np.random.rand()-0.5)*0.001, float(y)*(0.9 + (np.random.rand()-0.5)*0.2)) for x,y in poly]
        ev['adsr'] = {
            'attack_dur': attack_dur,
            'decay_dur': decay_dur,
            'sustain_dur': sustain_dur,
            'release_dur': release_dur,
            'attack_level': attack_level,
            'decay_level': decay_level,
            'sustain_level': sustain_level,
            'release_level': release_level,
            'adsr_polygon': poly,
        }

    # timbre clustering (keep small change)
    X = []
    for ev in events:
        X.append([ev['centroid'], ev['rolloff'], ev['amp']])
    X = np.array(X)
    labels = np.zeros(len(events), dtype=int)
    if X.shape[0] >= 2 and HAS_SK:
        k = min(4, max(1, X.shape[0]//2))
        km = KMeans(n_clusters=k, random_state=0).fit(X)
        labels = km.labels_
    for i, ev in enumerate(events):
        lab = int(labels[i])
        if ev['centroid'] > (fmax*0.6):
            tim = 'bright'
        elif ev['centroid'] < (fmax*0.2):
            tim = 'dark'
        elif ev['amp'] > 0.02:
            tim = 'percussive'
        else:
            tim = 'mid'
        ev['timbre'] = tim
        ev['cluster'] = int(labels[i])

    # Tempo / beat tracking
    # global tempo and local estimation: compute beat times and then local BPM in windows
    try:
        tempo, beat_frames = librosa.beat.beat_track(y=y_mono, sr=sr, hop_length=hop_length)
        beat_times = librosa.frames_to_time(beat_frames, sr=sr, hop_length=hop_length)
    except Exception:
        tempo = 0.0
        beat_times = np.array([])
    # local tempo curve: compute instantaneous BPM from inter-beat intervals
    local_bpm_times = []
    local_bpm = []
    if len(beat_times) >= 2:
        ibis = np.diff(beat_times)
        for i, ibi in enumerate(ibis):
            t = (beat_times[i] + beat_times[i+1]) / 2.0
            bpm = 60.0 / ibi if ibi>0 else 0.0
            local_bpm_times.append(t)
            local_bpm.append(bpm)
    # crude meter estimate: try 4/4 vs 3/4 by autocorrelation of novelty onset strength
    try:
        odf = librosa.onset.onset_strength(y=y_mono, sr=sr, hop_length=hop_length)
        ac = np.correlate(odf - odf.mean(), odf - odf.mean(), mode='full')
        ac = ac[ac.size//2:]
        # look for peaks at ~2x,3x,4x beat lengths -> heuristic
        meter_guess = 4
        # if strong peak at lag corresponding to 3-beat group prefer 3
        # (this is heuristic; reported as estimate)
        # leave meter_guess as integer
    except Exception:
        meter_guess = 4

    analysis = {
        'y_mono': y_mono,
        'sr': sr,
        'n_fft': n_fft,
        'hop': hop_length,
        'times': times,
        'freqs': freqs,
        'S_db': S_db,
        'events': events,
        'beat_times': beat_times,
        'global_tempo': float(tempo),
        'local_bpm_times': np.array(local_bpm_times),
        'local_bpm': np.array(local_bpm),
        'meter_guess': meter_guess,
    }
    return analysis


# ---------- rendering shapes-only square art ----------

def render_detailed_shapes(analysis: dict, out_base: str, size_px=2048, dpi=300):
    events = analysis['events']
    times = analysis['times']
    duration = float(times[-1]) if times.size>0 else 1.0

    fig = plt.figure(figsize=(size_px/dpi, size_px/dpi), dpi=dpi)
    ax = fig.add_axes([0,0,1,1])
    ax.set_facecolor('black')

    patches = []
    colors = []

    # map pitch MIDI (or cluster) to vertical position inside square
    min_midi = 24
    max_midi = 108

    for ev in events:
        # horizontal placement: normalized start..end -> 0..1 (left..right)
        x0 = ev['start'] / duration
        x1 = ev['end'] / duration
        w = max(0.005, x1 - x0)
        # vertical placement by pitch
        m = ev['pitch_midi'] if ev['pitch_midi']>0 else (36 + ev.get('cluster',0)*12)
        y_c = safe_div((m - min_midi),(max_midi - min_midi))
        y_c = np.clip(y_c, 0.0, 1.0)

        # ADSR polygon in normalized local coords
        adsr = ev['adsr']['adsr_polygon']
        # translate polygon points to global coords: x = x0 + (t/dur_local)*w, y = y0 +/- level*scale
        dur_local = ev['dur'] if ev['dur']>0 else 1e-3
        y_scale = 0.08 + ev['amp']*0.6
        y0 = y_c
        poly_pts = []
        for (t_rel, lvl) in adsr:
            gx = x0 + (t_rel / max(dur_local, 1e-6)) * w
            gy = y0 + (lvl - 0.5) * y_scale  # center-level offset for more texture
            poly_pts.append((gx, gy))
        # close polygon with small base to make a shape
        poly_pts.append((x0 + w, y0 - 0.005))
        poly_pts.append((x0, y0 - 0.005))
        poly = Polygon([(p[0], p[1]) for p in poly_pts], closed=True)
        patches.append(poly)

        # color depending on timbre and pan
        tim = ev.get('timbre','mid')
        if tim == 'bright':
            base = np.array([1.0, 0.45, 0.15])
        elif tim == 'dark':
            base = np.array([0.06, 0.02, 0.12])
        elif tim == 'percussive':
            base = np.array([0.95, 0.95, 0.12])
        else:
            base = np.array([0.4, 0.5, 0.85])
        # pan modifies hue left(blue) to right(red) shift
        pan = float(ev.get('pan', 0.0))
        pan = np.clip(pan, -1.0, 1.0)
        pan_shift = np.array([0.2*pan, -0.15*pan, -0.1*pan])
        col = np.clip(base + pan_shift, 0.0, 1.0)
        alpha = np.clip(0.12 + ev['amp']*5.0, 0.06, 0.95)
        colors.append((col[0], col[1], col[2], alpha))

    # add patch collection
    pc = PatchCollection(patches, match_original=True)
    pc.set_facecolor(colors)
    pc.set_edgecolor([ (c[0]*0.7, c[1]*0.7, c[2]*0.7, 0.9) for c in colors])
    pc.set_linewidths([0.5 for _ in patches])
    ax.add_collection(pc)

    # tempo curve: draw as folded polyline at bottom of image (outside main shapes area)
    lb_times = analysis['local_bpm_times']
    lb_vals = analysis['local_bpm']
    if lb_times.size>0 and lb_vals.size>0:
        # normalize and draw polyline under the shapes
        xs = lb_times / duration
        if xs.size>1:
            y_norm = (lb_vals - np.min(lb_vals)) / (np.ptp(lb_vals) + 1e-6)
            # map to small band near bottom
            tempo_y = 0.04 + 0.03 * y_norm
            ax.plot(xs, tempo_y, linewidth=1.2, alpha=0.95, color='white', zorder=50)
            # annotate global tempo
            # ax.text(0.02, 0.02, f"Tempo est.: {analysis['global_tempo']:.1f} BPM", color='white', fontsize=10)

    # numeric meter & summary labels
    # ax.text(0.02, 0.96, f"Meter (estimate): {analysis.get('meter_guess',4)}/4", color='white', fontsize=12)
    # ax.text(0.02, 0.92, f"Events: {len(events)}  Duration: {duration:.2f}s", color='white', fontsize=10)

    ax.set_xlim(0.0, 1.0)
    ax.set_ylim(0.0, 1.0)
    ax.set_xticks([])
    ax.set_yticks([])

    out_png = out_base + '_detailed_art_score.png'
    fig.savefig(out_png, dpi=dpi, facecolor=fig.get_facecolor(), bbox_inches='tight')
    plt.close(fig)
    print('Saved shapes-only square art to', out_png)


# ---------- CSV export ----------

def save_detailed_csv(events: list, out_csv: str):
    keys = ['start','end','dur','pitch_hz','pitch_midi','amp','centroid','rolloff','pan',
            'attack_dur','decay_dur','sustain_dur','release_dur',
            'attack_level','decay_level','sustain_level','release_level','timbre','cluster']
    with open(out_csv, 'w', newline='') as f:
        w = csv.DictWriter(f, fieldnames=keys)
        w.writeheader()
        for ev in events:
            adsr = ev.get('adsr', {})
            row = {
                'start': ev.get('start',''),
                'end': ev.get('end',''),
                'dur': ev.get('dur',''),
                'pitch_hz': ev.get('pitch_hz',''),
                'pitch_midi': ev.get('pitch_midi',''),
                'amp': ev.get('amp',''),
                'centroid': ev.get('centroid',''),
                'rolloff': ev.get('rolloff',''),
                'pan': ev.get('pan',''),
                'attack_dur': adsr.get('attack_dur',''),
                'decay_dur': adsr.get('decay_dur',''),
                'sustain_dur': adsr.get('sustain_dur',''),
                'release_dur': adsr.get('release_dur',''),
                'attack_level': adsr.get('attack_level',''),
                'decay_level': adsr.get('decay_level',''),
                'sustain_level': adsr.get('sustain_level',''),
                'release_level': adsr.get('release_level',''),
                'timbre': ev.get('timbre',''),
                'cluster': ev.get('cluster',''),
            }
            w.writerow(row)
    print('Saved detailed events CSV to', out_csv)


# ---------- CLI ----------

def main(argv=None):
    p = argparse.ArgumentParser(description='Detailed Sonic Pi WAV -> spectral analysis -> shapes-only graphical score')
    p.add_argument('input', help='input WAV file')
    p.add_argument('--out', help='output base path (optional)')
    p.add_argument('--nfft', type=int, default=4096)
    p.add_argument('--hop', type=int, default=512)
    p.add_argument('--sr', type=int, default=44100)
    args = p.parse_args(argv)

    if not os.path.exists(args.input):
        print('Input does not exist:', args.input)
        sys.exit(2)

    base = args.out if args.out else os.path.splitext(os.path.basename(args.input))[0]

    analysis = analyze_file(args.input, sr=args.sr, n_fft=args.nfft, hop_length=args.hop)
    events = analysis['events']
    if events:
        save_detailed_csv(events, base + '_detailed_events.csv')
    render_detailed_shapes(analysis, base)

    if HAS_PRETTY:
        # optional: export MIDI (kept simple)
        try:
            pm = pretty_midi.PrettyMIDI()
            inst = pretty_midi.Instrument(program=0)
            for ev in events:
                start = float(ev['start'])
                end = float(ev['end'])
                pitch = int(round(ev['pitch_midi'])) if ev['pitch_midi']>0 else 60
                vel = int(min(127, max(20, ev['amp']*127)))
                inst.notes.append(pretty_midi.Note(velocity=vel, pitch=pitch, start=start, end=end))
            pm.instruments.append(inst)
            pm.write(base + '_events.mid')
            print('Saved MIDI to', base + '_events.mid')
        except Exception as e:
            print('MIDI export failed:', e)


if __name__ == '__main__':
    main()
