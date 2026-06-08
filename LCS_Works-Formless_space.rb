use_random_seed Time.now.to_i
bd = sample_names(:bd).to_a.select { |name| name.to_s.include?("bd") }
hat  = sample_names(:hat).to_a.select { |name| name.to_s.include?("hat") }
glitch = sample_names(:glitch).to_a.select { |name| name.to_s.include?("glitch") }
elec  = sample_names(:elec).to_a.select { |name| name.to_s.include?("elec") }
sn = sample_names(:sn).to_a.select { |name| name.to_s.include?("sn") }
vinyl = sample_names(:vinyl).to_a.select { |name| name.to_s.include?("scratch") }
set :start_time, vt
in_thread do
  while vt - get(:start_time) < 300
    sleep 1
  end
  set :stop_all, true
end
with_fx :compressor, threshold: 0.3, clamp_time: 0.01, relax_time: 0.1 do
  with_fx :reverb,
    room: 0.9,
    mix: 0.35,
  damp: 0.5 do
    with_fx :echo,
      phase: 0.125,
      decay: 4,
    mix: 0.25 do
      with_fx :ixi_techno,
        phase: 4,
        res: 0.8,
      mix: 0.4 do
        with_fx :slicer,
          phase: 0.25,
          pulse_width: 0.7,
        mix: 0.3 do
          with_fx :bitcrusher,
            bits: 8,
            sample_rate: 12000,
          mix: 0.25 do
            live_loop :hat do
              stop if get(:stop_all)
              if hat.any?
                sample hat.choose,
                  amp: rdist(-1).abs,
                  pan: rdist(1) if one_in(1)
              end
              sleep 0.125
            end
            live_loop :bd do
              stop if get(:stop_all)
              if bd.any?
                sample bd.choose,
                  amp: rdist(-2/3.to_f).abs,
                  pan: rdist(2/3.to_f) if one_in(2)
              end
              sleep 0.125
            end
            live_loop :glitch do
              stop if get(:stop_all)
              if glitch.any?
                sample glitch.choose,
                  amp: rdist(-1/3.to_f).abs,
                  pan: rdist(1/3.to_f) if one_in(3)
              end
              sleep 0.125
            end
            live_loop :elec do
              stop if get(:stop_all)
              if elec.any?
                sample elec.choose,
                  amp: rdist(1/3.to_f).abs,
                  pan: rdist(-1/3.to_f) if one_in(4)
              end
              sleep 0.125
            end
            live_loop :sn do
              stop if get(:stop_all)
              if sn.any?
                sample sn.choose,
                  amp: rdist(2/3.to_f).abs,
                  pan: rdist(-2/3.to_f) if one_in(5)
              end
              sleep 0.125
            end
            live_loop :vinyl do
              stop if get(:stop_all)
              if vinyl.any?
                sample vinyl.choose,
                  amp: rdist(1).abs,
                  pan: rdist(-1) if one_in(6)
              end
              sleep 0.125
            end
          end
        end
      end
    end
  end
end
live_loop :tbd do
  stop if get(:stop_all)
  with_fx :reverb, damp: 1, room: 1 do
    with_fx :ping_pong, phase: 0.5, feedback:0.5 do
      with_fx :ixi_techno do
        s = [:tbd_pad_1, :tbd_pad_2, :tbd_pad_3, :tbd_pad_4].choose
        sample s, amp: 3
        sleep sample_duration(s)
      end
    end
  end
end