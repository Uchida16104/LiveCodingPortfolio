# Algorhythmic Synthesis Generated Code
# Configuration: lorenz + ringmod + minimalism + avantgarde

use_bpm 66

n = 300

start_time = vt

# Mathematical System: lorenz
lorenz_x = 0.1
lorenz_y = 0.0
lorenz_z = 0.0

define :lorenz_step do |x, y, z|
  dt = 0.01
  [x + 10 * (y - x) * dt,
   y + (x * (28 - z) - y) * dt,
   z + (x * y - 2.67 * z) * dt]
end

# Physics Effect: ringmod
define :ring_mod do |f1, f2|
  [(f1 + f2).abs, (f1 - f2).abs]
end

# Historical Form: minimalism
pattern = [rrand_i(60, 72), rrand_i(60, 72), rrand_i(60, 72), rrand_i(60, 72)]

define :phase_shift do |pattern, offset|
  pattern.rotate(offset)
end

# Art Movement: avantgarde
define :experimental_gesture do
  notes = (36..96).to_a.sample(rand(3..8))
  durations = Array.new(notes.length) { rrand(0.1, 2.0) }
  [notes, durations]
end

# Main Performance (15 channels)

live_loop :voice_1 do
  
  while vt - start_time >= n do
    stop
  end
  
  use_midi_defaults channel: 1, port: "iacdriver_bus1"
  
  with_fx :reverb, room: 0.57 do
    midi 60 + rand_i(12), velocity: 70 + rand_i(20), sustain: 0.5
    sleep 0.5
  end
  
  sleep 1.8
end

live_loop :voice_2 do
  
  while vt - start_time >= n do
    stop
  end
  
  use_midi_defaults channel: 2, port: "iacdriver_bus2"
  
  with_fx :reverb, room: 0.36 do
    scale(rrand_i(60, 72), scale_names[rrand_i(0, scale_names.length-1)]).each do |n|
      midi n, velocity: 80, sustain: 0.25
      sleep 0.25
    end
  end
  
  sleep 1.6
end

live_loop :voice_3 do
  
  while vt - start_time >= n do
    stop
  end
  
  use_midi_defaults channel: 3, port: "iacdriver_bus3"
  
  with_fx :reverb, room: 0.52 do
    [rrand_i(60, 72), rrand_i(60, 72), rrand_i(60, 72), rrand_i(60, 72)].each do |n|
      midi n, velocity: 75, sustain: 1.5
      sleep 0.1
    end
  end
  
  sleep 3.6
end

live_loop :voice_4 do
  
  while vt - start_time >= n do
    stop
  end
  
  use_midi_defaults channel: 4, port: "iacdriver_bus4"
  
  with_fx :reverb, room: 0.34 do
    10.times do
      midi 60 + rand_i(24), velocity: 60 + rand_i(30), sustain: 0.3
      sleep rrand(0.1, 0.5)
    end
  end
  
  sleep 1.1
end

live_loop :voice_5 do
  
  while vt - start_time >= n do
    stop
  end
  
  use_midi_defaults channel: 5, port: "iacdriver_bus5"
  
  with_fx :reverb, room: 0.42 do
    midi 60 + rand_i(12), velocity: 70 + rand_i(20), sustain: 0.5
    sleep 0.5
  end
  
  sleep 2.1
end

live_loop :voice_6 do
  
  while vt - start_time >= n do
    stop
  end
  
  use_midi_defaults channel: 6, port: "iacdriver_bus6"
  
  with_fx :reverb, room: 0.36 do
    scale(rrand_i(60, 72), scale_names[rrand_i(0, scale_names.length-1)]).each do |n|
      midi n, velocity: 80, sustain: 0.25
      sleep 0.25
    end
  end
  
  sleep 2.4
end

live_loop :voice_7 do
  
  while vt - start_time >= n do
    stop
  end
  
  use_midi_defaults channel: 7, port: "iacdriver_bus7"
  
  with_fx :reverb, room: 0.78 do
    [rrand_i(60, 72), rrand_i(60, 72), rrand_i(60, 72), rrand_i(60, 72)].each do |n|
      midi n, velocity: 75, sustain: 1.5
      sleep 0.1
    end
  end
  
  sleep 1.8
end

live_loop :voice_8 do
  
  while vt - start_time >= n do
    stop
  end
  
  use_midi_defaults channel: 8, port: "iacdriver_bus8"
  
  with_fx :reverb, room: 0.42 do
    10.times do
      midi 60 + rand_i(24), velocity: 60 + rand_i(30), sustain: 0.3
      sleep rrand(0.1, 0.5)
    end
  end
  
  sleep 2.4
end

live_loop :voice_9 do
  
  while vt - start_time >= n do
    stop
  end
  
  use_midi_defaults channel: 9, port: "iacdriver_bus9"
  
  with_fx :reverb, room: 0.36 do
    midi 60 + rand_i(12), velocity: 70 + rand_i(20), sustain: 0.5
    sleep 0.5
  end
  
  sleep 1.1
end

live_loop :voice_10 do
  
  while vt - start_time >= n do
    stop
  end
  
  use_midi_defaults channel: 10, port: "iacdriver_bus10"
  
  with_fx :reverb, room: 0.47 do
    scale(rrand_i(60, 72), scale_names[rrand_i(0, scale_names.length-1)]).each do |n|
      midi n, velocity: 80, sustain: 0.25
      sleep 0.25
    end
  end
  
  sleep 3.8
end

live_loop :voice_11 do
  
  while vt - start_time >= n do
    stop
  end
  
  use_midi_defaults channel: 11, port: "iacdriver_bus11"
  
  with_fx :reverb, room: 0.43 do
    [rrand_i(60, 72), rrand_i(60, 72), rrand_i(60, 72), rrand_i(60, 72)].each do |n|
      midi n, velocity: 75, sustain: 1.5
      sleep 0.1
    end
  end
  
  sleep 3.0
end

live_loop :voice_12 do
  
  while vt - start_time >= n do
    stop
  end
  
  use_midi_defaults channel: 12, port: "iacdriver_bus12"
  
  with_fx :reverb, room: 0.47 do
    10.times do
      midi 60 + rand_i(24), velocity: 60 + rand_i(30), sustain: 0.3
      sleep rrand(0.1, 0.5)
    end
  end
  
  sleep 1.6
end

live_loop :voice_13 do
  
  while vt - start_time >= n do
    stop
  end
  
  use_midi_defaults channel: 13, port: "iacdriver_bus13"
  
  with_fx :reverb, room: 0.50 do
    midi 60 + rand_i(12), velocity: 70 + rand_i(20), sustain: 0.5
    sleep 0.5
  end
  
  sleep 2.3
end

live_loop :voice_14 do
  
  while vt - start_time >= n do
    stop
  end
  
  use_midi_defaults channel: 14, port: "iacdriver_bus14"
  
  with_fx :reverb, room: 0.63 do
    scale(rrand_i(60, 72), scale_names[rrand_i(0, scale_names.length-1)]).each do |n|
      midi n, velocity: 80, sustain: 0.25
      sleep 0.25
    end
  end
  
  sleep 3.4
end

live_loop :voice_15 do
  
  while vt - start_time >= n do
    stop
  end
  
  use_midi_defaults channel: 15, port: "iacdriver_bus15"
  
  with_fx :reverb, room: 0.45 do
    [rrand_i(60, 72), rrand_i(60, 72), rrand_i(60, 72), rrand_i(60, 72)].each do |n|
      midi n, velocity: 75, sustain: 1.5
      sleep 0.1
    end
  end
  
  sleep 2.9
end

puts "Algorhythmic Synthesis: 15 voices active"