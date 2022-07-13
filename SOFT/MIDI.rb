n=0.5
live_loop :FoxDot do
  with_fx :ring_mod,freq:62 do
    with_fx :vowel,voice:choose([0,1,2,3,4]),vowel_sound:choose([1,2,3,4,5]) do
      use_real_time
      note, velocity= sync "/midi:iacdriver_bus1:1/note_on"
      use_synth :kalimba
      play note, amp: velocity
    end
  end
end
live_loop :TidalCycles do
  with_fx :octaver,amp:n do
    with_fx :nhpf,amp:n do
      use_real_time
      note, velocity= sync "/midi:iacdriver_bus2:1/note_on"
      use_synth :pluck
      play note, amp: velocity
    end
  end
end
live_loop :Orca do
  with_fx :ixi_techno,amp:n do
    with_fx :nlpf,amp:n do
      use_real_time
      note, velocity= sync "/midi:iacdriver_bus3:1/note_on"
      use_synth :piano
      play note, amp: velocity
    end
  end
end