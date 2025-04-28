use_random_seed (1..10).to_a.choose
use_random_source [:dark_pink, :light_pink, :perlin, :pink, :white].choose
use_bpm 78
live_loop :ambient do
  with_fx :compressor, mix: rrand(0, 1), mix_slide: rrand(0, 1) do |compressor|
    with_fx :normaliser, mix: rrand(0, 1), level: rrand(0, 1), mix_slide: rrand(0, 1), level_slide: rrand(0, 1) do |normaliser|
      with_fx :reverb, mix: rrand(0, 1), room: rrand(0, 1), damp: rrand(0, 1), mix_slide: rrand(0, 1), room_slide: rrand(0, 1), damp_slide: rrand(0, 1) do |reverb|
        ary=[]
        for k in 1..8 do
          ary.push(0.125*k)
        end
        sleep ary.choose
        live_loop :bass do
          use_synth :bass_foundation
          play (chord :f2+(1 / 2).to_f, :minor)
          sleep 2
        end
        live_loop :chord do
          8.times do
            with_fx :ixi_techno, mix: rrand(0, 1), phase: ary.choose, cutoff_min: rrand(50, 70), cutoff_max: rrand(110, 130), mix_slide: rrand(0, 1), phase_slide: rrand(0, 1), cutoff_min_slide: rrand(0, 1), cutoff_max_slide: rrand(0, 1) do |ixi_techno|
              use_synth :mod_beep
              play (chord :f5+(1 / 3).to_f, :minor).tick, amp: rrand(0, 1), attack: 0.03125, decay: 0.03125, sustain: 0.03125, release: 0.03125
              play (chord :f5+(1 / 5).to_f, :minor).reverse.tick, amp: rrand(0, 1) if one_in(2)
              play (chord :f5+(1 / 7).to_f, :minor).shuffle.tick, amp: rrand(0, 1) if one_in(3)
              play (chord :f5+(1 / 11).to_f, :minor).shuffle.reverse.tick, amp: rrand(0, 1) if one_in(4)
              sleep 0.25
              control ixi_techno, mix: rrand(0, 1), phase: ary.choose, cutoff_min: rrand(50, 70), cutoff_max: rrand(110, 130)
            end
            sleep 2
          end
        end
        live_loop :main do
          use_synth :hollow
          play (chord :f4+(1 / 13).to_f, :minor), amp: rrand(0, 1)
          sleep 0.5
        end
        live_loop :sub do
          use_synth :dark_ambience
          play (chord :f3+(1 / 17).to_f, :minor), amp: rrand(0, 1)
          sleep 1
        end
        live_loop :elec do
          rslice=rrand_i(1, 16)
          rsample=sample_names(sample_groups[5]).choose
          rslice.times do
            with_fx :slicer, mix: rrand(0, 1), phase: 0.125, mix_slide: rrand(0, 1), phase_slide: rrand(0, 1) do |slicer1|
              sample rsample, amp: rrand(0, 1), slice: rslice
              sleep 1/rslice.to_f
              control slicer1, mix: rrand(0, 1)
            end
          end
        end
        (0..31).each do |i|
          live_loop :"glitch#{i}" do
            with_fx :ping_pong, mix: rrand(0, 1), phase: ary.choose, mix_slide: rrand(0, 1), phase_slide: rrand(0, 1) do |ping_pong1|
              rand_seed_list = ary.map{ |a| a + 1 }
              rand_seed = rand_seed_list.choose
              use_random_source [:dark_pink, :light_pink, :perlin, :pink, :white].choose
              seed = ([true, false].choose) ? rand_seed : 1
              use_random_seed rrand(0, rrand_i(1, 16).pow(Math::PI * Math::PI * seed))
              rand_amp    = rrand(0, 1)
              rand_start  = rrand(0, 1)
              rand_finish = rrand(0, rand_seed_list.choose)
              rand_slice  = rrand_i(0, 16)
              repeat_count = rrand_i(2, 8)
              samples = sample_names(sample_groups[0])
              rand_sample = samples[rrand_i(0, samples.length - 1)]
              rand_sleep = sample_duration(rand_sample) / [2, 4, 128, 256].choose
              rrate=[]
              for j in 1..8 do
                rrate.push(-1 / j.to_f)
                rrate.push(1 / j.to_f)
                rrate.push(j.to_f)
                rrate.push(-j.to_f)
              end
              rand_rate = rrate.choose
              repeat_count.times do
                sample rand_sample,
                  amp:    rand_amp,
                  start:  rand_start,
                  finish: rand_finish,
                  slice:  rand_slice,
                  rate:   rand_rate
                sleep [0.125, 0.25].choose * [1, 2, 32, 64].choose
              end
              control ping_pong1, mix: rrand(0, 1), phase: ary.choose
            end
          end
        end
        (32..63).each do |i|
          live_loop :"glitch#{i}" do
            with_fx :ping_pong, mix: rrand(0, 1), phase: ary.choose, mix_slide: rrand(0, 1), phase_slide: rrand(0, 1) do |ping_pong2|
              with_fx :slicer, mix: rrand(0, 1), mix_slide: rrand(0, 1) do |slicer2|
                rand_seed_list = ary.map{ |a| a + 1 }
                rand_seed = rand_seed_list.choose
                use_random_source [:dark_pink, :light_pink, :perlin, :pink, :white].choose
                seed = ([true, false].choose) ? rand_seed : 1
                use_random_seed rrand(0, rrand_i(1, 16).pow(Math::PI * Math::PI * seed))
                rand_amp    = rrand(0, 1)
                rand_start  = rrand(0, 1)
                rand_finish = rrand(0, rand_seed_list.choose)
                rand_slice  = rrand_i(0, 16)
                repeat_count = rrand_i(2, 8)
                samples = sample_names(sample_groups[7])
                rand_sample = samples[rrand_i(0, samples.length - 1)]
                rand_sleep = sample_duration(rand_sample) / [2, 4, 128, 256].choose
                rrate=[]
                for j in 1..8 do
                  rrate.push(-1 / j.to_f)
                  rrate.push(1 / j.to_f)
                  rrate.push(j.to_f)
                  rrate.push(-j.to_f)
                end
                rand_rate = rrate.choose
                repeat_count.times do
                  sample rand_sample,
                    amp:    rand_amp,
                    start:  rand_start,
                    finish: rand_finish,
                    slice:  rand_slice,
                    rate:   rand_rate
                  sleep [0.125, 0.25].choose * [1, 2, 32, 64].choose
                end
                control slicer2, mix: rrand(0, 1)
              end
              control ping_pong2, mix: rrand(0, 1), phase: ary.choose
            end
          end
        end
        control reverb, mix: rrand(0, 1), room: rrand(0, 1), damp: rrand(0, 1)
      end
      control normaliser, mix: rrand(0, 1), level: rrand(0, 1)
    end
    control compressor, mix: rrand(0, 1)
  end
end