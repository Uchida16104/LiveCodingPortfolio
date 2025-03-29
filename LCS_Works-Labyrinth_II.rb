load_synthdefs "/path/to/SynthFX"
midi_channel = 1
use_bpm 15
define :send_midi_note_on do |n, vel=100|
  arr = if n.is_a?(Array)
    n
  elsif n.respond_to?(:to_a)
    n.to_a
  else
    [n]
  end
  arr.each { |m| midi_note_on m, vel, channel: midi_channel }
end
define :send_midi_note_off do |n|
  arr = if n.is_a?(Array)
    n
  elsif n.respond_to?(:to_a)
    n.to_a
  else
    [n]
  end
  arr.each { |m| midi_note_off m, channel: midi_channel }
end
define :apply_ornament do |note, ornament|
  base_notes = note.respond_to?(:to_a) ? note.to_a : [note]
  case ornament
  when :none
    base_notes
  when :overtone_series
    base_notes.map { |n| [n, n+12, n+19, n+24, n+28, n+31, n+34, n+36] }.flatten
  when :ring_modulated_tritone
    base_notes.map { |n| [n, n+6] }.flatten
  when :arpeggio
    (base_notes.length > 1) ? base_notes : base_notes
  when :glissando
    base_notes.map { |n| (n..(n+12)).to_a }.flatten
  when :turn
    base_notes.map { |n| [n+1, n, n-1, n] }.flatten
  when :inverted_turn
    base_notes.map { |n| [n-1, n, n+1, n] }.flatten
  when :trill
    base_notes.map { |n| ([n, n+1] * 4) }.flatten
  when :short_ante_accent, :long_ante_accent,
      :double_ante_accent, :double_post_accent,
      :short_post_accent, :long_post_accent,
      :inverted_trill, :short_trill, :prall_triller,
      :trill_line, :upper_prall_line, :lower_prall_line,
      :double_inverted_mordent_line, :slash_turn,
      :trambolman, :prall_mordent, :upper_prall, :upward_mordent,
      :upper_mordent, :lower_mordent, :prall_lower, :prall_upper,
      :line_prall, :slide, :shake, :apoye_trenbrant, :pince,
      :tremolo
    base_notes
  else
    base_notes
  end
end
define :play_ornament do |note, ornament, opts={}|
  release_val = opts[:release] || 5
  amp_val     = opts[:amp] || 1
  total_time  = opts[:total_time] || 1
  orn_notes = apply_ornament(note, ornament)
  count = orn_notes.length
  dur = total_time.to_f / count
  orn_notes.each do |n|
    send_midi_note_on(n, (amp_val*127).to_i)
    play n, release: release_val, amp: amp_val
    sleep dur
    send_midi_note_off(n)
  end
end
use_random_seed rrand(0, 10**5)
use_random_source [:dark_pink, :light_pink, :perlin, :pink, :white].choose
current_ornament = [:none,:overtone_series,:ring_modulated_tritone,:arpeggio,:glissando,:turn,:inverted_turn,:trill]
in_thread do
  200.times do
    use_random_seed rrand(0, 10**5)
    use_random_source [:dark_pink, :light_pink, :perlin, :pink, :white].choose
    note = rrand_i(60,84)
    sleeptime = [0.125,0.25,0.5,1].choose
    if note % 2 == 0
      my_amp = rrand(0,1)
      with_fx :reverb,
        amp: my_amp,
        mix: rrand(0,1),
        room: 1,
        damp: 1,
        amp_slide: rrand(0,2),
        mix_slide: rrand(0,2),
        room_slide: rrand(0,2),
      damp_slide: rrand(0,2) do |e|
        use_synth :piano
        play_ornament(note, current_ornament.reverse.shuffle.choose, release: 5, amp: my_amp, total_time: sleeptime)
        control e,
          amp: rrand(0,1),
          mix: rrand(0,1),
          room: rrand(0,1),
          damp: rrand(0,1)
      end
    elsif note % 3 == 0
      my_amp = rrand(0,1)
      freq = rrand(100,1000)
      with_fx :ring_mod,
        amp: my_amp,
        mix: rrand(0,1),
        freq: hz_to_midi(freq),
        amp_slide: rrand(0,2),
        mix_slide: rrand(0,2),
      freq_slide: rrand(0,2) do |e|
        use_synth ([:piano,:pluck].choose)
        play_ornament(note, current_ornament.reverse.shuffle.choose, release: 5, amp: my_amp, total_time: sleeptime)
        control e,
          amp: rrand(0,1),
          mix: rrand(0,1),
          freq: hz_to_midi(freq)
      end
    elsif note % 4 == 0
      my_amp = rrand(0,1)
      with_fx :bitcrusher,
        amp: my_amp,
        mix: rrand(0,1),
        bits: rrand(4,16),
        amp_slide: rrand(0,2),
        mix_slide: rrand(0,2),
      bits_slide: rrand(0,2) do |e|
        use_synth ([:piano,:pluck].choose)
        play_ornament(note, current_ornament.reverse.shuffle.choose, release: 5, amp: my_amp, total_time: sleeptime)
        control e,
          amp: rrand(0,1),
          mix: rrand(0,1),
          bits: rrand(4,16)
      end
    elsif note % 5 == 0
      my_amp = rrand(0,1)
      with_fx :distortion,
        amp: my_amp,
        mix: rrand(0,1),
        distort: rrand(0,1),
        amp_slide: rrand(0,2),
        mix_slide: rrand(0,2),
      distort_slide: rrand(0,2) do |e|
        use_synth :piano
        play_ornament(note, current_ornament.reverse.shuffle.choose, release: 5, amp: my_amp, total_time: sleeptime)
        control e,
          amp: rrand(0,1),
          mix: rrand(0,1),
          distort: rrand(0,1)
      end
    elsif note % 6 == 0
      my_amp = rrand(0,1)
      with_fx :nrbpf,
        amp: my_amp,
        mix: rrand(0,1),
        centre: rrand(0,1000),
        res: rrand(0,1),
        amp_slide: rrand(0,2),
        mix_slide: rrand(0,2),
        centre_slide: rrand(0,2),
      res_slide: rrand(0,2) do |e|
        use_synth :piano
        play_ornament(note, current_ornament.reverse.shuffle.choose, release: 5, amp: my_amp, total_time: sleeptime)
        control e,
          amp: rrand(0,1),
          mix: rrand(0,1),
          centre: rrand(0,1000),
          res: rrand(0,1)
      end
    elsif note % 7 == 0
      my_amp = rrand(0,1)
      with_fx :nrhpf,
        amp: my_amp,
        mix: rrand(0,1),
        cutoff: rrand(0,131),
        res: rrand(0,1),
        amp_slide: rrand(0,2),
        mix_slide: rrand(0,2),
        cutoff_slide: rrand(0,2),
      res_slide: rrand(0,2) do |e|
        use_synth :piano
        play_ornament(note, current_ornament.reverse.shuffle.choose, release: 5, amp: my_amp, total_time: sleeptime)
        control e,
          amp: rrand(0,1),
          mix: rrand(0,1),
          cutoff: rrand(0,131),
          res: rrand(0,1)
      end
    elsif note % 8 == 0
      my_amp = rrand(0,1)
      with_fx :nrlpf,
        amp: my_amp,
        mix: rrand(0,1),
        cutoff: rrand(0,131),
        res: rrand(0,1),
        amp_slide: rrand(0,2),
        mix_slide: rrand(0,2),
        cutoff_slide: rrand(0,2),
      res_slide: rrand(0,2) do |e|
        use_synth :piano
        play_ornament(note, current_ornament.reverse.shuffle.choose, release: 5, amp: my_amp, total_time: sleeptime)
        control e,
          amp: rrand(0,1),
          mix: rrand(0,1),
          cutoff: rrand(0,131),
          res: rrand(0,1)
      end
    elsif note % 9 == 0
      my_amp = rrand(0,1)
      with_fx :vocoder_effect,
        amp: my_amp,
        mix: rrand(0,1),
        amp_slide: rrand(0,2),
      mix_slide: rrand(0,2) do |e|
        use_synth ([:piano,:pluck].choose)
        play_ornament(note, current_ornament.reverse.shuffle.choose, release: 5, amp: my_amp, total_time: sleeptime)
        control e,
          amp: rrand(0,1),
          mix: rrand(0,1)
      end
    else
      my_amp = rrand(0,1)
      use_synth :piano
      play_ornament(note, current_ornament.reverse.shuffle.choose, release: 5, amp: my_amp, total_time: sleeptime)
    end
  end
end
in_thread do
  200.times do
    use_random_seed rrand(0,10**5)
    use_random_source [:dark_pink, :light_pink, :perlin, :pink, :white].choose
    note = [
      chord(rrand_i(36,59), chord_names[rrand_i(0, chord_names.length - 1)]),
      [ scale(rrand_i(36,59), scale_names[rrand_i(0, scale_names.length - 1)]).tick ]
    ].choose
    pitch = note.respond_to?(:to_a) ? note.to_a[0] : note
    sleeptime = [0.5,1,1.5,2].choose
    if pitch % 2 == 0
      my_amp = rrand(0,1)
      with_fx :reverb,
        amp: my_amp,
        mix: rrand(0,1),
        room: rrand(0,1),
        damp: rrand(0,1),
        amp_slide: rrand(0,2),
        mix_slide: rrand(0,2),
        room_slide: rrand(0,2),
      damp_slide: rrand(0,2) do |e|
        use_synth :piano
        play_ornament(note, current_ornament.reverse.shuffle.choose, release: 5, amp: my_amp, total_time: sleeptime)
        control e,
          amp: rrand(0,1),
          mix: rrand(0,1),
          room: rrand(0,1),
          damp: rrand(0,1)
      end
    else
      my_amp = rrand(0,1)
      use_synth :piano
      play_ornament(note, current_ornament.reverse.shuffle.choose, release: 5, amp: my_amp, total_time: sleeptime)
    end
  end
end
