use_random_seed rrand(1, 10.pow(Math::E + Math::PI))
use_random_source [:dark_pink, :light_pink, :perlin, :pink, :white].choose

tp1 = sample_duration :tbd_pad_1
tp2 = sample_duration :tbd_pad_2
tp3 = sample_duration :tbd_pad_3
tp4 = sample_duration :tbd_pad_4
gh = sample_duration :ambi_glass_hum
gr = sample_duration :ambi_glass_rub
hh = sample_duration :ambi_haunted_hum
avr_tp = (tp1 + tp2 + tp3 + tp4) / 4.to_f
avr_ambi = (gh + gr + hh) / 3.to_f
pitch_val = chord(:eb3, :minor).choose - 48
ps_val = scale(:eb3, :minor_pentatonic).choose - 48
sec = 300

define :adsr_opts do
  return {
    attack: rrand(0, 1),
    attack_level: rrand(0, 1),
    decay: rrand(0, 1),
    decay_level: rrand(0, 1),
    sustain: 2,
    sustain_level: rrand(0, 1),
    release: 2,
    relax_time: rrand(0, 1),
    on: rrand(0, 1)
  }
end

define :fx_opts do
  return {
    amp: rrand(0.01, 1),
    mix: rrand(0, 1),
    hpf: rrand(0, 118),
    lpf: rrand(0, 131)
  }.merge(adsr_opts())
end

define :pad do |i|
  in_thread do
    (sec/tp1.ceil).times do
      sample :tbd_pad_1, rpitch: i, **fx_opts()
      sleep sample_duration :tbd_pad_1, rpitch: i
    end
  end
  in_thread do
    (sec/tp2.ceil).times do
      sample :tbd_pad_2, rpitch: i-2, **fx_opts()
      sleep sample_duration :tbd_pad_2, rpitch: i-2
    end
  end
  in_thread do
    (sec/tp3.ceil).times do
      sample :tbd_pad_3, rpitch: i-2, **fx_opts()
      sleep sample_duration :tbd_pad_3, rpitch: i-2
    end
  end
  in_thread do
    (sec/tp4.ceil).times do
      sample :tbd_pad_4, rpitch: i-2, **fx_opts()
      sleep sample_duration :tbd_pad_4, rpitch: i-2
    end
  end
end

define :ambi do |j|
  in_thread do
    (sec/gh.ceil).times do
      sample :ambi_glass_hum, rpitch: j+8, **fx_opts()
      sleep sample_duration :ambi_glass_hum, rpitch: j+8
    end
  end
  in_thread do
    (sec/gr.ceil).times do
      sample :ambi_glass_rub, rpitch:j-1, **fx_opts()
      sleep sample_duration :ambi_glass_rub, rpitch: j-1
    end
  end
  in_thread do
    (sec/hh.ceil).times do
      sample :ambi_haunted_hum, rpitch: j+1, **fx_opts()
      sleep sample_duration :ambi_haunted_hum, rpitch: j+1
    end
  end
end

with_fx :gverb, room: 50, damp: 0.2, spread: 1, room_slide: 0.1, damp_slide: 0.1, spread_slide: 0.1 do |g|
  with_fx :pitch_shift, pitch_dis: 0.01, time_dis: 0.1, pitch: 24, pitch_dis_slide: 0.1, time_dis_slide: 0.1, pitch_slide: 0.1 do |ps|
    with_fx :ring_mod, freq: 880, mix: 0.7, freq_slide: 0.1, mix_slide: 0.1 do |rm|
      with_fx :vowel, voice: 3, mix: 0.4, voice_slide: 0.1, mix_slide: 0.1 do |v|
        with_fx :lpf, cutoff: 110, cutoff_slide: 0.1 do |l|
          with_fx :flanger, feedback: 0.8, depth: 5, feedback_slide: 0.1, depth_slide: 0.1 do |f|
            pad(pitch_val)
            sleep avr_tp
            control g, room: rrand(10, 100)
            control ps, pitch: ps_val
            control rm, freq: rrand(220, 1320), mix: rrand(0, 1)
            control v, voice: [0, 1, 2, 3, 4].choose, mix: rrand(0, 1)
            control l, cutoff: rrand(40, 130)
            control f, feedback: rrand(0, 1), depth: rrand(0, 10)
          end
        end
        with_fx :octaver, mix: 0.2, mix_slide: 0.1 do |o|
          with_fx :rhpf, cutoff: 100, res: 0.9, cutoff_slide: 0.1, res_slide: 0.1 do |rh|
            ambi(pitch_val)
            sleep avr_ambi
            control g, room: rrand(10, 100)
            control ps, pitch: ps_val
            control rm, freq: rrand(220, 1320), mix: rrand(0, 1)
            control v, voice: [0, 1, 2, 3, 4].choose, mix: rrand(0, 1)
            control o, mix: rrand(0, 1)
            control rh, cutoff: rrand(40, 130), res: rrand(0, 1)
          end
        end
      end
    end
  end
end
