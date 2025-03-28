define :granular do |args = {}|
  sample_name = args[:sample] || :ambi_choir #sample
  grain_size = args[:size] || 0.1 #duration
  min = args[:min] || 0 #minimum pitch
  max = args[:max] || 1 #maximum pitch
  volume = args[:amp] || 1 #volume
  mixer = args[:mix] || 0.5 #mixer
  panpot = args[:pan] || 0 #panpot
  dur = sample_duration(sample_name)
  effective_grain = [grain_size, dur].min
  grain_fraction = effective_grain / dur
  start_frac = rrand(0, 1 - grain_fraction)
  rate = (rrand_i(0, 1) == 0 ? 1 : -1) * rrand(min, max)
  sample sample_name, amp: volume, mix: mixer, pan: panpot, start: start_frac, finish: start_frac + grain_fraction, rate: rate
end
in_thread do
  64.times do
    64.times do
      granular sample: :ambi_drone, size: rrand(0, 0.1), min: rrand(0, 1), amp: rrand(0, 1), pan: rdist(-1)
      sleep 0.1
    end
  end
end
in_thread do
  64.times do
    32.times do
      granular sample: :bass_thick_c, size: rrand(0, 0.2), min: rrand(0, 2), amp: rrand(0, 1), pan: rdist(1)
      sleep 0.2
    end
  end
end
in_thread do
  64.times do
    32.times do
      granular sample: :loop_electric, size: rrand(0, 0.2), min: rrand(0, 2), amp: rrand(0, 1), pan: rdist(-1)
      sleep 0.2
    end
  end
end
in_thread do
  64.times do
    16.times do
      granular sample: :elec_blip, amp: rrand(0, 0.5), pan: rdist(1), size: rrand(0, 0.4), min: rrand(0, 4)
      sleep 0.4
    end
  end
end
in_thread do
  64.times do
    4.times do
      4.times do
        sample :hat_bdu, amp: 0.25, mix: 0.5, pan: rdist(-1)
        sleep 0.2
      end
      sample :sn_generic, amp: 0.25, mix: 0.5, pan: rdist(-1)
      sleep 0.2
      3.times do
        sample :hat_bdu, amp: 0.25, mix: 0.5, pan: rdist(-1)
        sleep 0.2
      end
    end
  end
end
in_thread do
  64.times do
    4.times do
      sample :bd_haus, amp: 0.5, mix: 0.5, pan: rdist(1)
      sleep 1.6
    end
  end
end
in_thread do
  64.times do
    with_fx :reverb, room: 1 do
      with_fx :ixi_techno do
        use_synth :rhodey
        play (chord (scale :e3, :minor_pentatonic).choose, :minor), attack: 1.6, decay: 1.6, sustain: 1.6, release: 1.6, pan: rdist(-1)
        sleep 6.4
      end
    end
  end
end
in_thread do
  64.times do
    with_fx :gverb, room: 10, amp: 0.5 do
      with_fx :ixi_techno do
        use_synth :hollow
        play (chord (scale :e3, :minor_pentatonic).choose, :minor), sustain: 6.4, pan: rdist(1)
        sleep 6.4
      end
    end
  end
end