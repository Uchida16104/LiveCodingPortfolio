def freq(i)
  num=[]
  wave=[]
  invert_wave=[]
  stereo_invert_wave=[]
  invert_flange=[]
  vowel_sound=[]
  voice=[]
  for j in 1..8 do
    num.push(j)
  end
  for k in 0..4 do
    wave.push(k)
  end
  for l in 0..1 do
    invert_wave.push(l)
  end
  for m in 0..1 do
    stereo_invert_wave.push(m)
  end
  for n in 0..1 do
    invert_flange.push(n)
  end
  for o in 1..5 do
    vowel_sound.push(o)
  end
  for p in 0..4 do
    voice.push(p)
  end
  with_fx :tremolo, mix: Math.sin(i).abs, depth: Math.cos(i).abs, wave: wave.tick, invert_wave: invert_wave.tick, phase: Math.sin(i).abs, phase_offset: Math.cos(i).abs do
    with_fx :reverb, mix: Math.sin(i).abs, damp: Math.cos(i).abs, room: Math.sin(i).abs do
      with_fx :ping_pong, mix: Math.cos(i).abs, phase: Math.sin(i).abs*2 do
        with_fx :eq, mix: Math.cos(i).abs, high: Math.sin(i)-(Math::PI**2), mid: Math.cos(i)-(Math::PI**2), low: Math.sin(i)-(Math::PI**2) do
          with_fx :compressor, mix: Math.cos(i).abs, clamp_time: Math.sin(i).abs, relax_time: Math.cos(i).abs, threshold: Math.sin(i).abs do
            with_fx :band_eq, mix: Math.cos(i).abs, freq: hz_to_midi(i*num.tick).abs do
              with_fx :lpf, mix: Math.sin(i).abs, cutoff: i do
                with_fx :ixi_techno, mix: Math.cos(i).abs, cutoff_min: Math.sin(i).abs*60, cutoff_max: Math.cos(i).abs*120, phase: Math.sin(i).abs, phase_offset: Math.cos(i).abs, res: Math.sin(i).abs do
                  with_fx :flanger, mix: Math.cos(i).abs, decay: Math.sin(i).abs, delay: Math.cos(i).abs, depth: Math.sin(i).abs, feedback: Math.cos(i).abs, invert_flange: invert_flange.shuffle.tick, invert_wave: invert_wave.shuffle.tick, max_delay: Math.sin(i).abs, phase: Math.cos(i).abs, phase_offset: Math.sin(i).abs, stereo_invert_wave: stereo_invert_wave.shuffle.tick, wave: wave.shuffle.tick do
                    with_fx :normaliser, mix: Math.cos(i).abs, level: Math.sin(i).abs do
                      with_fx :octaver, mix: Math.cos(i).abs do
                        with_fx :pitch_shift, mix: Math.sin(i).abs, pitch: Math.cos(i), time_dis: Math.sin(i).abs do
                          with_fx :ring_mod, mix: Math.cos(i).abs, freq: hz_to_midi(i*num.tick).abs do
                            with_fx :vowel, mix: Math.sin(i).abs, vowel_sound: vowel_sound.shuffle.tick, voice: voice.shuffle.tick do
                              with_fx :echo, mix: Math.cos(i).abs, phase: Math.sin(i).abs do
                                with_fx :gverb, mix: Math.cos(i).abs, room: (Math.sin(i).abs+1)*100, damp: Math.cos(i).abs, spread: Math.sin(i).abs do
                                  use_synth :hollow
                                  play (chord i.abs, [:major, :minor, :augmented, :diminished].shuffle.tick), amp: rdist(-1).abs, mix: rdist(1).abs, pan: rdist(-1), attack: rdist(1).abs, attack_level: rdist(-1).abs, decay: rdist(1).abs, decay_level: rdist(-1).abs, sustain: rdist(1).abs, sustain_level: rdist(-1).abs, release: rdist(1).abs, on: rdist(-1).abs
                                  sleep Math.cos(i).abs*Math::PI
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
    end
  end
end
for q in 1..150 do
  freq((Math.sin(q)*100).abs)
end