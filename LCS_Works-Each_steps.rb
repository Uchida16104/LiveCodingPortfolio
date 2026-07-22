start_time = vt
time = 300
define :edo do |root, degree, n|
  root + degree * (12.0 / n)
end
define :rhythm do |n|
  sleep n.to_f
end
func = :rhythm
live_loop :nineteen do
  while vt - start_time >= time
    stop
  end
  with_fx :reverb, damp: 1, room: 1 do
    with_fx :lpf, cutoff: 80 do
      use_bpm 60
      use_synth :piano
      19.times do |i|
        play edo(60-36+1,i,19), amp: 1, attack: send(func, Rational(13,8)), decay: send(func, Rational(13,8)), sustain: send(func, Rational(13,8)), release: send(func, Rational(13,8))
        send(func, Rational(13,8))
      end
    end
  end
end
live_loop :twentytwo do
  while vt - start_time >= time
    stop
  end
  with_fx :reverb, room: 1, damp: 1 do
    with_fx :level, amp: 1 do
      use_bpm 66
      use_synth :organ_tonewheel
      22.times do |i|
        play edo(60-24+2,i,22), amp: 2, attack: send(func, Rational(11,8)), decay: send(func, Rational(11,8)), sustain: send(func, Rational(11,8)), release: send(func, Rational(11,8))
        send(func, Rational(11,8))
      end
    end
  end
end
live_loop :twentyfour do
  while vt - start_time >= time
    stop
  end
  with_fx :reverb, damp: 1, room: 1 do
    with_fx :hpf, cutoff: 40 do
      with_fx :ring_mod do
        use_bpm 72
        use_synth :pretty_bell
        24.times do |i|
          play edo(60-12+6,i,24), amp: 0.5, attack: send(func, Rational(5,4)), decay: send(func, Rational(5,4)), sustain: send(func, Rational(5,4)), release: send(func, Rational(5,4))
          send(func, Rational(5,4))
        end
      end
    end
  end
end
live_loop :thirtyone do
  while vt - start_time >= time
    stop
  end
  with_fx :gverb, damp: 1, room: 100 do
    use_bpm 78
    use_synth :hollow
    31.times do |i|
      play edo(60+10,i,31), amp: 1, attack: send(func, Rational(9,8)), decay: send(func, Rational(9,8)), sustain: send(func, Rational(9,8)), release: send(func, Rational(9,8))
      send(func, Rational(9,8))
    end
  end
end
live_loop :fiftythree do
  while vt - start_time >= time
    stop
  end
  with_fx :gverb, damp: 1, room: 100 do
    use_bpm 84
    use_synth :dark_ambience
    53.times do |i|
      play edo(60+12+11,i,53), amp: 1, attack: send(func, Rational(7,8)), decay: send(func, Rational(7,8)), sustain: send(func, Rational(7,8)), release: send(func, Rational(7,8))
      send(func, Rational(7,8))
    end
  end
end