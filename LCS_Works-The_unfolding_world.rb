use_debug false

$running = true

define :clamp do |x, lo, hi|
  [[x, lo].max, hi].min
end

define :prime? do |n|
  n = n.to_i.abs
  return false if n < 2
  return true  if n == 2
  return false if n.even?
  i = 3
  while i * i <= n
    return false if n % i == 0
    i += 2
  end
  true
end

define :fib do |n|
  a = 0
  b = 1
  n.to_i.times do
    a, b = b, a + b
  end
  a
end

define :phi do
  1.618033988749895
end

define :collatz_len do |n|
  x = n.to_i.abs + 1
  c = 0
  while x != 1 && c < 256
    x = (x.even? ? x / 2 : 3 * x + 1)
    c += 1
  end
  c
end

define :logistic_iter do |x, r=3.91, steps=1|
  y = x.to_f
  steps.to_i.times do
    y = r * y * (1.0 - y)
  end
  y
end

define :mandel_iter do |cr, ci, max=16|
  z = Complex(0, 0)
  c = Complex(cr.to_f, ci.to_f)
  i = 0
  while i < max && z.abs2 <= 4.0
    z = z * z + c
    i += 1
  end
  i
end

define :lstep do |s|
  s.chars.map do |ch|
    case ch
    when "A" then "AB"
    when "B" then "A"
    else ch
    end
  end.join
end

define :ca_step do |cells|
  cells.map.with_index do |c, i|
    l = cells[(i - 1) % cells.length]
    r = cells[(i + 1) % cells.length]
    case [l, c, r].join
    when "111" then 0
    when "110" then 1
    when "101" then 1
    when "100" then 0
    when "011" then 1
    when "010" then 1
    when "001" then 1
    when "000" then 0
    end
  end
end

define :markov_next do |state|
  table = {
    A: [:A, :B, :C, :A],
    B: [:B, :C, :D],
    C: [:A, :C, :D],
    D: [:B, :D, :A]
  }
  table[state].choose
end

define :euclid_on do |k, steps, hits|
  spread(hits, steps)[k % steps]
end

set :cells, [0, 1, 0, 0, 1, 0, 1, 0, 0]
set :field, Array.new(16, 0.37)
set :markov, :A
set :lsys, "A"

live_loop :guardian do
  sleep 300
  $running = false
  cue :halt
  stop
end

live_loop :pad_54 do
  stop unless $running
  use_bpm 54
  
  while $running do
    lsys = get(:lsys)
    lsys = lstep(lsys)
    lsys = lsys[-48, 48] || lsys
    set :lsys, lsys
    
    deg = lsys.length % 8
    scale_notes = scale(:e3, :minor_pentatonic)
    base_note = scale_notes[deg]
    tritone_note = base_note + 6
    
    f = fib(lsys.length % 10)
    ampv = clamp(0.07 + (f % 5) * 0.015, 0.03, 0.16)
    cutoffv = clamp(70 + (phi * (lsys.count("A") + 1)) % 35, 60, 110)
    
    with_fx :reverb, room: 0.92, mix: 0.38 do
    with_fx :echo, phase: 0.375, decay: 6, mix: 0.20 do
    synth :hollow, note: base_note,     sustain: 1.6, release: 2.4, amp: ampv,       cutoff: cutoffv, pan: -0.08
    synth :hollow, note: base_note + 0.2, sustain: 1.6, release: 2.4, amp: ampv * 0.7, cutoff: cutoffv, pan:  0.08
    synth :tri,    note: tritone_note,   sustain: 0.9, release: 1.8, amp: ampv * 0.45, cutoff: cutoffv + 8, pan: 0
    midi base_note.to_i, channel: 1, velocity: 42, sustain: 1.2
  end
end

sleep 1
end

stop
end

live_loop :bass_60 do
  stop unless $running
  use_bpm 60
  
  while $running do
    step = tick(:bass_step)
    cells = get(:cells)
    field = get(:field)
    
    on = euclid_on(step, 16, 5)
    
    if on
      c = cells[step % cells.length]
      c_factor = c == 1 ? 1 : 0
      coll = collatz_len(step + 17)
      root = (scale :e2, :minor_pentatonic)[(coll + c_factor) % 5]
      
      logi = logistic_iter(0.37 + step * 0.01, 3.9, 3)
      vel  = clamp((48 + logi * 30).to_i, 30, 80)
      
      with_fx :compressor, threshold: 0.25, slope_above: 0.5, mix: 1 do
        sample :bd_haus, amp: 0.38, cutoff: 90
        synth :sine, note: root, attack: 0.01, release: 0.35, amp: 0.14, pan: -0.05
        midi root.to_i, channel: 2, velocity: vel, sustain: 0.22
      end
    end
    
    if step % 16 == 15
      set :cells, ca_step(cells)
      
      new_field = field.each_with_index.map do |x, i|
        l = field[(i - 1) % field.length]
        r = field[(i + 1) % field.length]
        v = x + 0.04 * (l - 2 * x + r) + 0.005 * Math.sin((i + x) * Math::PI)
        clamp(v, 0.0, 1.0)
      end
      set :field, new_field
      set :markov, markov_next(get(:markov))
    end
    
    sleep 0.25
  end
  
  stop
end

live_loop :arp_66 do
  stop unless $running
  use_bpm 66
  
  while $running do
    step = tick(:arp_step)
    field = get(:field)
    mark = get(:markov)
    
    on = euclid_on(step, 20, 7)
    
    if on
      x = field[step % field.length]
      mand = mandel_iter(Math.sin(step * 0.31) * 0.65, Math.cos(step * 0.23) * 0.65, 14)
      
      notes = scale(:a3, :minor_pentatonic)
      idx = (mand + step + (x * 9).to_i) % notes.length
      n = notes[idx]
      
      ampv = clamp(0.06 + x * 0.08, 0.04, 0.16)
      cut  = clamp(68 + mand * 3 + x * 20, 60, 120)
      
      with_fx :slicer, phase: 0.2, mix: 0.18, wave: 1 do
        with_fx :echo, phase: 0.25, decay: 5, mix: 0.16 do
          synth :pulse, note: n, release: 0.16, amp: ampv, cutoff: cut, pan: (mark == :A ? -0.18 : 0.18)
          midi n.to_i, channel: 3, velocity: clamp(50 + mand, 30, 90), sustain: 0.1
          sample :elec_blip, rate: [0.5, 1, 1.5].choose, amp: 0.05, pan: 0.25
        end
      end
    end
    
    sleep 1.0 / 5.0
  end
  
  stop
end

live_loop :shimmer_72 do
  stop unless $running
  use_bpm 72
  
  while $running do
    step = tick(:shimmer_step)
    field = get(:field)
    
    on = euclid_on(step, 28, 11)
    
    if on
      x = field[step % field.length]
      base = scale(:e4, :minor_pentatonic)
      n = base[(step + (x * 7).to_i) % base.length]
      
      moving_pan = Math.sin(step / 8.0) * 0.35
      ampv = clamp(0.05 + x * 0.06, 0.03, 0.13)
      
      with_fx :reverb, room: 0.97, mix: 0.45 do
        with_fx :echo, phase: 0.375, decay: 7, mix: 0.25 do
          synth :prophet, note: n,       attack: 0.03, sustain: 0.18, release: 1.2, cutoff: 90 + x * 20, amp: ampv,       pan: -0.03 + moving_pan * 0.03
          sleep 0.012
          synth :prophet, note: n + 0.2, attack: 0.03, sustain: 0.18, release: 1.2, cutoff: 90 + x * 20, amp: ampv * 0.9, pan:  0.03 + moving_pan * 0.03
          
          sample :drum_tom_mid_soft, amp: ampv * 0.9, pan: moving_pan, rate: 0.8 + x * 0.35
        end
      end
    end
    
    sleep 1.0 / 7.0
  end
  
  stop
end

live_loop :polymeter_54_60_66_72 do
  stop unless $running
  use_bpm 72
  
  while $running do
    step = tick(:poly_step)
    field = get(:field)
    
    hit3 = euclid_on(step, 3, 1)
    hit4 = euclid_on(step, 4, 1)
    hit5 = euclid_on(step, 5, 2)
    hit7 = euclid_on(step, 7, 3)
    
    x = field[step % field.length]
    n = (scale :c4, :chromatic)[(step + (x * 12).to_i) % 12]
    
    with_fx :compressor, threshold: 0.28, slope_above: 0.55, mix: 1 do
    if hit3
      midi n.to_i, channel: 4, velocity: 42, sustain: 0.08
      synth :sine, note: n, amp: 0.05, release: 0.12
    end
    
    if hit4
      midi (n + 7).to_i, channel: 5, velocity: 38, sustain: 0.08
      synth :tri, note: n + 7, amp: 0.045, release: 0.12
    end
    
    if hit5
      sample :bd_haus, amp: 0.10
    end
    
    if hit7
      sample :elec_blip, amp: 0.06, rate: [0.5, 1, 2].choose
    end
  end
  
  sleep 1.0 / 14.0
end

stop
end

live_loop :harmonic_scatter do
  stop unless $running
  use_bpm 60
  
  while $running do
    step = tick(:scatter_step)
    field = get(:field)
    mark = get(:markov)
    
    z = Complex(Math.sin(step * 0.17), Math.cos(step * 0.11))
    r = (z.abs + phi) % 1.0
    p = logistic_iter(r, 3.85, 2)
    
    if rand < 0.45 + (p * 0.2)
      notes = scale(:d4, :minor_pentatonic)
      n = notes[(step + (p * 10).to_i) % notes.length]
      
      with_fx :echo, phase: 0.5, decay: 4, mix: 0.14 do
        synth :hollow, note: n, release: 0.9, sustain: 0.2, amp: 0.06 + p * 0.05, pan: (mark == :D ? 0.15 : -0.15)
      end
    end
    
    sleep 0.5
  end
  
  stop
end