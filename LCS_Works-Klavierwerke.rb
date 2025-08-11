define :filter_names_by_keyword do |name_list, keyword|
  result = []
  for name in name_list
    if name.to_s.include?(keyword)
      result.push(name)
    end
  end
  return result
end
use_synth :piano
chords = filter_names_by_keyword(chord_names, "major")
scales = filter_names_by_keyword(scale_names, "major")
key = :eb3
repeat = (1..20).sum
dur = Math::E.floor
min = -1
max = min.abs
define :adsr do |v,m,p,a,al,d,dl,s,sl,r,o|
  return { amp: v, mix: m, pan: p, attack: a, attack_level: al, decay: d, decay_level: dl, sustain: s, sustain_level: sl, release: r, on: o,  env_curve: [1, 2, 3, 4, 6, 7].choose, amp_slide: rrand(0, 1), mix_slide: rrand(0, 1), pan_slide: rrand(0, 1), on_slide: rrand(0, 1), note_slide: rrand(0, 1)}
end
with_fx :compressor do
  with_fx :reverb, room: 1, damp: 1 do
    with_fx :gverb, room: 100, spread: 1, damp: 1, ref_level: 1, tail_level: 1, release: 8 do
      with_fx :lpf do
        with_fx :ixi_techno, mix: 0.25 do
          with_fx :flanger do
            in_thread do
              repeat.times do
                c1 = play chord(key, chords.choose).shuffle, adsr(rrand(0, 1), rrand(0, 1), rdist(-1), rrand(1, 2), rrand(0, 1), rrand(1, 2), rrand(0, 1), rrand(1, 2), rrand(0, 1), rrand(1, 2), rrand(0, 1))
                sleep dur
                control c1, note: key + [min, max].choose, on: rrand(0, 1)
              end
            end
            in_thread do
              repeat.times do
                s1 = play scale(key, scales.shuffle.tick).shuffle.tick, adsr(rrand(0, 1), rrand(0, 1), rdist(-1), rrand(1, 2), rrand(0, 1), rrand(1, 2), rrand(0, 1), rrand(1, 2), rrand(0, 1), rrand(1, 2), rrand(0, 1))
                sleep dur
                control s1, note: key + [min, max].choose, on: rrand(0, 1)
              end
            end
            in_thread do
              repeat.times do
                c2 = play chord(key + 12, chords.choose).shuffle, adsr(rrand(0, 1), rrand(0, 1), rdist(1), rrand(1, 2), rrand(0, 1), rrand(1, 2), rrand(0, 1), rrand(1, 2), rrand(0, 1), rrand(1, 2), rrand(0, 1))
                sleep dur
                control c2, note: key + 12 + [min, max].choose, on: rrand(0, 1)
              end
            end
            in_thread do
              repeat.times do
                s2 = play scale(key + 12, scales.shuffle.tick).shuffle.tick, adsr(rrand(0, 1), rrand(0, 1), rdist(1), rrand(1, 2), rrand(0, 1), rrand(1, 2), rrand(0, 1), rrand(1, 2), rrand(0, 1), rrand(1, 2), rrand(0, 1))
                sleep dur
                control s2, note: key + 12 + [min, max].choose, on: rrand(0, 1)
              end
            end
          end
        end
      end
    end
  end
end