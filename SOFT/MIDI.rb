live_loop :FoxDot do
  use_real_time
  note, velocity= sync "/midi:iacdriver_bus1:1/note_on"
  use_synth :kalimba
  play note, amp: velocity
end
live_loop :TidalCycles do
  use_real_time
  note, velocity= sync "/midi:iacdriver_bus2:1/note_on"
  use_synth :pluck
  play note, amp: velocity
end
live_loop :Orca do
  use_real_time
  note, velocity= sync "/midi:iacdriver_bus3:1/note_on"
  use_synth :piano
  play note, amp: velocity
end
