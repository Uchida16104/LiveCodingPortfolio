# Safe, runnable Sonic Pi script (runs for 300 seconds)
use_bpm 120

# ---------- MIDI logging helper ----------
define :log_midi do |time, note, velocity, params_hash|
  params = params_hash || {}
  attack           = params[:attack]           || 0.0
  attack_level     = params[:attack_level]     || 0.0
  decay            = params[:decay]            || 0.0
  decay_level      = params[:decay_level]      || 0.0
  sustain          = params[:sustain]          || 0.0
  sustain_level    = params[:sustain_level]    || 0.0
  release          = params[:release]          || 0.0
  amp              = params[:amp]              || 0.0
  mix              = params[:mix]              || 0.0
  pan              = params[:pan]              || 0.0
  pitch            = params[:pitch]            || 0.0
  cutoff           = params[:cutoff]           || 0.0
  stereo_width     = params[:stereo_width]     || 0.0
  hard             = params[:hard]             || 0.0
  fx_summary       = params[:fx_summary]       || ""

  # Append to /tmp/midi_log.csv (Sonic Pi on macOS/Linux can write here)
  File.open("/tmp/midi_log.csv", "a") do |f|
    f.puts [
      time,
      note,
      velocity,
      attack,
      attack_level,
      decay,
      decay_level,
      sustain,
      sustain_level,
      release,
      amp,
      mix,
      pan,
      pitch,
      cutoff,
      stereo_width,
      hard,
      fx_summary
    ].join(",")
  end
end

live_loop :midi_logger do
  use_real_time
  # sync returns [note, velocity, channel, device] depending on Sonic Pi version
  n, v = sync "/midi:*/note_on"
  # read current params stored by playback threads (safe default to empty hash)
  params = get(:current_params) || {}
  log_midi(Time.now.to_f, n, v, params)
end

# ---------- Presets ----------
ADSR_FX_PRESETS = {
  ambient: {
    adsr: {attack:2.5, attack_level:1.0, decay:1.5, decay_level:0.8, sustain:0.8, sustain_level:0.8, release:4.0},
    amp:0.8, mix:0.6, pan:0, pitch:0, cutoff:80, stereo_width:0.9, hard:0.2,
    fx: {
      reverb:{mix:0.6, room:0.9},
      echo:{mix:0.2, phase:0.75},
      flanger:{mix:0.1, phase:0.25},
      tremolo:{mix:0.15, phase:2.0},
      compressor:{pre_amp:1.0, threshold:0.5}
    }
  },
  techno: {
    adsr:{attack:0.01, attack_level:1.0, decay:0.2, decay_level:0.5, sustain:0.5, sustain_level:0.5, release:0.3},
    amp:1.2, mix:0.5, pan:-0.3, pitch:0, cutoff:120, stereo_width:0.5, hard:0.8,
    fx:{
      reverb:{mix:0.3, room:0.4},
      echo:{mix:0.1, phase:0.25},
      distortion:{distort:0.2},
      ixi_techno:{phase:0.5, cutoff:80},
      slicer:{phase:0.25, probability:0.5}
    }
  },
  experimental:{
    adsr:{attack:1.0, attack_level:1.0, decay:2.0, decay_level:0.5, sustain:0.5, sustain_level:0.5, release:3.5},
    amp:0.8, mix:0.7, pan:0, pitch:0, cutoff:70, stereo_width:1.0, hard:0.5,
    fx:{reverb:{mix:0.9, room:1.0}, echo:{mix:0.4, phase:0.8}, flanger:{mix:0.5, phase:0.7}, slicer:{phase:0.4, probability:0.7}}
  },
  jazz:{
    adsr:{attack:0.3, attack_level:1.0, decay:0.6, decay_level:0.7, sustain:0.7, sustain_level:0.7, release:1.0},
    amp:0.9, mix:0.5, pan:0.1, pitch:0, cutoff:100, stereo_width:0.6, hard:0.3,
    fx:{reverb:{mix:0.5, room:0.8}, echo:{mix:0.2, phase:0.3}, flanger:{mix:0.1, phase:0.4}}
  },
  glitch:{
    adsr:{attack:0.2, attack_level:1.0, decay:0.5, decay_level:0.5, sustain:0.5, sustain_level:0.5, release:1.0},
    amp:0.8, mix:0.7, pan:0, pitch:0, cutoff:100, stereo_width:0.7, hard:0.6,
    fx:{reverb:{mix:0.6, room:0.8}, echo:{mix:0.3, phase:0.6}, flanger:{mix:0.3, phase:0.5}, slicer:{phase:0.2, probability:0.7}}
  }
}
# ---------- Helpers ----------
define :clamp do |val, lo, hi|
  return lo if val != val # NaN guard
  v = val.nil? ? lo : val.to_f
  if v.respond_to?(:nan?) && (v.nan? || v.infinite?)
    lo
  else
    [[v, lo].max, hi].min
  end
end

define :clamp_int do |val, lo, hi|
  clamp(val.round, lo, hi)
end

define :note_to_midi_safe do |note|
  nm = 60
  begin
    nm = note_to_midi(note)
  rescue StandardError
    nm = 60
  end
  clamp_int(nm, 0, 127)
end

define :pitch_semitones_to_bend do |semitones|
  semitones = clamp(semitones.to_f, -48.0, 48.0)
  bend = (semitones / 48.0) * 8191.0
  clamp_int(bend, -8192, 8191)
end

define :midi_cc_safe do |cc_val|
  clamp_int(cc_val, 0, 127)
end

define :midi_velocity_safe do |v|
  clamp_int(v, 0, 127)
end

define :phase_safe do |p|
  clamp(p.to_f, 0.01, 16.0)
end

define :safe_fx do |fx_hash|
  fx_hash ||= {}
  {
    reverb: {mix: (fx_hash.dig(:reverb, :mix) || 0.0).to_f, room: (fx_hash.dig(:reverb, :room) || 0.0).to_f},
    echo: {mix: (fx_hash.dig(:echo, :mix) || 0.0).to_f, phase: phase_safe(fx_hash.dig(:echo, :phase) || 0.25)},
    flanger: {mix: (fx_hash.dig(:flanger, :mix) || 0.0).to_f, phase: phase_safe(fx_hash.dig(:flanger, :phase) || 0.25)},
    tremolo: {mix: (fx_hash.dig(:tremolo, :mix) || 0.0).to_f, phase: phase_safe(fx_hash.dig(:tremolo, :phase) || 1.0)},
    distortion: {distort: clamp((fx_hash.dig(:distortion, :distort) || 0.0).to_f, 0.0, 1.0)},
    compressor: {pre_amp: (fx_hash.dig(:compressor, :pre_amp) || 1.0).to_f, threshold: clamp((fx_hash.dig(:compressor, :threshold) || 0.5).to_f, 0.0, 1.0)},
    slicer: {phase: phase_safe(fx_hash.dig(:slicer, :phase) || 0.25), probability: clamp((fx_hash.dig(:slicer, :probability) || 0.0).to_f, 0.0, 1.0)}
  }
end

define :get_full_preset_safe do |genre|
  g = genre.to_sym rescue :ambient
  base = ADSR_FX_PRESETS.has_key?(g) ? ADSR_FX_PRESETS[g] : ADSR_FX_PRESETS[:ambient]
  adsr = base[:adsr] || {}
  fx_safe = safe_fx(base[:fx])
  {
    adsr: {
      attack: clamp(adsr[:attack] || 0.01, 0.0, 64.0),
      attack_level: clamp(adsr[:attack_level] || 1.0, 0.0, 10.0),
      decay: clamp(adsr[:decay] || 0.1, 0.0, 64.0),
      decay_level: clamp(adsr[:decay_level] || 1.0, 0.0, 10.0),
      sustain: clamp(adsr[:sustain] || 0.5, 0.0, 64.0),
      sustain_level: clamp(adsr[:sustain_level] || 1.0, 0.0, 10.0),
      release: clamp(adsr[:release] || 0.5, 0.0, 128.0)
    },
    amp: clamp(base[:amp] || 1.0, 0.0, 16.0),
    mix: clamp(base[:mix] || 0.0, 0.0, 1.0),
    pan: clamp(base[:pan] || 0.0, -1.0, 1.0),
    pitch: clamp(base[:pitch] || 0.0, -48.0, 48.0),
    cutoff: clamp(base[:cutoff] || 130.0, 10.0, 130.0),
    stereo_width: clamp(base[:stereo_width] || 1.0, 0.0, 1.0),
    hard: clamp(base[:hard] || 0.0, 0.0, 1.0),
    fx: fx_safe
  }
end

# ---------- Math parameter generators ----------
define :safe_real do |x|
  begin
    return x.abs.to_f if x.is_a?(Complex)
    return x.to_f
  rescue StandardError
    0.0
  end
end

define :math_rhythm do |t|
  v = 0.0
  begin
    v += Math.sin(t) if t
    v += Math.cos(t / Math::PI) if t
    v += Math.sin((t**2) / Math::E) if t
    v += Math.log([t.abs, 1].max)
  rescue StandardError
    v = 0.0
  end
  v = safe_real(v)
  base = (v % 1.5) + 0.25
  clamp(base, 0.125, 2.0)
end

define :math_pitch do |t|
  m = [[1, 2], [3, 5]]
  val = 0.0
  begin
    val = (m[0][0]*Math.sin(t) + m[1][1]*Math.cos(t/Math::E)) * Math.exp(Math.tan(t/Math::PI))
  rescue StandardError
    val = 0.0
  end
  val = safe_real(val)
  base_scale_note = choose(scale (chord rrand_i(36, 84), :add2).shuffle.tick, :minor_pentatonic)
  offset = (val % 12).to_i
  note = note_to_midi_safe(base_scale_note) + offset
  clamp_int(note, 0, 127)
end
define :math_amp do |t|
  val = 0.0
  begin
    val = (Math.log([t + 1, 1].max) / (t + 1)) ** 2
  rescue StandardError
    val = 0.0
  end
  val = safe_real(val)
  clamp(val.abs, 0.01, 1.0)
end

define :math_pan do |t|
  begin
    c = Complex(Math.sin(t), Math.cos(t)) + 2
    p = Math.sin(c.arg)
  rescue StandardError
    p = 0.0
  end
  clamp(p.to_f, -1.0, 1.0)
end

# ---------- MIDI helper that sends harmonized, clamped messages ----------
define :send_midi_controls do |note_midi, amp, pan, preset, pitch_semitones|
  note_midi = clamp_int(note_midi, 0, 127)
  velocity = midi_velocity_safe((amp * preset[:amp] * 127).round)
  # Build a compact summary of fx for logging
  fx_summary = preset[:fx].map { |k,v| "#{k}=#{(v[:mix] || v[:distort] || 0).to_f.round(3)}" }.join(";")
  # Store current params into a thread-safe container so midi_logger can access them
  set :current_params, {
    attack: preset[:adsr][:attack],
    attack_level: preset[:adsr][:attack_level],
    decay: preset[:adsr][:decay],
    decay_level: preset[:adsr][:decay_level],
    sustain: preset[:adsr][:sustain],
    sustain_level: preset[:adsr][:sustain_level],
    release: preset[:adsr][:release],
    amp: amp * preset[:amp],
    mix: preset[:mix],
    pan: pan + preset[:pan],
    pitch: preset[:pitch] + pitch_semitones,
    cutoff: preset[:cutoff],
    stereo_width: preset[:stereo_width],
    hard: preset[:hard],
    fx_summary: fx_summary
  }
  # send MIDI and CCs
  midi_note_on note_midi, velocity
  bend = pitch_semitones_to_bend(preset[:pitch] + pitch_semitones)
  midi_pitch_bend bend
  midi_cc 1, midi_cc_safe((amp * 127).round)
  midi_cc 10, midi_cc_safe(((pan + preset[:pan]) * 63.5 + 63.5).round)
  midi_cc 64, midi_cc_safe((preset[:adsr][:sustain] * 127).round)
  midi_cc 72, midi_cc_safe((preset[:adsr][:release] * 127 / 8.0).round)
  midi_cc 73, midi_cc_safe((preset[:adsr][:attack] * 127 / 8.0).round)
  midi_cc 74, midi_cc_safe((preset[:cutoff] / 130.0 * 127).round)
  midi_cc 75, midi_cc_safe((preset[:adsr][:decay] * 127 / 8.0).round)
end

define :stop_midi_note do |note_midi|
  note_midi = clamp_int(note_midi, 0, 127)
  midi_note_off note_midi
end

# ---------- Playback threads ----------
i = 0
start_time = Time.now

# Thread A: dynamic/genre-cycling lead
in_thread(name: :lead_thread) do
  begin
    while (Time.now - start_time) < 300.0
      genre = ADSR_FX_PRESETS.keys.tick
      preset = get_full_preset_safe(genre)
      t = i / 4.0 + (Math::PI / 3.0)
      note_midi = math_pitch(t)
      amp = math_amp(t) * 1.0
      pan = math_pan(t)
      r = math_rhythm(t)
      amp_sl = clamp(Math.sin(Time.now.to_f) + 1.0, 0.01, 4.0)
      pan_sl = clamp(ring(-1, 1).choose.abs, 0.0, 1.0)
      pitch_sl = clamp(Math.sin(Time.now.to_f) * 2.0, -12.0, 12.0)

      fx = preset[:fx]

      with_fx :reverb, mix: clamp(fx[:reverb][:mix], 0.0, 1.0), room: clamp(fx[:reverb][:room], 0.0, 1.0) do
        with_fx :echo, mix: clamp(fx[:echo][:mix], 0.0, 1.0), phase: phase_safe(fx[:echo][:phase]) do
          with_fx :flanger, mix: clamp(fx[:flanger][:mix], 0.0, 1.0), phase: phase_safe(fx[:flanger][:phase]) do
            with_fx :tremolo, mix: clamp(fx[:tremolo][:mix], 0.0, 1.0), phase: phase_safe(fx[:tremolo][:phase]) do
              with_fx :distortion, distort: clamp(fx[:distortion][:distort] || 0.0, 0.0, 1.0) do
                with_fx :compressor, pre_amp: clamp(fx[:compressor][:pre_amp], 0.1, 8.0), threshold: clamp(fx[:compressor][:threshold], 0.0, 1.0) do
                  use_synth :piano
                  synth_opts = {
                    note: note_midi,
                    amp: clamp(amp * preset[:amp] * amp_sl, 0.01, 16.0),
                    pan: clamp(pan + preset[:pan] + pan_sl - 0.5, -1.0, 1.0),
                    attack: clamp(preset[:adsr][:attack] * 1.0, 0.0, 64.0),
                    decay: clamp(preset[:adsr][:decay] * 1.0, 0.0, 64.0),
                    sustain: clamp(preset[:adsr][:sustain] * 1.0, 0.0, 64.0),
                    release: clamp(preset[:adsr][:release] * 1.0, 0.0, 128.0),
                    cutoff: clamp(preset[:cutoff], 10, 130)
                  }
                  s = synth :piano, synth_opts
                  # update current params and send MIDI controls
                  send_midi_controls(note_midi, amp * amp_sl, pan + pan_sl, preset, pitch_sl)
                  sleep r
                  control s,
                    amp: clamp(Math.sin(Time.now.to_f).abs + 0.1, 0.01, 16.0),
                    pan: clamp(ring(-1,1).choose, -1.0, 1.0),
                    note: clamp_int((note_midi + (Math.cos(Time.now.to_f) * 6)).round, 0, 127)
                  stop_midi_note(clamp_int((note_midi + (Math.sin(Time.now.to_f) * 6)).round, 0, 127))
                end
              end
            end
          end
        end
      end
      i += 1
    end
  rescue StandardError => e
    puts "Lead thread error: #{e.class}: #{e.message}"
  ensure
    (0..127).each_slice(16) do |slice|
      slice.each do |n|
        midi_note_off n
      end
    end
  end
end

# Thread B: ambient pad / foundation (fixed genre ambient)
in_thread(name: :pad_thread) do
  begin
    preset = get_full_preset_safe(:ambient)
    loop_tick = 0
    while (Time.now - start_time) < 300.0
      n_note = (scale (chord rrand_i(36, 84), :add2).shuffle.tick, :minor_pentatonic).tick(:pad_tick)
      note_midi = note_to_midi_safe(n_note)
      t = (tick(:pad_time).to_f / 3.0) + Math::PI / 6.0
      a = clamp(math_amp(t) * 0.6, 0.01, 1.0)
      p = clamp(math_pan(t) * 0.3, -1.0, 1.0)
      r = clamp(math_rhythm(t) * 1.5, 0.25, 4.0)
      amp_sl = clamp(Math.cos(Time.now.to_f) + 1.0, 0.01, 4.0)
      pan_sl = clamp(Math.sin(Time.now.to_f), -1.0, 1.0)

      pitch_option = []
      (1..8).each do |den|
        (1..den).each do |num|
          value = num.to_f / den
          pitch_option << clamp(value, -48.0, 48.0)
          pitch_option << clamp(-value, -48.0, 48.0)
        end
      end
      chosen_pitch = pitch_option.choose
      fx = preset[:fx]
      with_fx :reverb, mix: clamp(fx[:reverb][:mix] * 0.5, 0.0, 1.0), room: clamp(fx[:reverb][:room] * 0.8, 0.0, 1.0) do
        with_fx :echo, mix: clamp(fx[:echo][:mix] * 0.4, 0.0, 1.0), phase: phase_safe(fx[:echo][:phase]) do
          with_fx :compressor, pre_amp: clamp(fx[:compressor][:pre_amp], 0.1, 8.0), threshold: clamp(fx[:compressor][:threshold], 0.0, 1.0) do
            use_synth :piano
            s = synth :piano,
              note: note_midi,
              amp: clamp(a * preset[:amp] * amp_sl, 0.01, 16.0),
              pan: clamp(p + preset[:pan] + pan_sl, -1.0, 1.0),
              attack: clamp(preset[:adsr][:attack] * 0.5, 0.0, 64.0),
              decay: clamp(preset[:adsr][:decay] * 0.7, 0.0, 64.0),
              sustain: clamp(preset[:adsr][:sustain] * 1.5, 0.0, 128.0),
              release: clamp(preset[:adsr][:release] * 1.2, 0.0, 128.0),
              cutoff: clamp(preset[:cutoff] * 0.8, 10, 130)
            send_midi_controls(note_midi, a * amp_sl, p + pan_sl, preset, chosen_pitch)
            sleep r
            midi_note_off note_midi
            control s,
              amp: clamp(Math.cos(Time.now.to_f).abs + 0.05, 0.01, 16.0),
              pan: clamp(ring(-0.3, 0.0, 0.3).choose, -1.0, 1.0),
              note: clamp_int((note_midi + Math.sin(Time.now.to_f) * 2).round, 0, 127)
            midi_cc 10, midi_cc_safe((p + pan_sl + 1.0) / 2.0 * 127)
          end
        end
      end
      loop_tick += 1
    end
  rescue StandardError => e
    puts "Pad thread error: #{e.class}: #{e.message}"
  ensure
    (0..127).each_slice(16) do |slice|
      slice.each do |n|
        midi_note_off n
      end
    end
  end
end

# Master safety monitor: after 300 seconds, ensure all sound and MIDI are silenced
in_thread(name: :master_kill) do
  remaining = 300.0 - (Time.now - start_time)
  sleep clamp(remaining, 0.0, 300.0)
  (0..127).each_slice(16) do |slice|
    slice.each do |n|
      midi_note_off n
    end
  end
  midi_cc 1, 0
  midi_cc 10, 64
  midi_cc 64, 0
  midi_pitch_bend 0
  use_synth :piano
  synth :piano, note: 0, amp: 0.0001, attack: 0.01, release: 0.01
  puts "Playback finished: 300 seconds elapsed. All MIDI notes and CCs reset."
end
