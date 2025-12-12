# WAVE2SCORE

### <i>Detailed Sonic Pi WAV Spectral Analyzer and Graphical Score</i>

This script performs STFT + F0 tracking + frame features, and runs:
 - stereo-aware pan estimation (if input is stereo; mono fallback)
 - per-event ADSR estimation (attack/decay/sustain/release durations and levels)
 - using frame RMS envelope analysis and poly-shape fitting (produces complex polygonal ADSR representations rather than simple triangles)
 - tempo-over-time estimation (local tempo curve) and a numeric meter estimate
 - rhythm, melody, harmony, texture, form and tonality heuristics
 - outputs: <base>_detailed_events.csv, <base>_detailed_art_score.png

## Design notes
- Uses librosa + numpy + matplotlib. sklearn and pretty_midi remain optional.
- Avoids spectral-image exports in the main art score: it draws shapes only on a square canvas as requested.

## Usage
    python3 main.py /path/to/file.wav

## Outputs
- `<base>_detailed_events.csv`  (per-event with ADSR/pan/tempo/more)
- `<base>_detailed_art_score.png`  (square, shapes-only avant-garde score)

Developed on: <i><strong>12th, Dec., 2025</strong></i><br />
Author: <i><strong>Hirotoshi Uchida</strong></i>
