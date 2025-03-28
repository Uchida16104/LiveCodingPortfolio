use_random_seed 2
in_thread do
  cluster1=[:ambi_choir, :ambi_drone].choose
  with_fx :ring_mod, mix: rrand(0, 1), freq: rrand(36, 84), mix_slide: rrand(0, 1), freq_slide: rrand(0, 1) do |r|
    with_fx :gverb, mix: rrand(0, 1), room: rrand(1, 100), mix_slide: rrand(0, 1), room_slide: rrand(0, 1) do |g|
      with_fx :echo, mix: rrand(0, 1), phase: rrand(0, 1), mix_slide: rrand(0, 1), phase_slide: rrand(0, 1) do |e|
        with_fx :vowel, mix: rrand(0, 1), voice: [0,1,2,3,4].choose, vowel_sound: [1,2,3,4,5].choose, mix_slide: rrand(0, 1), voice_slide: rrand(0, 1), vowel_sound_slide: rrand(0, 1) do |v|
          150.times do
            s=sample cluster1, amp: rrand(0, 1), amp_slide: rrand(0, 1), pan: rdist(-1), pan_slide: rrand(0, 1), rate: [-1, 1].choose, release: 2
            sleep (sample_duration cluster1)/3.to_f
            control s, amp: rrand(0, 1), pan: rdist(1)
            control v, mix: rrand(0, 1), voice: [0,1,2,3,4].choose, vowel_sound: [1,2,3,4,5].choose
            control e, mix: rrand(0, 1), phase: rrand(0, 1)/10.to_f
            control g, mix: rrand(0, 1), room: rrand(1, 100)
            control r, mix: rrand(0, 1), freq: rrand(36, 84)
          end
        end
      end
    end
  end
end
in_thread do
  cluster2=[:ambi_glass_hum, :ambi_glass_rub].choose
  with_fx :ring_mod, mix: rrand(0, 1), freq: rrand(36, 84), mix_slide: rrand(0, 1), freq_slide: rrand(0, 1) do |r|
    with_fx :gverb, mix: rrand(0, 1), room: rrand(1, 100), mix_slide: rrand(0, 1), room_slide: rrand(0, 1) do |g|
      with_fx :echo, mix: rrand(0, 1), phase: rrand(0, 1), mix_slide: rrand(0, 1), phase_slide: rrand(0, 1) do |e|
        with_fx :vowel, mix: rrand(0, 1), voice: [0,1,2,3,4].choose, vowel_sound: [1,2,3,4,5].choose, mix_slide: rrand(0, 1), voice_slide: rrand(0, 1), vowel_sound_slide: rrand(0, 1) do |v|
          150.times do
            s=sample cluster2, amp: rrand(0, 1), amp_slide: rrand(0, 1), pan: rdist(1), pan_slide: rrand(0, 1), rate: [-1, 1].choose, release: 2
            sleep (sample_duration cluster2)/3.to_f
            control s, amp: rrand(0, 1), pan: rdist(1)
            control v, mix: rrand(0, 1), voice: [0,1,2,3,4].choose, vowel_sound: [1,2,3,4,5].choose
            control e, mix: rrand(0, 1), phase: rrand(0, 1)/10.to_f
            control g, mix: rrand(0, 1), room: rrand(1, 100)
            control r, mix: rrand(0, 1), freq: rrand(36, 84)
          end
        end
      end
    end
  end
end
in_thread do
  cluster3=:ambi_piano
  with_fx :ring_mod, mix: rrand(0, 1), freq: rrand(36, 84), mix_slide: rrand(0, 1), freq_slide: rrand(0, 1) do |r|
    with_fx :gverb, mix: rrand(0, 1), room: rrand(1, 100), mix_slide: rrand(0, 1), room_slide: rrand(0, 1) do |g|
      with_fx :echo, mix: rrand(0, 1), phase: rrand(0, 1), mix_slide: rrand(0, 1), phase_slide: rrand(0, 1) do |e|
        with_fx :vowel, mix: rrand(0, 1), voice: [0,1,2,3,4].choose, vowel_sound: [1,2,3,4,5].choose, mix_slide: rrand(0, 1), voice_slide: rrand(0, 1), vowel_sound_slide: rrand(0, 1) do |v|
          150.times do
            s=sample cluster3, amp: rrand(0, 1), amp_slide: rrand(0, 1), pan: rdist(-1), pan_slide: rrand(0, 1), rate: [-1, 1].choose, release: 2
            sleep (sample_duration cluster3)/3.to_f
            control s, amp: rrand(0, 1), pan: rdist(1)
            control v, mix: rrand(0, 1), voice: [0,1,2,3,4].choose, vowel_sound: [1,2,3,4,5].choose
            control e, mix: rrand(0, 1), phase: rrand(0, 1)/10.to_f
            control g, mix: rrand(0, 1), room: rrand(1, 100)
            control r, mix: rrand(0, 1), freq: rrand(36, 84)
          end
        end
      end
    end
  end
end
in_thread do
  cluster4=:loop_weirdo
  with_fx :ring_mod, mix: rrand(0, 1), freq: rrand(36, 84), mix_slide: rrand(0, 1), freq_slide: rrand(0, 1) do |r|
    with_fx :gverb, mix: rrand(0, 1), room: rrand(1, 100), mix_slide: rrand(0, 1), room_slide: rrand(0, 1) do |g|
      with_fx :echo, mix: rrand(0, 1), phase: rrand(0, 1), mix_slide: rrand(0, 1), phase_slide: rrand(0, 1) do |e|
        with_fx :vowel, mix: rrand(0, 1), voice: [0,1,2,3,4].choose, vowel_sound: [1,2,3,4,5].choose, mix_slide: rrand(0, 1), voice_slide: rrand(0, 1), vowel_sound_slide: rrand(0, 1) do |v|
          150.times do
            s=sample cluster4, amp: rrand(0, 1), amp_slide: rrand(0, 1), pan: rdist(1), pan_slide: rrand(0, 1), rate: [-1, 1].choose, release: 2
            sleep (sample_duration cluster4)/3.to_f
            control s, amp: rrand(0, 1), pan: rdist(1)
            control v, mix: rrand(0, 1), voice: [0,1,2,3,4].choose, vowel_sound: [1,2,3,4,5].choose
            control e, mix: rrand(0, 1), phase: rrand(0, 1)/10.to_f
            control g, mix: rrand(0, 1), room: rrand(1, 100)
            control r, mix: rrand(0, 1), freq: rrand(36, 84)
          end
        end
      end
    end
  end
end