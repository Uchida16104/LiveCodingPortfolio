use_real_time

set :current_note, 60
set :current_bend, 0.0

live_loop :midi_note_on do
  note, vel = sync "/midi:iacdriver_bus2:1/note_on"
  set :current_note, note
end

live_loop :midi_pitch_bend do
  data = sync "/midi:iacdriver_bus2:1/pitch_bend"
  
  bend_val = data[0]
  
  bend = bend_val / 8192.0
  
  set :current_bend, bend
end

live_loop :noise_synth do
  note = get(:current_note)
  bend = get(:current_bend)
  
  target_note = note + (bend * 2)
  
  amp_val = 0.12
  slide_t = 0.02
  
  atk = note/hz_to_midi(440)/2.to_f
  rel = note/hz_to_midi(440)/2.to_f
  
  s1 = synth :bnoise,  note: target_note, amp: amp_val, attack: atk, release: rel, note_slide: slide_t
  s2 = synth :chipnoise, note: target_note, amp: amp_val, attack: atk, release: rel, note_slide: slide_t
  s3 = synth :cnoise, note: target_note, amp: amp_val, attack: atk, release: rel, note_slide: slide_t
  s4 = synth :gnoise, note: target_note, amp: amp_val, attack: atk, release: rel, note_slide: slide_t
  s5 = synth :noise,  note: target_note, amp: amp_val, attack: atk, release: rel, note_slide: slide_t
  s6 = synth :pnoise, note: target_note, amp: amp_val, attack: atk, release: rel, note_slide: slide_t
  
  current = target_note
  current += 0.01
  current -= 0.01
  
  control s1, note: current
  control s2, note: current
  control s3, note: current
  control s4, note: current
  control s5, note: current
  control s6, note: current
  
  sleep 0.01
end