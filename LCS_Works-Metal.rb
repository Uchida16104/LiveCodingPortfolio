define :overtone do |md, r|
  nt=(hz_to_midi(midi_to_hz(md)*r)).to_f
  return nt
end
define :calculate do |n1, n2, diff|
  plus=midi_to_hz(n1-diff)+midi_to_hz(n2-diff).to_f
  frequency=hz_to_midi(plus/2).to_f
  return frequency
end
define :ambient do |num|
  pad=Array.new
  for i in 2..5
    for j in 0..sample_groups.length-1
      pad.push(sample_names(sample_groups[j])[i])
    end
  end
  return pad[num]
end
define :minutes do |num|
  return num*60
end
start=Time.now
while (Time.now-start)<minutes(5) do
  with_fx :compressor, relax_time: 2, relax_time_slide: 0.001 do |c|
  with_fx :gverb, mix: rdist(-1).abs, room: 100, spread: 1, damp: 1, release: 10, ref_level: 1, tail_level: 1, mix_slide: 0.001, room_slide: 0.001, spread_slide: 0.001, damp_slide: 0.001, release_slide: 0.001, ref_level_slide: 0.001, tail_level_slide: 0.001 do |g|
  with_fx :reverb, mix: rdist(-0.75).abs, damp: 1, room: 1, mix_slide: 0.001, damp_slide: 0.001, room_slide: 0.001 do |re|
  with_fx :echo, mix: rdist(-0.5).abs, decay: 4, max_phase: 1, phase: 0.125, mix_slide: 0.001, decay_slide: 0.001, phase_slide: 0.001 do |e|
  with_fx :ping_pong, mix: rdist(-0.25).abs, phase: 0.125, mix_slide: 0.0001, phase_slide: 0.0001 do |pp|
  with_fx :vowel, mix: rrand(0, 1), voice: [0, 1, 2, 3, 4].choose, vowel_sound: [1, 2, 3, 4, 5].choose, mix_slide: 0.0001, voice_slide: 0.0001, vowel_sound_slide: 0.0001 do |v|
  with_fx :flanger, mix: rdist(0.25).abs, feedback: 1, depth: 1, phase: 0.125, phase_offset: 0.125, mix_slide: 0.0001, feedback_slide: 0.0001, depth_slide: 0.0001, phase_slide: 0.0001 do |f|
  with_fx :tremolo, mix: rdist(0.5).abs, depth: 1, phase: 0.125, phase_offset: 0.125, mix_slide: 0.0001, depth: 0.0001, phase_slide: 0.0001 do |t|
  with_fx :pitch_shift, mix: rdist(0.75).abs, pitch_dis: 1, time_dis: 1, window_size: 1, mix_slide: 0.0001, pitch_dis_slide: 0.0001, time_dis_slide: 0.0001, window_size_slide: 0.0001 do |p|
  with_fx :ring_mod, mix: rdist(1).abs, freq: overtone(calculate(60, 69, 24),4).ceil, mod_amp: 100, mix_slide: 0.0001, freq_slide: 0.0001, mod_amp_slide: 0.0001 do |r|
  sample ambient(rrand_i(0, 68)), pitch: overtone(calculate(60, 69, 24), 8).ceil-78 , rate: [-1, 1].choose, amp: rdist(1).abs*0.01, attack: rdist(-1).abs*2, decay: rdist(1).abs*2, sustain: rdist(-1).abs*2, release: rdist(1).abs*2
  sleep 2
  control c, relax_time: rrand(0, 2) if one_in(2)
  control g, mix: rdist(1).abs, room: rdist(1).abs*100+1, spread: rdist(1).abs, damp: rdist(1).abs, release: rdist(1).abs*10, ref_level: rdist(1).abs*1, tail_level: rdist(1).abs*1 if one_in(3)
  control re, mix: rdist(0.75).abs, damp: rdist(0.75).abs, room: rdist(0.75).abs if one_in(5)
  control e, mix: rdist(0.5).abs, decay: rdist(0.5).abs*4, phase: 0.875 if one_in(7)
  control pp, mix: rdist(0.25).abs, phase: 0.875 if one_in(11)
  control v, mix: rrand(0, 1), voice: [0, 1, 2, 3, 4].reverse.shuffle.tick, vowel_sound: [1, 2, 3, 4, 5].reverse.shuffle.tick if one_in(13)
  control f, mix: rdist(-0.25).abs, feedback: rdist(-1).abs, depth: rdist(1).abs, phase: 0.875 if one_in(17)
  control t, mix: rdist(-0.5).abs, depth: rdist(-1).abs, phase: 0.875 if one_in(19)
  control p, mix: rdist(-0.75).abs, pitch_dis: rdist(1).abs, time_dis: rdist(-1).abs, window_size: rdist(1).abs if one_in(23)
  control r, mix: rdist(-1).abs, freq: overtone(calculate(60, 69, 24),6).ceil, mod_amp: rdist(-1).abs*100 if one_in(29)
end
end
end
end
end
end
end
end
end
end
end