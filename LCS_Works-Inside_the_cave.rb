set_mixer_control! amp: 0.7, limiter_bypass: 0
use_debug false
use_cue_logging false
START_TIME = Time.now.to_f

define :fib do |n|
  a, b = 0, 1
  n.times { a, b = b, a + b }
  return a == 0 ? 1 : a
end

define :is_prime? do |n|
  return false if n <= 1
  (2..Math.sqrt(n).to_i).each { |i| return false if n % i == 0 }
  true
end

define :collatz_step do |n|
  return 1 if n <= 1
  n.even? ? n / 2 : 3 * n + 1
end

define :logistic_map do |r, x|
  r * x * (1.0 - x)
end

define :lorenz_step do |x, y, z, dt=0.01|
  a, b, c = 10.0, 28.0, 8.0/3.0
  nx = x + (a * (y - x)) * dt
  ny = y + (x * (c - z) - y) * dt
  nz = z + (x * y - b * z) * dt
  [nx, ny, nz]
end

define :mandelbrot_iter do |cr, ci, max_iter|
  zr, zi, i = 0.0, 0.0, 0
  while (zr**2 + zi**2 < 4.0) && (i < max_iter)
    zr, zi = zr**2 - zi**2 + cr, 2.0 * zr * zi + ci
    i += 1
  end
  i
end

define :cellular_automaton_step do |arr|
  new_arr = arr.dup
  arr.length.times do |i|
    left = arr[(i - 1) % arr.length]
    right = arr[(i + 1) % arr.length]
    new_arr[i] = (left ^ right)
  end
  new_arr
end

define :wave_pde_step do |u, u_prev, c_dt_dx_sq|
  new_u = u.dup
  (1...u.length-1).each do |i|
    new_u[i] = 2.0*u[i] - u_prev[i] + c_dt_dx_sq * (u[i+1] - 2.0*u[i] + u[i-1])
  end
  new_u
end

MARKOV_MATRIX = { 0 => [0, 1], 1 => [1, 0, 1] }
define :markov_next do |state|
  MARKOV_MATRIX[state].choose
end

define :lsystem_step do |axiom|
  axiom.chars.map { |c| c == 'A' ? 'AB' : 'A' }.join
end

define :stochastic_limit do |val, target, rate|
  val + (target - val) * rate + rrand(-0.05, 0.05)
end

define :play_beat_interference do |note, dur|
  play note, sustain: dur, release: 0.1, amp: 0.4, wave: 0
  play note + 0.15, sustain: dur, release: 0.1, amp: 0.35, wave: 1
end

define :play_tritone_harmonics do |root_note|
  synth :hollow, note: root_note, release: 2, amp: 0.5
  synth :dark_ambience, note: root_note + 6, release: 1.5, amp: 0.3
  synth :sine, note: root_note + 19, release: 1, amp: 0.2
  synth :sine, note: root_note + 24, release: 0.5, amp: 0.1
end

define :play_haas do |note, synth_name=:fm|
  use_synth synth_name
  play note, pan: -1, amp: 0.5, release: 0.2
  in_thread do
    sleep 0.015
    play note, pan: 1, amp: 0.5, release: 0.2
  end
end

define :play_doppler do |base_note|
  s = synth :tri, note: base_note + 5, note_slide: 1, pan: -1, pan_slide: 1, amp: 0.1, amp_slide: 0.5, release: 1
  control s, note: base_note - 5, pan: 1, amp: 0.6
end

with_fx :compressor, threshold: 0.4, slope_above: 0.3 do
  with_fx :reverb, room: 0.8, mix: 0.5, damp: 0.2 do |rvb|
    
    live_loop :poly_3_bpm54 do
      use_bpm 54
      sleep_time = (1.0 / 3.0) * (54.0 / 60.0)
      
      log_val = 0.5
      euclid_rhythm = spread(5, 8)
      
      while (Time.now.to_f - START_TIME) < 300
        tick
        log_val = logistic_map(3.8, log_val)
        
        if euclid_rhythm.look
          play_haas(scale(:c2, :minor_pentatonic).choose + (log_val * 12), :fm)
          midi scale(:c2, :minor_pentatonic).choose, velocity: 60, channel: 1
          sample :elec_wood, amp: 0.5, rate: 1.5 + log_val
        end
        
        sleep sleep_time
      end
      stop
    end
    
    live_loop :poly_4_bpm60 do
      use_bpm 60
      sleep_time = (1.0 / 4.0) * (60.0 / 60.0)
      
      collatz_val = 27
      
      while (Time.now.to_f - START_TIME) < 300
        tick
        collatz_val = collatz_step(collatz_val)
        collatz_val = 27 if collatz_val <= 1
        
        m_iter = mandelbrot_iter(Math.cos(look*0.1), Math.sin(look*0.1), 20)
        
        if collatz_val.odd?
          play_tritone_harmonics(48 + (m_iter % 12))
          midi 48 + (m_iter % 12), velocity: 70, channel: 2
        end
        
        sleep sleep_time
      end
      stop
    end
    
    live_loop :poly_5_bpm66 do
      use_bpm 66
      sleep_time = (1.0 / 5.0) * (66.0 / 60.0)
      
      ca_state = [0,1,0,0,1,0,1,1]
      wave_u = Array.new(8, 0.0)
      wave_u[4] = 1.0
      wave_u_prev = wave_u.dup
      
      while (Time.now.to_f - START_TIME) < 300
        t = tick
        
        ca_state = cellular_automaton_step(ca_state) if t % 4 == 0
        wave_new = wave_pde_step(wave_u, wave_u_prev, 0.5)
        wave_u_prev = wave_u
        wave_u = wave_new
        
        val = ca_state[t % 8]
        
        if val == 1
          is_p = is_prime?(t)
          note = 60 + (wave_u[t % 8] * 10).to_i
          note += 1.618 * 5 if is_p
          
          play_beat_interference(note, sleep_time)
          sample :guit_harmonics, rate: 0.5, amp: 0.4 if is_p
          midi note, velocity: 80, channel: 3
        end
        
        sleep sleep_time
      end
      stop
    end
    
    live_loop :poly_7_bpm72 do
      use_bpm 72
      sleep_time = (1.0 / 7.0) * (72.0 / 60.0)
      
      lx, ly, lz = 1.0, 1.0, 1.0
      m_state = 0
      fib_index = 1
      
      with_fx :echo, phase: 0.25, decay: 2 do |ech|
        while (Time.now.to_f - START_TIME) < 300
          t = tick
          
          lx, ly, lz = lorenz_step(lx, ly, lz)
          m_state = markov_next(m_state)
          
          if m_state == 1
            f_val = fib(fib_index)
            fib_index = (fib_index % 8) + 1
            
            synth :dsaw, note: 36 + (f_val % 24), cutoff: 70 + (lz % 40).abs, pan: [1, -1].minmax.include?(lx/20) ? lx/20 : 0, amp: 0.3, detune: 0.1
            
            play_doppler(72 + (ly % 12).abs) if rand < 0.2
            
            control rvb, mix: stochastic_limit(0.5, (lx.abs % 1.0), 0.1)
            control ech, phase: (f_val % 5) * 0.1 + 0.05
            
            midi 36 + (f_val % 24), velocity: 50, channel: 4
          end
          
          sleep sleep_time
        end
        stop
      end
    end
    
    in_thread do
      while (Time.now.to_f - START_TIME) < 300
        sleep 1
      end
      midi_note_off 0, channel: 1
      midi_note_off 0, channel: 2
      midi_note_off 0, channel: 3
      midi_note_off 0, channel: 4
      puts "=== 300 Seconds Passed. Mathematical Genesis Halted. ==="
    end
    
  end
end