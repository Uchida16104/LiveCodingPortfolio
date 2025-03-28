major_chords = chord_names.to_a.select { |ch| ch.to_s.include?("majo") }
minor_chords = chord_names.to_a.select { |ch| ch.to_s.include?("mino") }
major_scales = scale_names.to_a.select { |sc| sc.to_s.include?("majo") }
minor_scales = scale_names.to_a.select { |sc| sc.to_s.include?("mino") }
$notes_to_off = []
define :vol do
  ary = []
  for i in 1..16 do
    ary.push(1/16.to_f * i)
  end
  for i in 1..14 do
    ary.push(1/14.to_f * i)
  end
  for i in 1..12 do
    ary.push(1/12.to_f * i)
  end
  for i in 1..10 do
    ary.push(1/10.to_f * i)
  end
  return ary.choose
end

define :play_midi do |n, opts = {}|
  play n, opts
  midi_opts = opts.dup
  if midi_opts.has_key?(:amp)
    midi_opts[:velocity] = (midi_opts.delete(:amp).to_f * 127).round
  end
  if n.nil?
    return
  elsif n.is_a?(Array)
    n.each { |nn|
      if nn.respond_to?(:round)
        midi_note_on(nn, midi_opts)
        $notes_to_off << [nn, midi_opts]
      end
    }
  elsif n.respond_to?(:round)
    midi_note_on n, midi_opts
    $notes_to_off << [n, midi_opts]
  end
end
define :chtree do |note, mode, time|
  majch1 = (chord note, major_chords.choose).length
  minch1 = (chord note, minor_chords.choose).length
  majch2 = major_chords.choose
  minch2 = minor_chords.choose
  if mode == "maj"
    majch1.times do
      play_midi (chord note, majch2).reverse.shuffle.tick
      play_midi (chord note, majch2).shuffle.tick if one_in(2)
      play_midi (chord note, majch2).tick if one_in(3)
      play_midi (chord note, majch2).choose if one_in(4)
      play_midi (chord note, majch2).reverse.choose if one_in(5)
      play_midi (chord note, majch2).shuffle.choose if one_in(6)
      play_midi (chord note, majch2).reverse.shuffle.choose if one_in(7)
      play_midi (chord note, majch2) if one_in(8)
      d = time / majch1.to_f
      sleep d
      $notes_to_off.each { |n_opts| midi_note_off(n_opts[0], n_opts[1]) }
      $notes_to_off.clear
    end
  elsif mode == "min"
    minch1.times do
      play_midi (chord note, minch2).reverse.shuffle.tick, amp: vol, mix: rdist(1).abs
      play_midi (chord note, minch2).shuffle.tick, amp: vol, mix: rdist(-1).abs if one_in(2)
      play_midi (chord note, minch2).tick, amp: vol, mix: rdist(1).abs if one_in(3)
      play_midi (chord note, minch2).choose, amp: vol, mix: rdist(-1).abs if one_in(4)
      play_midi (chord note, minch2).reverse.choose, amp: vol, mix: rdist(1).abs if one_in(5)
      play_midi (chord note, minch2).shuffle.choose, amp: vol, mix: rdist(-1).abs if one_in(6)
      play_midi (chord note, minch2).reverse.shuffle.choose, amp: vol, mix: rdist(1).abs if one_in(7)
      play_midi (chord note, minch2), amp: vol, mix: rdist(-1).abs if one_in(8)
      d = time / minch1.to_f
      sleep d
      $notes_to_off.each { |n_opts| midi_note_off(n_opts[0], n_opts[1]) }
      $notes_to_off.clear
    end
  end
end
define :sctree do |note, mode, time|
  majsc1 = (scale note, major_scales.shuffle.tick).length
  minsc1 = (scale note, minor_scales.shuffle.tick).length
  majsc2 = major_scales.shuffle.tick
  minsc2 = minor_scales.shuffle.tick
  if mode == "maj"
    majsc1.times do
      play_midi (scale note, majsc2).reverse.shuffle.tick, amp: vol, mix: rdist(-1).abs
      play_midi (scale note, majsc2).shuffle.tick, amp: vol, mix: rdist(1).abs if one_in(2)
      play_midi (scale note, majsc2).tick, amp: vol, mix: rdist(-1).abs if one_in(3)
      play_midi (scale note, majsc2).choose, amp: vol, mix: rdist(1).abs if one_in(4)
      play_midi (scale note, majsc2).reverse.choose, amp: vol, mix: rdist(-1).abs if one_in(5)
      play_midi (scale note, majsc2).shuffle.choose, amp: vol, mix: rdist(1).abs if one_in(6)
      play_midi (scale note, majsc2).reverse.shuffle.choose, amp: vol, mix: rdist(-1).abs if one_in(7)
      play_midi (scale note, majsc2), amp: vol, mix: rdist(1).abs if one_in(8)
      d = time / majsc1.to_f
      sleep d
      $notes_to_off.each { |n_opts| midi_note_off(n_opts[0], n_opts[1]) }
      $notes_to_off.clear
    end
  elsif mode == "min"
    minsc1.times do
      play_midi (scale note, majsc2).reverse.shuffle.tick, amp: vol, mix: rdist(1).abs
      play_midi (scale note, minsc2).shuffle.tick, amp: vol, mix: rdist(-1).abs if one_in(2)
      play_midi (scale note, minsc2).tick, amp: vol, mix: rdist(1).abs if one_in(3)
      play_midi (scale note, minsc2).choose, amp: vol, mix: rdist(-1).abs if one_in(4)
      play_midi (scale note, majsc2).reverse.choose, amp: vol, mix: rdist(1).abs if one_in(5)
      play_midi (scale note, minsc2).shuffle.choose, amp: vol, mix: rdist(-1).abs if one_in(6)
      play_midi (scale note, minsc2).reverse.shuffle.choose, amp: vol, mix: rdist(1).abs if one_in(7)
      play_midi (scale note, minsc2), amp: vol, mix: rdist(-1).abs if one_in(8)
      d = time / minsc1.to_f
      sleep d
      $notes_to_off.each { |n_opts| midi_note_off(n_opts[0], n_opts[1]) }
      $notes_to_off.clear
    end
  end
end
use_synth :piano
in_thread do
  100.times do
    use_bpm rrand_i(20, 104)
    sctree(rrand_i(60, 72), ["maj", "min"].choose, [1, 2, 4].choose)
  end
end
in_thread do
  100.times do
    use_bpm rrand_i(20, 104)
    chtree(rrand_i(36, 48), ["maj", "min"].choose, [1, 2, 4].choose)
  end
end