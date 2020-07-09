n=60
s=0.5
for i in 0..12
  play n+i
  sleep s
  k = midi_to_hz(n+i)
  print k
  play k
  sleep s
  t = hz_to_midi(k)
  print t
end