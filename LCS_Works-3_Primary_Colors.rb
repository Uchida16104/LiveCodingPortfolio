use_synth :piano
in_thread do
  23.times do
    play hz_to_midi(440/3*1).to_f
    sleep 13/2.to_f
  end
end
in_thread do
  23.times do
    play hz_to_midi(440/3*2).to_f
    sleep 13/3.to_f
  end
end
in_thread do
  23.times do
    play hz_to_midi(440/3*3).to_f
    sleep 13/5.to_f
  end
end
in_thread do
  23.times do
    play hz_to_midi(440/3*4).to_f
    sleep 13/7.to_f
  end
end
in_thread do
  23.times do
    play hz_to_midi(440/3*5).to_f
    sleep 13/11.to_f
  end
end
in_thread do
  23.times do
    play hz_to_midi(440/3*6).to_f
    sleep 13/13.to_f
  end
end
