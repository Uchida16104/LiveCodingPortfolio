#It's a program for Sonic PI.
n=60 #The value is note number. Change this to other figure. 
s=0.5 #The value is rest frequency. Change this to other figure.
for i in 0..12 #The values are showing how high the sound gets. For example when you set n=60, and "for i in 0..12", midi note is up by 72 (60+12) one sound at a time.
  play n+i
  sleep s
  k = midi_to_hz(n+i) #It displays hz corresponding to midi. 
  print k
  play k
  sleep s
  t = hz_to_midi(k) #It returns midi corresponding to hz.
  print t
end
