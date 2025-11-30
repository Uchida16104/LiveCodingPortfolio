define :atonal do |n_min, n_max, v_min, v_max, t_min, t_max, loop|
  loop.times do
    note = rrand_i(n_min, n_max)
    vel = rrand_i(v_min, v_max)
    midi_note_on note, vel
    sleep rrand(t_min, t_max)
    midi_note_off note, vel
  end
end
define :minimal do |n, v, t, loop|
  loop.times do
    n.length.times do
      melody = n.clone
      note_to_play = melody.tick
      midi_note_on note_to_play, v
      sleep t
      midi_note_off note_to_play, v
    end
  end
end
define :overtone do |init, v, t, min, max|
  if min <= max
    (min..max).each do |i|
      midi_note_on hz_to_midi(midi_to_hz(init) * i.to_f).to_f, v
      sleep t
      midi_note_off hz_to_midi(midi_to_hz(init) * i.to_f).to_f, v
    end
  else
    min.downto(max) do |i|
      midi_note_on hz_to_midi(midi_to_hz(init) * i.to_f).to_f, v
      sleep t
      midi_note_off hz_to_midi(midi_to_hz(init) * i.to_f).to_f, v
    end
  end
end
define :tritone do |base, v, t, mode|
  case mode
  when "chordup"
    [base, base+6].each do |note|
      midi_note_on note, v
    end
    sleep t
    [base, base+6].each do |note|
      midi_note_off note, v
    end
    
  when "chordown"
    [base, base-6].each do |note|
      midi_note_on note, v
    end
    sleep t
    [base, base-6].each do |note|
      midi_note_off note, v
    end
    
  when "scaleup"
    midi_note_on base, v
    sleep t
    midi_note_off base, v
    midi_note_on base+6, v
    sleep t
    midi_note_off base+6, v
    
  when "scaledown"
    midi_note_on base, v
    sleep t
    midi_note_off base, v
    midi_note_on base-6, v
    sleep t
    midi_note_off base-6, v
  end
end
define :cluster do |base, mode, type, v, t|
  intervals = case type
  when "white"
    [0, 2, 4, 5, 7, 9, 11]
  when "black"
    [1, 3, 6, 8, 10]
  else
    (0..11).to_a
  end
  notes = intervals.map do |i|
    note = mode == "up" ? base + i : base - i
    [[note, 0].max, 127].min
  end
  notes.each do |n|
    midi_note_on n, v
  end
  sleep t
  notes.each do |n|
    midi_note_off n, v
  end
end
define :echo do |base, v, t, loop, decay, rate|
  loop.times do |i|
    vol = (v * (decay**i)).to_i
    midi_note_on base, vol
    sleep t
    midi_note_off base, vol
    t *= rate
  end
end
define :ring_mod do |ax, ay, fx, fy, velocity_scale = 1.0, dur = 0.5, port = nil, channel = 1|
  begin
    unless ax.is_a?(Numeric) && ay.is_a?(Numeric) && fx.is_a?(Numeric) && fy.is_a?(Numeric)
      raise ArgumentError, "ax, ay, fx, fy must be numeric"
    end
    unless velocity_scale.is_a?(Numeric) && dur.is_a?(Numeric)
      raise ArgumentError, "velocity_scale and dur must be numeric"
    end
    unless channel.is_a?(Integer) && channel >= 1 && channel <= 16
      raise ArgumentError, "channel must be integer in 1..16"
    end
    ax = [[ax, 0.0].max, 1.0].min
    ay = [[ay, 0.0].max, 1.0].min
    velocity_scale = [[velocity_scale, 0.0].max, 1.0].min
    dur = [[dur, 0.01].max, 30.0].min
    f_plus = fx + fy
    f_minus = (fx - fy).abs
    if f_minus == 0
      puts "ring_mod_midi: WARNING: difference frequency is 0 Hz (fx == fy). Only DC (0 Hz) would result theoretically."
    end
    if f_plus <= 0 || f_minus < 0
      puts "ring_mod_midi: WARNING: computed sideband frequencies non-positive: f_plus=#{f_plus}, f_minus=#{f_minus}"
    end
    midi_plus_f = nil
    midi_minus_f = nil
    if f_plus > 0
      midi_plus_f = hz_to_midi(f_plus)
      midi_plus = midi_plus_f.round
      midi_plus = [[midi_plus, 0].max, 127].min
    else
      midi_plus = nil
    end
    if f_minus > 0
      midi_minus_f = hz_to_midi(f_minus)
      midi_minus = midi_minus_f.round
      midi_minus = [[midi_minus, 0].max, 127].min
    else
      midi_minus = nil
    end
    base_vel = (ax * ay * 127.0 * velocity_scale).round
    base_vel = [[base_vel, 1].max, 127].min
    notes_on = []
    if midi_plus
      midi_note_on(midi_plus, base_vel, port: port, channel: channel)
      notes_on << {note: midi_plus, vel: base_vel}
    end
    if midi_minus && midi_minus != midi_plus
      midi_note_on(midi_minus, base_vel, port: port, channel: channel)
      notes_on << {note: midi_minus, vel: base_vel}
    end
    sleep dur
  rescue => e
    puts "ring_mod_midi: ERROR - #{e.class}: #{e.message}"
  ensure
    if defined? notes_on and notes_on
      notes_on.each do |h|
        midi_note_off(h[:note], port: port, channel: channel)
      end
    end
  end
end
define :polyrhythm do |nl, sl, v, loop|
  loop.times do
    threads = []
    nl.each_with_index do |notes, idx|
      threads << in_thread do
        step = sl[idx]
        notes.each do |n|
          n_safe = [[n,0].max,127].min
          midi_note_on n_safe, v rescue nil
          sleep step
          midi_note_off n_safe, v rescue nil
        end
      end
    end
    threads.each(&:join)
  end
end
define :polytempo do |nl, tempos, t, v, loop|
  loop.times do
    threads = []
    nl.each_with_index do |notes, idx|
      threads << in_thread do
        bpm = tempos[idx]
        use_bpm bpm
        notes.each do |n|
          n_safe = [[n,0].max,127].min
          midi_note_on n_safe, v rescue nil
          sleep t
          midi_note_off n_safe, v rescue nil
        end
      end
    end
    threads.each(&:join)
  end
end
define :clamp do |x, lo, hi|
  [[x, lo].max, hi].min
end
define :safe_note_from_float do |f|
  clamp(f.round, 21, 108)
end
define :safe_vel_from_float do |f|
  clamp(f.round, 1, 127)
end
define :safe_sleep_from_float do |f|
  clamp(f.to_f.abs, 0.03, 0.6)
end
define :safe_midi do |note|
  note = note.to_f rescue 60.0
  [[note.round, 0].max, 127].min
end
define :play_midi_note do |note, velocity=100, dur=0.25|
  note = safe_midi(note)
  begin
    midi_note_on note, velocity
    sleep dur
  ensure
    midi_note_off note
  end
end
define :graphic do |loop, repeat, t|
  repeat.times do
    loop.times do |i|
      begin
        x = i.to_f / loop
        n = ((Math.sin(x)+Math.cos(x))*60+Math.atan(x)).abs.round(0) rescue 60
        n = safe_midi(n)
        play_midi_note n, 80, t
      rescue => e
        puts "math_shape_music error: #{e}"
      end
    end
  end
end
define :destroy do |d, s, min, max|
  start_time = Time.now
  loop do
    t = Time.now - start_time
    break if t > d
    chaos_factor = t / d.to_f
    r = rrand_i(min, max)
    base_notes = (chord r, chord_names[rrand_i(0, chord_names.length-1)])
    c = base_notes.map { |n| n + rrand_i(-3, 3) * chaos_factor }
    c.each do |n|
      play_midi_note n, 80, rrand(0.1, 0.3)
    end
    mel_note = safe_midi(Math.sin(t*2*Math::PI) * 24 + 72 + rrand(-12,12)*chaos_factor)
    play_midi_note mel_note, 100, rrand(0.05, 0.2)
    sleep s
  end
end
in_thread do
  ((Math.sin(Math::PI*Math::E)+Math.cos(Math::PI*Math::E))*500.to_i).round(0).times do
    use_real_time
    now = Time.now.to_f
    s1 = Math.sin(now * 0.9)
    s2 = Math.cos(now * 1.3)
    s3 = Math.tan(now * 0.2 % (Math::PI/2)) rescue 0.0
    s4 = Math.asin(clamp(s1, -1.0, 1.0)) rescue 0.0
    s5 = Math.acos(clamp(s2, -1.0, 1.0)) rescue 0.0
    s6 = Math.atan(now * 0.01)
    base_note_f = 60.0 + (s1 * 12.0) + (s6 * 6.0)
    base_note = safe_note_from_float(base_note_f)
    vel_f = 80.0 + (s2 * 30.0) + (Math.sin(now*1.7) * 10.0)
    vel = safe_vel_from_float(vel_f)
    sp_f = 0.08 + ( (s3 * 0.08) rescue 0.0 ) + ( (s4.abs) * 0.02 )
    sp = safe_sleep_from_float(sp_f)
    if one_in(6)
      puts "atonal"
      nmin = safe_note_from_float(base_note - 12 + (Math.sin(now*0.5)*6))
      nmax = safe_note_from_float(base_note + 12 + (Math.cos(now*0.7)*6))
      vmin = clamp((vel * 0.5).round, 1, 127)
      vmax = clamp((vel * 1.0).round, 1, 127)
      tmin = safe_sleep_from_float(sp * 0.5)
      tmax = safe_sleep_from_float(sp * 1.5)
      loops = 3
      atonal nmin, nmax, vmin, vmax, tmin, tmax, loops
    end
    if one_in(5)
      puts "minimal"
      melody = [
        safe_note_from_float(base_note + (Math.sin(now*0.9)*3)),
        safe_note_from_float(base_note + (Math.cos(now*1.1)*4)),
        safe_note_from_float(base_note + (Math.sin(now*1.4)*2)),
        safe_note_from_float(base_note - 2)
      ]
      minimal melody, vel, sp, [4, 8, 16].choose
    end
    if one_in(7)
      puts "overtone"
      init = base_note
      v2 = clamp((vel * (0.7 + (s2.abs*0.3))).round, 1, 127)
      t2 = safe_sleep_from_float(sp * 0.6)
      min_i = 2
      max_i = 5
      if one_in(2)
        overtone init, v2, t2, min_i, max_i
      else
        overtone init, v2, t2, max_i, min_i
      end
    end
    if one_in(6)
      puts "tritone"
      modes = ["chordup","chordown","scaleup","scaledown"]
      m = modes.choose
      tritone base_note, vel, sp, m
    end
    if one_in(6)
      puts "cluster"
      type = ["white","black","all"].choose
      mode_dir = ["up","down"].choose
      v_c = clamp((vel * (0.6 + rand * 0.8)).round, 1, 127)
      t_c = safe_sleep_from_float(sp * (0.8 + rand*0.6))
      cluster base_note, mode_dir, type, v_c, t_c
    end
    if one_in(8)
      puts "echo"
      base_e = base_note
      v_e = clamp((vel * (0.4 + rand)).round, 1, 127)
      t_e = safe_sleep_from_float(sp * (0.6 + rand*0.8))
      loops_e = 3
      decay = clamp(0.6 + rand * 0.3, 0.2, 0.99)
      rate = clamp(0.9 + rand * 0.3, 0.5, 1.2)
      echo base_e, v_e, t_e, loops_e, decay, rate
    end
    if one_in(8)
      puts "ring_mod"
      ax = clamp(0.2 + (s1.abs * 0.8), 0.0, 1.0)
      ay = clamp(0.2 + (s2.abs * 0.8), 0.0, 1.0)
      fx = clamp(110.0 + (Math.sin(now*0.4)*40.0), 20.0, 2000.0)
      fy = clamp(220.0 + (Math.cos(now*0.6)*30.0), 20.0, 2000.0)
      velocity_scale = clamp(0.3 + rand*0.7, 0.01, 1.0)
      dur_rm = safe_sleep_from_float(sp * (0.9 + rand*0.8))
      ring_mod ax, ay, fx, fy, velocity_scale, dur_rm, nil, 1
    end
    if one_in(7)
      puts "polyrhythm"
      nl = [
        [ safe_note_from_float(base_note), safe_note_from_float(base_note + 4) ],
        [ safe_note_from_float(base_note + 7), safe_note_from_float(base_note + 9) ]
      ]
      sl = [ safe_sleep_from_float(sp * 1.0), safe_sleep_from_float(sp * (2.0/3.0)) ]
      polyrhythm nl, sl, vel, 2
    end
    if one_in(9)
      puts "polytempo"
      nl2 = [
        [ safe_note_from_float(base_note), safe_note_from_float(base_note+3) ],
        [ safe_note_from_float(base_note+5), safe_note_from_float(base_note+8) ]
      ]
      tempos = [ clamp(80 + (s1*20).round, 40, 220), clamp(90 + (s2*15).round, 40, 220) ]
      tbase = safe_sleep_from_float(sp * 0.9)
      polytempo nl2, tempos, tbase, vel, 1
    end
    if one_in(10)
      puts "graphic"
      graphic [2,4,8].choose, [2,4,8].choose, sp
    end
    if one_in(12)
      puts "destroy"
      destroy 5.0, sp, 60, 84
    end
    sleep safe_sleep_from_float(sp * (0.8 + rand * 0.6))
  end
end
in_thread do
  ((Math.sin(Math::PI*Math::E)+Math.cos(Math::PI*Math::E))*500.to_i).round(0).times do
    use_real_time
    now = Time.now.to_f
    s1 = Math.sin(now * 0.9)
    s2 = Math.cos(now * 1.3)
    s3 = Math.tan(now * 0.2 % (Math::PI/2)) rescue 0.0
    s4 = Math.asin(clamp(s1, -1.0, 1.0)) rescue 0.0
    s5 = Math.acos(clamp(s2, -1.0, 1.0)) rescue 0.0
    s6 = Math.atan(now * 0.01)
    base_note_f = 36.0 + (s1 * 12.0) + (s6 * 6.0)
    base_note = safe_note_from_float(base_note_f)
    vel_f = 70.0 + (s2 * 25.0) + (Math.sin(now*1.7) * 10.0)
    vel = safe_vel_from_float(vel_f)
    sp_f = 0.1 + ( (s3 * 0.08) rescue 0.0 ) + ( (s4.abs) * 0.02 )
    sp = safe_sleep_from_float(sp_f)
    if one_in(6)
      puts "atonal"
      nmin = safe_note_from_float(base_note - 12 + (Math.sin(now*0.5)*6))
      nmax = safe_note_from_float(base_note + 12 + (Math.cos(now*0.7)*6))
      vmin = clamp((vel * 0.5).round, 1, 127)
      vmax = clamp((vel * 1.0).round, 1, 127)
      tmin = safe_sleep_from_float(sp * 0.5)
      tmax = safe_sleep_from_float(sp * 1.5)
      loops = 3
      atonal nmin, nmax, vmin, vmax, tmin, tmax, loops
    end
    if one_in(5)
      puts "minimal"
      melody = [
        safe_note_from_float(base_note + (Math.sin(now*0.9)*3)),
        safe_note_from_float(base_note + (Math.cos(now*1.1)*4)),
        safe_note_from_float(base_note + (Math.sin(now*1.4)*2)),
        safe_note_from_float(base_note - 2)
      ]
      minimal melody, vel, sp, [4, 8, 16].choose
    end
    if one_in(7)
      puts "overtone"
      init = base_note
      v2 = clamp((vel * (0.7 + (s2.abs*0.3))).round, 1, 127)
      t2 = safe_sleep_from_float(sp * 0.6)
      min_i = 2
      max_i = 5
      if one_in(2)
        overtone init, v2, t2, min_i, max_i
      else
        overtone init, v2, t2, max_i, min_i
      end
    end
    if one_in(6)
      puts "tritone"
      modes = ["chordup","chordown","scaleup","scaledown"]
      m = modes.choose
      tritone base_note, vel, sp, m
    end
    if one_in(6)
      puts "cluster"
      type = ["white","black","all"].choose
      mode_dir = ["up","down"].choose
      v_c = clamp((vel * (0.6 + rand * 0.8)).round, 1, 127)
      t_c = safe_sleep_from_float(sp * (0.8 + rand*0.6))
      cluster base_note, mode_dir, type, v_c, t_c
    end
    if one_in(8)
      puts "echo"
      base_e = base_note
      v_e = clamp((vel * (0.4 + rand)).round, 1, 127)
      t_e = safe_sleep_from_float(sp * (0.6 + rand*0.8))
      loops_e = 3
      decay = clamp(0.6 + rand * 0.3, 0.2, 0.99)
      rate = clamp(0.9 + rand * 0.3, 0.5, 1.2)
      echo base_e, v_e, t_e, loops_e, decay, rate
    end
    if one_in(8)
      puts "ring_mod"
      ax = clamp(0.2 + (s1.abs * 0.8), 0.0, 1.0)
      ay = clamp(0.2 + (s2.abs * 0.8), 0.0, 1.0)
      fx = clamp(55.0 + (Math.sin(now*0.4)*20.0), 20.0, 1000.0)
      fy = clamp(110.0 + (Math.cos(now*0.6)*15.0), 20.0, 1000.0)
      velocity_scale = clamp(0.3 + rand*0.7, 0.01, 1.0)
      dur_rm = safe_sleep_from_float(sp * (0.9 + rand*0.8))
      ring_mod ax, ay, fx, fy, velocity_scale, dur_rm, nil, 1
    end
    if one_in(7)
      puts "polyrhythm"
      nl = [
        [ safe_note_from_float(base_note), safe_note_from_float(base_note + 4) ],
        [ safe_note_from_float(base_note + 7), safe_note_from_float(base_note + 9) ]
      ]
      sl = [ safe_sleep_from_float(sp * 1.0), safe_sleep_from_float(sp * (2.0/3.0)) ]
      polyrhythm nl, sl, vel, 2
    end
    if one_in(9)
      puts "polytempo"
      nl2 = [
        [ safe_note_from_float(base_note), safe_note_from_float(base_note+3) ],
        [ safe_note_from_float(base_note+5), safe_note_from_float(base_note+8) ]
      ]
      tempos = [ clamp(80 + (s1*20).round, 40, 220), clamp(90 + (s2*15).round, 40, 220) ]
      tbase = safe_sleep_from_float(sp * 0.9)
      polytempo nl2, tempos, tbase, vel, 1
    end
    if one_in(10)
      puts "graphic"
      graphic [2,4,8].choose, [2,4,8].choose, sp
    end
    if one_in(12)
      puts "destroy"
      destroy 5.0, sp, 36, 60
    end
    sleep safe_sleep_from_float(sp * (0.8 + rand * 0.6))
  end
end