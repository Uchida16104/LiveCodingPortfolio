use_random_seed rrand(1, 10)
use_bpm 10
in_thread do
  2.times do
    for g in 72..87 do
      with_fx :compressor, mix: rdist(1).abs, mix_slide: rdist(-1).abs do |c1|
      with_fx :gverb, room: 100 do
      with_fx :reverb, room: 1 do
      with_fx :distortion, distort: 0.8 do
      with_fx :ping_pong, phase: 0.125 do
      with_fx :echo, phase: 0.125 do
      with_fx :bpf, centre: 84 do
      with_fx :lpf, cutoff: 10 do
      with_fx :hpf, cutoff: 10 do
      with_fx :vowel, voice: [0, 1, 2, 3, 4].choose, vowel_sound: [1, 2, 3, 4, 5].choose, mix_slide: rdist(1).abs, voice_slide: rdist(-1).abs, vowel_sound_slide: rdist(1).abs do |v1|
      with_fx :ring_mod, freq: g, freq_slide: rdist(-1).abs do |r1|
      use_synth [:mod_beep, :mod_dsaw, :mod_fm, :mod_pulse, :mod_saw, :mod_sine, :mod_tri].choose
      play_chord (scale g, :minor_pentatonic), amp: 5, attack: 1, attack_level: 1, decay: 1, decay_level: 1, sustain: 1, sustain_level: 1, release: 1, release_level: 1
      sleep 3
      control c1, mix: rdist(1).abs
      control v1, mix: rdist(-1).abs, voice: [0, 1, 2, 3, 4].choose, vowel_sound: [1, 2, 3, 4, 5].choose
      control r1, mix: rdist(1).abs, freq: g
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
end
end
end
in_thread do
  3.times do
    for h in 72..87 do
      with_fx :compressor, mix: rdist(-1).abs, mix_slide: rdist(1).abs do |c2|
      with_fx :gverb, room: 100 do
      with_fx :reverb, room: 1 do
      with_fx :ping_pong, phase: 0.125 do
      with_fx :echo, phase: 0.125 do
      with_fx :distortion,distort: 0.8 do
      with_fx :bpf, centre: 84 do
      with_fx :lpf, cutoff: 10 do
      with_fx :hpf, cutoff: 10 do
      with_fx :vowel, voice: [0, 1, 2, 3, 4].choose, vowel_sound: [1, 2, 3, 4, 5].choose, mix_slide: rdist(-1).abs, voice_slide: rdist(1).abs, vowel_sound_slide: rdist(-1).abs do |v2|
      with_fx :ring_mod, freq: h, freq_slide: rdist(1).abs do |r2|
      use_synth [:chipbass, :dull_bell, :rhodey, :rodeo].choose
      play_chord (scale h, :minor_pentatonic), amp: 5, attack: 1, attack_level: 1, decay: 1, decay_level: 1, sustain: 1, sustain_level: 1, release: 1, release_level: 1
      sleep 2
      control c2, mix: rdist(-1).abs
      control v2, mix: rdist(1).abs, voice: [0, 1, 2, 3, 4].choose, vowel_sound: [1, 2, 3, 4, 5].choose
      control r2, mix: rdist(-1).abs, freq: h
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
end
end
end
in_thread do
  2.times do
    for i in 72..87 do
      with_fx :compressor, mix: rdist(1).abs, mix_slide: rdist(-1).abs do |c3|
      with_fx :gverb, room: 100 do
      with_fx :reverb, room: 1 do
      with_fx :ping_pong, phase: 0.125 do
      with_fx :echo, phase: 0.125 do
      with_fx :distortion, distort: 0.8 do
      with_fx :bpf, centre: 84 do
      with_fx :lpf, cutoff: 10 do
      with_fx :hpf, cutoff: 10 do
      with_fx :vowel, voice: [0, 1, 2, 3, 4].choose, vowel_sound: [1, 2, 3, 4, 5].choose, mix_slide: rdist(1).abs, voice_slide: rdist(-1).abs, vowel_sound_slide: rdist(1).abs do |v3|
      with_fx :ring_mod, freq: i, freq_slide: rdist(-1).abs do |r3|
      use_synth [:fm, :growl, :prophet, :subpulse].choose
      play_chord (scale i, :minor_pentatonic), amp: 5, attack: 1, attack_level: 1, decay: 1, decay_level: 1, sustain: 1, sustain_level: 1, release: 1, release_level: 1
      sleep 3
      control c3, mix: rdist(1).abs
      control v3, mix: rdist(-1).abs, voice: [0, 1, 2, 3, 4].choose, vowel_sound: [1, 2, 3, 4, 5].choose
      control r3, mix: rdist(1).abs, freq: i
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
end
end
end
in_thread do
  3.times do
    for j in 72..87 do
      with_fx :compressor, mix: rdist(-1).abs, mix_slide: rdist(1).abs do |c4|
      with_fx :gverb, room: 100 do
      with_fx :reverb, room: 1 do
      with_fx :ping_pong, phase: 0.125 do
      with_fx :echo, phase: 0.125 do
      with_fx :distortion, distort: 0.8 do
      with_fx :bpf, centre: 84 do
      with_fx :lpf, cutoff: 10 do
      with_fx :hpf, cutoff: 10 do
      with_fx :vowel, voice: [0, 1, 2, 3, 4].choose, vowel_sound: [1, 2, 3, 4, 5].choose, mix_slide: rdist(-1).abs, voice_slide: rdist(1).abs, vowel_sound_slide: rdist(-1).abs do |v4|
      with_fx :ring_mod, freq: j, freq_slide: rdist(1).abs do |r4|
      use_synth [:blade, :dpulse, :dsaw, :dtri, :gabberkick, :organ_tonewheel, :supersaw, :tb303, :winwood_lead, :zawa].choose
      play_chord (scale j, :minor_pentatonic), amp: 5, attack: 1, attack_level: 1, decay: 1, decay_level: 1, sustain: 1, sustain_level: 1, release: 1, release_level: 1
      sleep 2
      control c4, mix: rdist(-1).abs
      control v4, mix: rdist(1).abs, voice: [0, 1, 2, 3, 4].choose, vowel_sound: [1, 2, 3, 4, 5].choose
      control r4, mix: rdist(-1).abs, freq: j
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
end
end
end
in_thread do
  2.times do
    for k in 72..87 do
      with_fx :compressor, mix: rdist(1).abs, mix_slide: rdist(-1).abs do |c5|
      with_fx :gverb, room: 100 do
      with_fx :reverb, room: 1 do
      with_fx :ping_pong, phase: 0.125 do
      with_fx :echo, phase: 0.125 do
      with_fx :distortion, distort: 0.8 do
      with_fx :bpf, centre: 84 do
      with_fx :lpf, cutoff: 10 do
      with_fx :hpf, cutoff: 10 do
      with_fx :vowel, voice: [0, 1, 2, 3, 4].choose, vowel_sound: [1, 2, 3, 4, 5].choose, mix_slide: rdist(1).abs, voice_slide: rdist(-1).abs, vowel_sound_slide: rdist(1).abs do |v5|
      with_fx :ring_mod, freq: k, freq_slide: rdist(-1).abs do |r5|
      use_synth [:beep, :chiplead, :pretty_bell, :pulse, :saw, :sine, :square, :tri].choose
      play_chord (scale k, :minor_pentatonic), amp: 5, attack: 1, attack_level: 1, decay: 1, decay_level: 1, sustain: 1, sustain_level: 1, release: 1, release_level: 1
      sleep 3
      control c5, mix: rdist(1).abs
      control v5, mix: rdist(-1).abs, voice: [0, 1, 2, 3, 4].choose, vowel_sound: [1, 2, 3, 4, 5].choose
      control r5, mix: rdist(1).abs, freq: k
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
end
end
end