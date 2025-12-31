def fibo(i)
  if i == 1 then
    return 0
  end
  if i == 2 then
    return 1
  end
  return fibo(i-1) + fibo(i-2)
end
in_thread do
  32.times do
    with_fx :bpf, centre: 66 do
      with_fx :compressor, slope_above: 0.1, slope_below: 1, clamp_time: 0.00000001, relax_time: 1 do
        with_fx :reverb, damp: 1, room: 1 do
          with_fx :gverb, damp: 1, dry: 1, ref_level: 1, spread: 1, tail_level: 1, room: 100 do
            with_fx :lpf, cutoff: 80 do
              with_fx :hpf, cutoff: 40 do
                for i in 1..8 do
                  with_fx :ring_mod, freq: hz_to_midi(midi_to_hz(pitch_to_ratio (chord :fs, :major7)[fibo(i)])) do
                  use_synth :piano
                  play hz_to_midi(midi_to_hz(pitch_to_ratio 72)*i), attack: 0.125, decay: 0.125, sustain: 0.25, release: 1, amp: Math.sin(i).abs.to_f*Math.cos(i).abs.to_f
                  sleep 1
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
  4.times do
    with_fx :compressor, slope_above: 0.1, slope_below: 1, clamp_time: 0.00000001, relax_time: 1 do
      with_fx :reverb, damp: 1, room: 1 do
        with_fx :gverb, damp: 1, dry: 1, ref_level: 1, spread: 1, tail_level: 1, room: 100 do
          with_fx :eq, high: 1, mid: 1, low: 1 do
            with_fx :flanger, phase: 8, phase_offset: 1, delay: 8, max_delay: 8, decay: 8, wave: 2, invert_wave: 1, invert_flange: 1, stereo_invert_wave: 1, feedback: 0.9 do
              with_fx :tremolo, depth: 1, phase: 8, phase_offset: 1, wave: 2, invert_wave: 1 do
                with_fx :lpf, cutoff: 80 do
                  with_fx :hpf, cutoff: 40 do
                    for i in 1..8 do
                      use_synth :piano
                      play (chord hz_to_midi(midi_to_hz(pitch_to_ratio (chord :fs4, :major7)[fibo(i)])), :major7), amp: Math.sin(i).abs.to_f*Math.cos(i).abs.to_f, attack: 2, decay: 2, sustain: 2, release: 2
                      sleep 8
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