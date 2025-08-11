(current_bpm * 2).times do
  with_fx :flanger do
    with_fx :ping_pong do
      with_fx :lpf do
        with_fx :octaver do
          with_fx :vowel do
            with_fx :reverb, room: 1 do
              use_synth :organ_tonewheel
              white_keys = [60, 62, 64, 65, 67, 69, 71, 72]
              rest = :r
              k = []
              for i in -7..0
                k.push(i)
              end
              n = k.tick
              define :adsr do |a,d,s,r|
                return { attack: a,
                         decay: d,
                         sustain: s,
                         release: r
                         }
              end
              sequence = [
                white_keys[n],   white_keys[n + 1], rest,
                white_keys[n],   white_keys[n + 2], rest,
                white_keys[n],   white_keys[n + 3], rest,
                white_keys[n],   white_keys[n + 4], rest,
                white_keys[n],   white_keys[n + 5], rest,
                white_keys[n],   white_keys[n + 6], rest,
                white_keys[n +5], white_keys[n + 4],
                white_keys[n +3], white_keys[n + 2]
              ]
              stop if white_keys.length - 1 <= n + 6
              a = 1 / 32.to_f
              d = 1 / 32.to_f
              s = 1 / 32.to_f
              r = 1 / 32.to_f
              with_fx :ring_mod, freq: midi_to_hz(white_keys.tick) do
                sequence.each do |note|
                  play note, adsr(a, d, s, r) if note != rest
                  sleep 1 / 8.to_f
                end
              end
            end
          end
        end
      end
    end
  end
end