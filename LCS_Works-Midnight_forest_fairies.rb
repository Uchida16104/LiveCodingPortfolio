use_random_seed Math::PI
repeat = 2.pow(2.pow(2))
ary = []
for i in 0..repeat/ 2 - 1 do
  ary.push(1 / (i + 1).to_f)
end
j = ary.map{ |k| k * -1 }
ary.concat(j)
repeat.times do
  s = [:ambi_choir, :ambi_drone, :ambi_glass_hum, :ambi_glass_rub, :ambi_piano, :guit_e_fifths, :guit_e_slide, :guit_em9, :guit_harmonics, :loop_weirdo, :tbd_pad_1, :tbd_pad_2, :tbd_pad_3, :tbd_pad_4]
  with_fx :compressor do
    with_fx :gverb, spread: 1, damp: 1, dry: 0, room: 100, ref_level: 1, tail_level: 1, release: 1, spread_slide: rrand(0, 1), damp_slide: rrand(0, 1), dry_slide: rrand(0, 1), room_slide: rrand(0, 1), ref_level_slide: rrand(0, 1), tail_level_slide: rrand(0, 1) do |g|
      with_fx :ping_pong, phase: (sample_duration s.choose) / 8.to_f, phase_slide: rrand(0, 1) do |p|
        repeat.times do
          use_random_source [:dark_pink, :light_pink, :perlin, :pink, :white].choose
          sample s.choose, start: rrand(0, (sample_duration s.choose) / 10.to_f), finish: rrand((sample_duration s.choose) / 10.to_f, (sample_duration s.choose).to_f), rate: ary.choose, slice: rrand(0, 16).to_i
          sleep (sample_duration s.choose) / 4.to_f
          control g, spread: rrand(0, 1), damp: rrand(0, 1), dry: rrand(0, 1), room: rrand(1, 100), ref_level: rrand(0, 1), tail_level: rrand(0, 1)
          control p, phase: [(sample_duration s.choose) / 16.to_f, (sample_duration s.choose) / 4.to_f].choose
        end
      end
    end
  end
end