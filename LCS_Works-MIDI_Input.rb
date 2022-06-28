live_loop :midi do
  use_real_time
  use_synth :piano
  note, velocity = sync "/midi:iacdriver_bus1:1/note_on"
  play note, amp: velocity
end
