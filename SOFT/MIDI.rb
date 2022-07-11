#FoxDot
live_loop :midi0 do
  use_real_time
  note, velocity= sync "/midi:iacdriver_bus1:1/note_on"
  use_synth :kalimba
  play note, amp: velocity/127
end
#TidalCycles
live_loop :midi1 do
  use_real_time
  note, velocity= sync "/midi:iacdriver_bus2:1/note_on"
  use_synth :pluck
  play note, amp: velocity/127
end
#Orca
live_loop :midi2 do
  use_real_time
  note, velocity= sync "/midi:iacdriver_bus3:1/note_on"
  use_synth :piano
  play note, amp: velocity/127
end
