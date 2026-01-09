TOTAL_DURATION = 270.0

define :clamp01 do |x|
  [[x, 0.0].max, 1.0].min
end

define :safe_note do |n|
  [[n, 36].max, 84].min
end

define :adsr_env do |t|
  {
    attack:  t * 0.2,
    decay:   t * 0.2,
    sustain: 0.6,
    release: t * 0.4
  }
end

define :markov_step do |state|
  r = rand
  if r < 0.6
    state
  elsif r < 0.8
    state + 1
  else
    state - 1
  end
end

define :lorenz do |x, y, z|
  sigma = 10.0
  rho   = 28.0
  beta  = 8.0 / 3.0
  dt    = 0.01
  
  nx = x + sigma * (y - x) * dt
  ny = y + (x * (rho - z) - y) * dt
  nz = z + (x * y - beta * z) * dt
  [nx, ny, nz]
end

define :voice do |chan, note, vel, dur|
  n = safe_note(note)
  midi_note_on n, channel: chan, velocity: vel
  sleep dur
  midi_note_off n, channel: chan
end

define :bend do |chan, v|
  midi_pitch_bend (clamp01(v) * 16383).to_i, channel: chan
end

define :cc do |chan, num, v|
  midi_cc num, (clamp01(v) * 127).to_i, channel: chan
end

in_thread do
  use_bpm 42
  x, y, z = 0.1, 0.0, 0.0
  note = 48
  
  t = 0
  while t < TOTAL_DURATION
    x, y, z = lorenz(x, y, z)
    note = markov_step(note)
    env = adsr_env(6)
    
    bend 0, z
    cc   0, 1, y
    
    voice 0, note, 50, 6
    t += 6
  end
end

in_thread do
  use_bpm 56
  state = 60
  t = 0
  
  while t < TOTAL_DURATION
    state = markov_step(state)
    dur = [2, 3, 5].choose
    
    bend 1, rand
    cc   1, 74, rand
    
    voice 1, state, 40, dur
    t += dur
  end
end

in_thread do
  use_bpm 68
  n = 72
  t = 0
  
  while t < TOTAL_DURATION
    n += [-2, 0, 2].choose
    dur = 1.5
    
    bend 2, rand
    cc   2, 10, rand
    
    voice 2, n, 30, dur
    t += dur
  end
end

sleep TOTAL_DURATION