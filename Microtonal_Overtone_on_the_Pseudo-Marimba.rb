##Microtonal Overtone on the Pseudo-Marimba
##by Hirotoshi Uchida
i=0#Default value
n=12#Equal Temperament
t=0#Start from [t].th sound of microtone
p=0#Start from p.th sound of overtone
l=0.25#Seconds
j=12.to_f/n.to_f#Calculate
m=36#Default midi note
s=8#Repeat
k=[m]#New array
n.times do
  i+=j
  k.push(m+i)
end
use_synth :pretty_bell
o=k[t]
puts o
s.times do
  p+=1
  q=midi_to_hz(o)*p#Convert to hz
  r=hz_to_midi(q)#Convert to midi note
  play r,attack:0,decay:0.125,sustain:0.0625,release:0.0625
  sleep l
end