define :cluster do |base, start_offset, max_offset|
  chords = []
  end_offset = rrand_i(start_offset + 1, max_offset)
  (start_offset..end_offset).each do |i|
    chords.push(base + i)
  end
  chords
end
define :play_cluster_with_midi do
  chord_notes = cluster(rrand_i(36, 60), rrand_i(2, 12), 24)
  amp_val = rrand(0, 1)
  duration = rrand(0, 2)
  play chord_notes, amp: amp_val
  chord_notes.each do |note|
    midi_note_on note, velocity: (amp_val * 127).round
  end
  sleep duration
  chord_notes.each do |note|
    midi_note_off note
  end
end
300.times do
  use_synth :piano
  play_cluster_with_midi
end
