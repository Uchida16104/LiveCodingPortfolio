use_bpm 40

MAX_TIME = (Math::PI ** 2) * 60.0
START_TIME = vt

MIDI_CH_1 = 0
MIDI_CH_2 = 1
MIDI_CH_3 = 2

define :phi do |n|
  (1.0 + Math.sqrt(5)) ** n / (2.0 ** n)
end

define :log_wave do |n|
  Math.log(n + 1.0)
end

define :trig_lattice do |n|
  Math.sin(n) + Math.cos(n / 2.0)
end

define :zeta_like do |n|
  1.0 / ((n + 1.0) ** 2)
end

define :bounded_velocity do |x|
  v = (x * 40.0).to_i + 20
  [[v, 15].max, 100].min
end

live_loop :bass_plane do
  n = tick + 1
  break if (vt - START_TIME) > MAX_TIME
  
  note = 36 + (phi(n) % 12).to_i
  vel  = bounded_velocity(zeta_like(n))
  
  midi_cc 1, (log_wave(n) * 20).to_i, channel: MIDI_CH_1
  midi_note_on note, vel, channel: MIDI_CH_1
  
  sleep 3.5
  
  midi_note_off note, channel: MIDI_CH_1
end

live_loop :mid_orbit do
  n = tick + 1
  break if (vt - START_TIME) > MAX_TIME
  
  angle = trig_lattice(n)
  note  = 60 + ((angle * 7).to_i % 12)
  vel   = bounded_velocity((angle).abs)
  
  midi_cc 10, ((Math.sin(n / 3.0) + 1.0) * 63).to_i, channel: MIDI_CH_2
  midi_note_on note, vel, channel: MIDI_CH_2
  
  sleep 2.2
  
  midi_note_off note, channel: MIDI_CH_2
end

live_loop :high_points do
  n = tick + 1
  break if (vt - START_TIME) > MAX_TIME
  
  radial = Math.sqrt(n)
  note   = 72 + (radial.to_i % 12)
  vel    = bounded_velocity(1.0 / (radial + 1.0))
  
  midi_cc 74, ((Math.cos(n / 4.0) + 1.0) * 50).to_i, channel: MIDI_CH_3
  midi_note_on note, vel, channel: MIDI_CH_3
  
  sleep 1.3
  
  midi_note_off note, channel: MIDI_CH_3
end

live_loop :time_guard do
  if (vt - START_TIME) > MAX_TIME
    stop
  end
  sleep 1
end