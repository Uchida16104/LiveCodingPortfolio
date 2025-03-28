define :randPatterns do |tempo, min, max, step|
  use_bpm tempo
  use_random_seed rrand(min, max)
  use_random_source [:dark_pink, :light_pink, :perlin, :pink, :white].shuffle.tick(step: step)
end
randPatterns(60, 0, 10, 3)
ambi_samples = sample_names(sample_groups[0])
glitch_samples = sample_names(sample_groups[6])
elec_samples = sample_names(sample_groups[5])
misc_samples = sample_names(sample_groups[11])
mehackit_samples = sample_names(sample_groups[10])
live_loop :ambient_sounds do
  sample(ambi_samples.choose, amp: rrand(0.5, 1), mix: rrand(0, 1), pan: rrand(-1, 1), rate: [-0.5, -1, -1.5, -2, 0.5, 1, 1.5, 2].choose, beat_stretch: [4, 8, 16].choose)
  sleep [4, 8, 16].choose * [1, 1.5, 2].choose
end
live_loop :glitchy_percussions, sync: :ambient_sounds do
  sample(glitch_samples.choose, amp: rrand(0.5, 1), mix: rrand(0, 1), pan: rrand(-1, 1), rate: [-0.5, -1, -1.5, -2, 0.5, 1, 1.5, 2].choose, beat_stretch: [2, 4, 8].choose, start: [0.1, 0.2, 0.3].choose)
  sleep [2, 4, 6].choose * [1, 1.5, 2].choose
end
live_loop :elec_textures, sync: :ambient_sounds do
  with_fx :reverb, mix: 0.5, mix_slide: rrand(0.125, 0.5) do |reverb1|
    sample(elec_samples.choose, amp: rrand(0.5, 1), mix: rrand(0, 1), pan: rrand(-1, 1), rate: [-0.5, -1, -1.5, -2, 0.5, 1, 1.5, 2].choose, beat_stretch: 8)
    sleep [2, 4, 6].choose * [1, 1.5, 2].choose
    control reverb1, mix: rrand(0, 1)
  end
end
live_loop :noisy_ambient, sync: :ambient_sounds do
  with_fx :echo, phase: [0.25, 0.5, 1].choose, mix: 0.3, phase_slide: rrand(0.125, 0.5), mix_slide: rrand(0.125, 0.5) do |echo1|
    sample(misc_samples.choose, amp: rrand(0.5, 1), mix: rrand(0, 1), pan: rrand(-1, 1), rate: [-0.5, -1, -1.5, 0.5, 1, 1.5].choose, beat_stretch: 8)
    sleep [3, 5, 7].choose * [1, 1.5, 2].choose
    control echo1, phase: [0.25, 0.5, 1].choose, mix: rrand(0, 1)
  end
end
live_loop :mehackit_bass, sync: :ambient_sounds do
  with_fx :lpf, cutoff: [60, 100, 120].choose, cutoff_slide: rrand(0.125, 0.5) do |lpf|
    sample(mehackit_samples.choose, amp: rrand(0.5, 1), mix: rrand(0, 1), pan: rrand(-1, 1), rate: [-0.5, -1, -1.5, 0.5, 1, 1.5].choose)
    sleep [3, 5, 7].choose * [1, 1.5, 2].choose
    control lpf, cutoff: [60, 100, 120].choose
  end
end
live_loop :glitch_effects, sync: :ambient_sounds do
  with_fx :bitcrusher, bits: 8, sample_rate: [4000, 6000, 8000].choose, bits_slide: rrand(0.125, 0.5), sample_rate_slide: rrand(0.125, 0.5) do |bitcrusher|
    sample(glitch_samples.choose, amp: rrand(0.5, 1), mix: rrand(0, 1), pan: rrand(-1, 1), rate: [-0.5, -1, -1.5, 0.5, 1, 1.5].choose, beat_stretch: 16)
    sleep [2, 4, 8].choose * [1, 1.5, 2].choose
    control bitcrusher, bits: rrand(1, 16), sample_rate: [4000, 6000, 8000].choose
  end
end
live_loop :random_repeats, sync: :ambient_sounds do
  3.times do
    sample(ambi_samples.choose, amp: rrand(0.5, 1), mix: rrand(0, 1), pan: rrand(-1, 1), rate: [-0.5, -1, -1.5, 0.5, 1, 1.5].choose, beat_stretch: 4)
    sleep [2, 3, 4].choose * [1, 1.5, 2].choose
  end
end
live_loop :crystal_chimes, sync: :ambient_sounds do
  with_fx :reverb, room: 0.9, mix: 0.7, room_slide: rrand(0.125, 0.5), mix_slide: rrand(0.125, 0.5) do |reverb2|
    use_synth :pretty_bell
    note = chord(:e4, :m7).choose
    s = play note, amp: rrand(0.5, 1), attack: 0.5, release: 6, pan: rrand(-0.5, 0.5), note_slide: 1, amp_slide: 1, pan_slide: 1
    sleep [1, 2, 3].choose * [1, 1.5, 2].choose
    control s, note: chord(:e4, :m7).choose, amp: rrand(0.5, 1), pan: rrand(-0.5, 0.5)
    control reverb2, room: rrand(0, 1), mix: rrand(0, 1)
  end
end
live_loop :ambient_pads, sync: :ambient_sounds do
  with_fx :slicer, phase: [0.25, 0.5, 1].choose, probability: 0.5, phase_slide: rrand(0.125, 0.5), probability_slide: rrand(0.125, 0.5) do |slicer|
    use_synth :hollow
    notes = chord(:c3, :sus2)
    t = play notes.choose, amp: rrand(0.5, 1), attack: 1, sustain: 3, release: 12, pan: rrand(-1, 1), note_slide: 1, amp_slide: 1, pan_slide: 1
    sleep [2, 4, 8].choose * [1, 1.5].choose
    control t, note: notes.choose, amp: rrand(0.5, 1), pan: rrand(-1, 1)
    control slicer, phase: [0.25, 0.5, 1].choose, probability: rrand(0, 1)
  end
end
live_loop :complex_iterations, sync: :ambient_sounds do
  with_fx :ixi_techno, amp: rrand(0, 1), mix: rrand(0, 1), amp_slide: rrand(0.125, 0.5), mix_slide: rrand(0.125, 0.5) do |ixi_techno|
    with_fx :nrlpf, amp: rrand(0, 1), mix: rrand(0, 1), amp_slide: rrand(0.125, 0.5), mix_slide: rrand(0.125, 0.5) do |nrlpf|
      with_fx :ring_mod, amp: rrand(0, 1), mix: rrand(0, 1), freq: rrand(60, 84), amp_slide: rrand(0.125, 0.5), mix_slide: rrand(0.125, 0.5), freq_slide: rrand(0.125, 0.5) do |ring_mod|
        with_fx :vowel, amp: rrand(0, 1), mix: rrand(0, 1), amp_slide: rrand(0.125, 0.5), mix_slide: rrand(0.125, 0.5) do |vowel|
          use_synth :piano
          notes = [:g4, :b4, :d5, :e5].shuffle
          u = play notes.tick, amp: rrand(0.5, 1), release: 1, pan: rrand(-1, 1), note_slide: 0.3, amp_slide: 0.3, pan_slide: 0.3
          sleep [0.25, 0.5, 1].choose
          control u, note: notes.tick, amp: rrand(0.5, 1), pan: rrand(-1, 1)
          control ixi_techno, amp: rrand(0, 1), mix: rrand(0, 1)
          control nrlpf, amp: rrand(0, 1), mix: rrand(0, 1)
          control ring_mod, amp: rrand(0, 1), mix: rrand(0, 1), freq: rrand(60, 84)
          control vowel, amp: rrand(0, 1), mix: rrand(0, 1)
        end
      end
    end
  end
end
live_loop :stuttered_textures, sync: :ambient_sounds do
  with_fx :echo, phase: [0.125, 0.25, 0.5].choose, mix: 0.4, phase_slide: rrand(0.125, 0.5), mix_slide: rrand(0.125, 0.5) do |echo2|
    sample :ambi_choir, amp: rrand(0.5, 1), pan: rrand(-1, 1), rate: [-1, 0.5, 1, 1.5].choose, start: rrand(0, 0.5), finish: rrand(0.5, 1)
    sleep [1, 2, 3].choose * [1, 1.5, 2].choose
    control echo2, phase: [0.125, 0.25, 0.5].choose, mix: rrand(0, 1)
  end
end
live_loop :glitchy_reversals, sync: :ambient_sounds do
  sample :glitch_perc1, amp: rrand(0.5, 1), pan: rrand(-1, 1), rate: [1, -1].choose, start: rrand(0, 0.3), finish: rrand(0.7, 1)
  sleep [0.5, 1, 2].choose * [1, 1.5, 2].choose
end
live_loop :random_synth_chords, sync: :ambient_sounds do
  with_fx :flanger, depth: [2, 3].choose, mix: 0.5, depth_slide: rrand(0.125, 0.5), mix_slide: rrand(0.125, 0.5) do |flanger|
    use_synth :dark_ambience
    notes = chord(:f3, :m7).shuffle
    v = play notes[0], amp: rrand(0.5, 1), release: 4, attack: 1, sustain: 2, note_slide: 0.5, pan: rrand(-1, 1), pan_slide: 0.5
    sleep [4, 6, 8].choose
    control v, note: notes[1], pan: rrand(-1, 1)
    control flanger, depth: [2, 3].choose, mix: rrand(0, 1)
  end
end