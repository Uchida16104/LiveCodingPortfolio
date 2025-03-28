live_loop :synth do
  min=1
  max=rrand_i(1, 1000000000)
  use_random_seed rrand_i(min, max)
  use_bpm rrand(1, 120)
  use_random_seed rrand_i(min, max)
  use_random_source [:dark_pink, :light_pink, :perlin, :pink, :white].choose
  with_fx :echo, amp: rrand(0.001, 1), mix: rrand(0, 1), phase: rrand(0, 1), amp_slide: rrand(0.001, 1), mix_slide: rrand(0.001, 1), phase_slide: rrand(0.001, 1) do |e|
    use_random_seed rrand_i(min, max)
    use_random_source [:dark_pink, :light_pink, :perlin, :pink, :white].choose
    with_fx :ring_mod, amp: rrand(0.001, 1), mix: rrand(0, 1), freq: rrand(48, 72), amp_slide: rrand(0.001, 1), mix_slide: rrand(0.001, 1), freq_slide: rrand(0.001, 1) do |r|
      use_random_seed rrand_i(min, max)
      use_random_source [:dark_pink, :light_pink, :perlin, :pink, :white].choose
      with_fx :vowel, amp: rrand(0.001, 1), mix: rrand(0, 1), voice: [0, 1, 2, 3, 4].choose, vowel_sound: [1, 2, 3, 4, 5].choose, amp_slide: rrand(0.001, 1), mix_slide: rrand(0.001, 1), voice_slide: rrand(0.001, 1), vowel_sound_slide: rrand(0.001, 1) do |v|
        use_random_seed rrand_i(min, max)
        use_random_source [:dark_pink, :light_pink, :perlin, :pink, :white].choose
        with_fx :gverb, amp: rrand(0.001, 1), mix: rrand(0, 1), room: rrand(1, 100), amp_slide: rrand(0.001, 1), mix_slide: rrand(0.001, 1), room_slide: rrand(0.001, 1) do |g|
          use_random_seed rrand_i(min, max)
          use_random_source [:dark_pink, :light_pink, :perlin, :pink, :white].choose
          use_synth :piano
          use_random_seed rrand_i(min, max)
          use_random_source [:dark_pink, :light_pink, :perlin, :pink, :white].choose
          s = play rrand(48, 72),
            amp: rrand(0.001, 1),
            amp_slide: rrand(0.001, 1),
            attack: rrand(1, 2),
            attack_slide: rrand(0.001, 1),
            attack_level: rrand(0.001, 1),
            attack_level_slide: rrand(0.001, 1),
            decay: rrand(1, 2),
            decay_slide: rrand(0.001, 1),
            decay_level: rrand(0.001, 1),
            decay_level_slide: rrand(0.001, 1),
            sustain: rrand(1, 2),
            sustain_slide: rrand(0.001, 1),
            sustain_level: rrand(0.001, 1),
            sustain_level_slide: rrand(0.001, 1),
            release: rrand(1, 2),
            release_slide: rrand(0.001, 1),
            release_level: rrand(0.001, 1),
            release_level_slide: rrand(0.001, 1),
            env_curve: [1, 2, 3, 4, 6, 7].choose,
            env_curve_slide: rrand(0.001, 1),
            on: rrand(0.001, 1),
            on_slide: rrand(0.001, 1),
            pan: rrand(-1, 1),
            pan_slide: rrand(0.001, 1),
            pitch: rrand(-12, 12),
            pitch_slide: rrand(0.001, 1),
            note_slide: rrand(0.001, 1)
          use_random_seed rrand_i(min, max)
          use_random_source [:dark_pink, :light_pink, :perlin, :pink, :white].choose
          sleep rrand(0, 1)
          use_random_seed rrand_i(min, max)
          use_random_source [:dark_pink, :light_pink, :perlin, :pink, :white].choose
          control s,
            note: rrand(48, 72),
            amp: rrand(0.001, 1),
            on: rrand(0.001, 1),
            pan: rrand(-1, 1),
            pitch: rrand(-12, 12)
          use_random_seed rrand_i(min, max)
          use_random_source [:dark_pink, :light_pink, :perlin, :pink, :white].choose
          control g, amp: rrand(0.001, 1), mix: rrand(0, 1), room: rrand(1, 100)
          use_random_seed rrand_i(min, max)
          use_random_source [:dark_pink, :light_pink, :perlin, :pink, :white].choose
          control v, amp: rrand(0.001, 1), mix: rrand(0, 1), voice: [0, 1, 2, 3, 4].choose, vowel_sound: [1, 2, 3, 4, 5].choose
          use_random_seed rrand_i(min, max)
          use_random_source [:dark_pink, :light_pink, :perlin, :pink, :white].choose
          control r, amp: rrand(0.001, 1), mix: rrand(0, 1), freq: rrand(48, 72)
          use_random_seed rrand_i(min, max)
          use_random_source [:dark_pink, :light_pink, :perlin, :pink, :white].choose
          control e, amp: rrand(0.001, 1), mix: rrand(0, 1), phase: rrand(0, 1)
          use_random_seed rrand_i(min, max)
          use_random_source [:dark_pink, :light_pink, :perlin, :pink, :white].choose
        end
      end
    end
  end
end
