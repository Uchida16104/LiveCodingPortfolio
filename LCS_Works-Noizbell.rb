n = 24
i = [:bnoise, :chipnoise, :cnoise, :gnoise, :noise, :pnoise]
300.times do
  p = [:echo, :ping_pong, :wobble]
  with_fx :gverb, room: 100, release: 5, room_slide: rrand(0, 1), release_slide: rrand(0, 1) do |g|
    with_fx :vowel,voice: 2, vowel_sound: 1 do |v|
      with_fx :ring_mod, freq: n + [-12, 12].choose, freq_slide: rrand(0, 1) do |rm|
        with_fx :pitch_shift, amp: 3, pitch_dis: 1, time_dis: 1, amp_slide: rrand(0, 1), pitch_dis_slide: rrand(0, 1), time_dis_slide: rrand(0, 1) do |ps|
          with_fx p.choose, phase: [0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1].tick, phase_slide: 0.5 do |s|
            use_synth i.shuffle.tick
            r = play n, amp: 0.125, amp_slide: 0.125, note_slide: 0.125, release: 0.125
            sleep 1
            control g, room: rrand(10, 100), release: rrand(1, 5)
            control v, voice: [0, 1, 2, 3, 4].choose, vowel_sound: [1, 2, 3, 4, 5].choose
            control rm, freq: n + [-12, 12].choose
            control ps, amp: rrand(0, 5), pitch_dis: rrand(0, 1), time_dis: rrand(0, 1)
            control s, phase: [0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1].tick
            control r, amp: 0.25, note: n + [-12, 12].choose
          end
        end
      end
    end
  end
end