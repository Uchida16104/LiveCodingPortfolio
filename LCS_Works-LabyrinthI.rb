load_synthdefs "/path/to/my-synths"
midi_channel = 1

define :send_midi_note_on do |n|
  if n.is_a?(Array)
    n.each { |m| midi_note_on m, 100, channel: midi_channel }
  else
    midi_note_on n, 100, channel: midi_channel
  end
end
define :send_midi_note_off do |n|
  if n.is_a?(Array)
    n.each { |m| midi_note_off m, channel: midi_channel }
  else
    midi_note_off n, channel: midi_channel
  end
end
in_thread do
  500.times do
    use_random_seed rrand(0, 100000)
    use_random_source [:dark_pink, :light_pink, :perlin, :pink, :white].choose
    note = rrand_i(60, 84)
    sleeptime = [0.125, 0.25, 0.5, 1].choose
    if note % 2 == 0
      with_fx :reverb,
        amp: rrand(0, 1),
        mix: rrand(0, 1),
        room: 1,
        damp: 1,
        amp_slide: rrand(0, 2),
        mix_slide: rrand(0, 2),
        room_slide: rrand(0, 2),
      damp_slide: rrand(0, 2) do |e|
        use_synth :piano
        send_midi_note_on(note)
        play note, release: 5
        control e,
          amp: rrand(0, 1),
          mix: rrand(0, 1),
          room: rrand(0, 1),
          damp: rrand(0, 1)
      end
    elsif note % 3 == 0
      freq = rrand(100, 1000)
      with_fx :ring_mod,
        amp: rrand(0, 1),
        mix: rrand(0, 1),
        freq: hz_to_midi(freq),
        amp_slide: rrand(0, 2),
        mix_slide: rrand(0, 2),
      freq_slide: rrand(0, 2) do |e|
        use_synth [:piano, :pluck].choose
        send_midi_note_on(note)
        play note, release: 5
        control e,
          amp: rrand(0, 1),
          mix: rrand(0, 1),
          freq: hz_to_midi(freq)
      end
    elsif note % 4 == 0
      with_fx :bitcrusher,
        amp: rrand(0, 1),
        mix: rrand(0, 1),
        bits: rrand(4, 16),
        amp_slide: rrand(0, 2),
        mix_slide: rrand(0, 2),
      bits_slide: rrand(0, 2) do |e|
        use_synth [:piano, :pluck].choose
        send_midi_note_on(note)
        play note, release: 5
        control e,
          amp: rrand(0, 1),
          mix: rrand(0, 1),
          bits: rrand(4, 16)
      end
    elsif note % 5 == 0
      with_fx :distortion,
        amp: rrand(0, 1),
        mix: rrand(0, 1),
        distort: rrand(0, 1),
        amp_slide: rrand(0, 2),
        mix_slide: rrand(0, 2),
      distort_slide: rrand(0, 2) do |e|
        use_synth :piano
        send_midi_note_on(note)
        play note, release: 5
        control e,
          amp: rrand(0, 1),
          mix: rrand(0, 1),
          distort: rrand(0, 1)
      end
    elsif note % 6 == 0
      with_fx :nrbpf,
        amp: rrand(0, 1),
        mix: rrand(0, 1),
        centre: rrand(0, 1000),
        res: rrand(0, 1),
        amp_slide: rrand(0, 2),
        mix_slide: rrand(0, 2),
        centre_slide: rrand(0, 2),
      res_slide: rrand(0, 2) do |e|
        use_synth :piano
        send_midi_note_on(note)
        play note, release: 5
        control e,
          amp: rrand(0, 1),
          mix: rrand(0, 1),
          centre: rrand(0, 1000),
          res: rrand(0, 1)
      end
    elsif note % 7 == 0
      with_fx :nrhpf,
        amp: rrand(0, 1),
        mix: rrand(0, 1),
        cutoff: rrand(0, 131),
        res: rrand(0, 1),
        amp_slide: rrand(0, 2),
        mix_slide: rrand(0, 2),
        cutoff_slide: rrand(0, 2),
      res_slide: rrand(0, 2) do |e|
        use_synth :piano
        send_midi_note_on(note)
        play note, release: 5
        control e,
          amp: rrand(0, 1),
          mix: rrand(0, 1),
          cutoff: rrand(0, 131),
          res: rrand(0, 1)
      end
    elsif note % 8 == 0
      with_fx :nrlpf,
        amp: rrand(0, 1),
        mix: rrand(0, 1),
        cutoff: rrand(0, 131),
        res: rrand(0, 1),
        amp_slide: rrand(0, 2),
        mix_slide: rrand(0, 2),
        cutoff_slide: rrand(0, 2),
      res_slide: rrand(0, 2) do |e|
        use_synth :piano
        send_midi_note_on(note)
        play note, release: 5
        control e,
          amp: rrand(0, 1),
          mix: rrand(0, 1),
          cutoff: rrand(0, 131),
          res: rrand(0, 1)
      end
    elsif note % 9 == 0
      with_fx :vocoder_effect,
        amp: rrand(0, 1),
        mix: rrand(0, 1),
        amp_slide: rrand(0, 2),
      mix_slide: rrand(0, 2) do |e|
        use_synth [:piano, :pluck].choose
        send_midi_note_on(note)
        play note, release: 5
        control e,
          amp: rrand(0, 1),
          mix: rrand(0, 1)
      end
    else
      use_synth :piano
      send_midi_note_on(note)
      play note, release: 5
    end
    sleep sleeptime
    send_midi_note_off(note)
  end
end
in_thread do
  500.times do
    use_random_seed rrand(0, 100000)
    use_random_source [:dark_pink, :light_pink, :perlin, :pink, :white].choose
    note = [
      chord(rrand_i(36, 59), chord_names[rrand_i(0, chord_names.length - 1)]),
      [ scale(rrand_i(36, 59), scale_names[rrand_i(0, scale_names.length - 1)]).tick ]
    ].choose
    pitch = note.is_a?(Array) ? note[0] : note
    sleeptime = [0.5, 1, 1.5, 2].choose
    if pitch % 2 == 0
      with_fx :reverb,
        amp: rrand(0, 1),
        mix: rrand(0, 1),
        room: rrand(0, 1),
        damp: rrand(0, 1),
        amp_slide: rrand(0, 2),
        mix_slide: rrand(0, 2),
        room_slide: rrand(0, 2),
      damp_slide: rrand(0, 2) do |e|
        use_synth :piano
        send_midi_note_on(note)
        play note, release: 5
        control e,
          amp: rrand(0, 1),
          mix: rrand(0, 1),
          room: rrand(0, 1),
          damp: rrand(0, 1)
      end
    elsif pitch % 3 == 0
      freq = rrand(100, 1000)
      with_fx :ring_mod,
        amp: rrand(0, 1),
        mix: rrand(0, 1),
        freq: hz_to_midi(freq),
        amp_slide: rrand(0, 2),
        mix_slide: rrand(0, 2),
      freq_slide: rrand(0, 2) do |e|
        use_synth [:piano, :pluck].choose
        send_midi_note_on(note)
        play note, release: 5
        control e,
          amp: rrand(0, 1),
          mix: rrand(0, 1),
          freq: hz_to_midi(freq)
      end
    elsif pitch % 4 == 0
      with_fx :bitcrusher,
        amp: rrand(0, 1),
        mix: rrand(0, 1),
        bits: rrand(4, 16),
        amp_slide: rrand(0, 2),
        mix_slide: rrand(0, 2),
      bits_slide: rrand(0, 2) do |e|
        use_synth [:piano, :pluck].choose
        send_midi_note_on(note)
        play note, release: 5
        control e,
          amp: rrand(0, 1),
          mix: rrand(0, 1),
          bits: rrand(4, 16)
      end
    elsif pitch % 5 == 0
      with_fx :distortion,
        amp: rrand(0, 1),
        mix: rrand(0, 1),
        distort: rrand(0, 1),
        amp_slide: rrand(0, 2),
        mix_slide: rrand(0, 2),
      distort_slide: rrand(0, 2) do |e|
        use_synth :piano
        send_midi_note_on(note)
        play note, release: 5
        control e,
          amp: rrand(0, 1),
          mix: rrand(0, 1),
          distort: rrand(0, 1)
      end
    elsif pitch % 6 == 0
      with_fx :nrbpf,
        amp: rrand(0, 1),
        mix: rrand(0, 1),
        centre: rrand(0, 1000),
        res: rrand(0, 1),
        amp_slide: rrand(0, 2),
        mix_slide: rrand(0, 2),
        centre_slide: rrand(0, 2),
      res_slide: rrand(0, 2) do |e|
        use_synth :piano
        send_midi_note_on(note)
        play note, release: 5
        control e,
          amp: rrand(0, 1),
          mix: rrand(0, 1),
          centre: rrand(0, 1000),
          res: rrand(0, 1)
      end
    elsif pitch % 7 == 0
      with_fx :nrhpf,
        amp: rrand(0, 1),
        mix: rrand(0, 1),
        cutoff: rrand(0, 131),
        res: rrand(0, 1),
        amp_slide: rrand(0, 2),
        mix_slide: rrand(0, 2),
        cutoff_slide: rrand(0, 2),
      res_slide: rrand(0, 2) do |e|
        use_synth :piano
        send_midi_note_on(note)
        play note, release: 5
        control e,
          amp: rrand(0, 1),
          mix: rrand(0, 1),
          cutoff: rrand(0, 131),
          res: rrand(0, 1)
      end
    elsif pitch % 8 == 0
      with_fx :nrlpf,
        amp: rrand(0, 1),
        mix: rrand(0, 1),
        cutoff: rrand(0, 131),
        res: rrand(0, 1),
        amp_slide: rrand(0, 2),
        mix_slide: rrand(0, 2),
        cutoff_slide: rrand(0, 2),
      res_slide: rrand(0, 2) do |e|
        use_synth :piano
        send_midi_note_on(note)
        play note, release: 5
        control e,
          amp: rrand(0, 1),
          mix: rrand(0, 1),
          cutoff: rrand(0, 131),
          res: rrand(0, 1)
      end
    elsif pitch % 9 == 0
      with_fx :vocoder_effect,
        amp: rrand(0, 1),
        mix: rrand(0, 1),
        amp_slide: rrand(0, 2),
      mix_slide: rrand(0, 2) do |e|
        use_synth [:piano, :pluck].choose
        send_midi_note_on(note)
        play note, release: 5
        control e,
          amp: rrand(0, 1),
          mix: rrand(0, 1)
      end
    else
      use_synth :piano
      send_midi_note_on(note)
      play note, release: 5
    end
    sleep sleeptime
    send_midi_note_off(note)
  end
end