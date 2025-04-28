use_bpm 78
rnote=[]
8.times do
  rnote.push(rrand(60, 72))
end
live_loop :ambient_glitch1 do
  with_fx :reverb,
    room: rrand(0, 1),
    mix: rrand(0, 1) do
    with_fx :echo,
      phase: 2,
      decay: 4,
      mix: rrand(0, 1) do
      4.times do
        use_synth :hollow
        play chord(rnote.tick-12, :minor7),
          attack: 4,
          sustain: 6,
          release: 8,
          amp: 0.6,
          mix: 0.5,
          pan: rdist(-1)
        sleep 8
      end
    end
  end
end
live_loop :ambient_glitch2 do
  with_fx :reverb,
    room: rrand(0, 1),
    mix: rrand(0, 1) do
    with_fx :echo,
      phase: 2,
      decay: 4,
      mix: rrand(0, 1) do
      4.times do
        use_synth :hollow
        play chord(rnote.tick, :minor7),
          attack: 4,
          sustain: 6,
          release: 8,
          amp: 0.6,
          mix: 0.5,
          pan: rdist(1)
        sleep 8
      end
    end
  end
end
live_loop :ambient_glitch3 do
  with_fx :reverb,
    room: rrand(0, 1),
    mix: rrand(0, 1) do
    with_fx :echo,
      phase: 2,
      decay: 4,
      mix: rrand(0, 1) do
      4.times do
        use_synth :hollow
        play chord(rnote.tick+12, :minor7),
          attack: 4,
          sustain: 6,
          release: 8,
          amp: 0.6,
          mix: 0.5,
          pan: rdist(-1)
        sleep 8
      end
    end
  end
end
live_loop :glitch_elec1 do
  16.times do
    sample [:elec_blip, :elec_blip2].choose,
      rate: rrand(0.5, 1.5),
      amp: 0.0625,
      pan: rdist(1),
      mix: 0.5
    sleep [0.125, 0.25].choose
  end
end
live_loop :glitch_elec2 do
  16.times do
    sample [:elec_tick, :elec_beep].choose,
      rate: rrand(0.5, 1.5),
      amp: 0.0625,
      pan: rdist(-1),
      mix: 0.5
    sleep [0.125, 0.25].choose
  end
end
live_loop :kalimba do
  with_fx :reverb,
    amp: 1.25,
    damp: rrand(0, 1),
    mix: rrand(0, 1),
    room: rrand(0, 1) do
    16.times do
      use_synth :kalimba
      play (chord rnote.tick, :minor7).tick,
        amp: 1,
        mix: 0.5,
        pan: rdist(1)
      sleep 0.125
    end
  end
end
