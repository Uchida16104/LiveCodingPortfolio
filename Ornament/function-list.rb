#Ornaments
#Inspired by MuseScore
#By Hirotoshi Uchida
#On Apr. 16th. 2023
def arpeggio(note1,note2,note3)
  play note1,sustain:2
  sleep 2/32.to_f
  play note2,sustain:2-0.0625
  sleep 2/32.to_f
  play note3,sustain:2-0.125
  sleep 2-2/16.to_f
end
def glissando(init,vector,times,sleep)
  ary=[]
  if vector=="+" then
    init-=1
    times.times do
      ary.push(init+=1)
    end
  elsif vector=="-" then
    init+=1
    times.times do
      ary.push(init-=1)
    end
  end
  return play_pattern_timed ary,[sleep]
end
def inverted_turn(init)
  play init-1
  sleep 2/32.to_f
  play init
  sleep 2/32.to_f
  play init+2
  sleep 2/32.to_f
  play init,sustain:1-0.0625*3
  sleep 2-2/32.to_f*3
end
def turn(init)
  play init+2
  sleep 2/32.to_f
  play init
  sleep 2/32.to_f
  play init-1
  sleep 2/32.to_f
  play init,sustain:1-1/16.to_f*3
  sleep 2-2/32.to_f*3
end
def trill(init,times)
  (times/2).times do
    play init
    sleep 2/times.to_f
    play init+2
    sleep 2/times.to_f
  end
end
def short_trill(init)
  play init
  sleep 2/32.to_f
  play init+2
  sleep 2/32.to_f
  play init
  sleep 2-2/32.to_f*2
end
def pralltriller(init)
  play init
  sleep 2/32.to_f
  play init-1
  sleep 2/32.to_f
  play init
  sleep 2-2/32.to_f*2
end
def trill_line(init)
  16.times do
    play init
    sleep 2/32.to_f
    play init+2
    sleep 2/32.to_f
  end
end
def upprall_line(init)
  play init-1
  sleep 2/16.to_f
  play init
  sleep 2/16.to_f
  7.times do
    play init+2
    sleep 2/16.to_f
    play init
    sleep 2/16.to_f
  end
end
def downprall_line(init)
  play init+2
  sleep 2/16.to_f*3
  play init
  sleep 2/16.to_f
  6.times do
    play init+2
    sleep 2/16.to_f
    play init
    sleep 2/16.to_f
  end
end
def prallprall_line(init)
  16.times do
    play init
    sleep 2/32.to_f
    play init+2
    sleep 2/32.to_f
  end
end
def turn_with_slash(init)
  play init-1
  sleep 2/32.to_f
  play init
  sleep 2/32.to_f
  play init+2
  sleep 2/32.to_f
  play init
  sleep 2-2/32.to_f*3
end
def tremblement(init)
  play init+2
  sleep 2/32.to_f
  play init
  sleep 2/32.to_f
  play init+2
  sleep 2/32.to_f
  play init
  sleep 2-2/32.to_f*3
end
def prall_mordent(init)
  play init+2
  sleep 2/32.to_f
  play init
  sleep 2/32.to_f
  play init-1
  sleep 2/32.to_f
  play init
  sleep 2-2/32.to_f*3
end
def up_prall(init)
  play init-1
  sleep 2/16.to_f
  play init
  sleep 2/16.to_f
  7.times do
    play init+2
    sleep 2/16.to_f
    play init
    sleep 2/16.to_f
  end
end
def mordent_with_upper_prefix(init)
  play init+2
  sleep 2/16.to_f*3
  play init
  sleep 2/16.to_f
  6.times do
    play init+2
    sleep 2/16.to_f
    play init
    sleep 2/16.to_f
  end
end
def up_mordent(init)
  play init-1
  sleep 2/16.to_f
  play init
  sleep 2/16.to_f
  6.times do
    play init+2
    sleep 2/16.to_f
    play init
    sleep 2/16.to_f
  end
  play init-1
  sleep 2/16.to_f
  play init
  sleep 2/16.to_f
end
def down_mordent(init)
  play init+2
  sleep 2/16.to_f*3
  play init
  sleep 2/16.to_f
  5.times do
    play init+2
    sleep 2/16.to_f
    play init
    sleep 2/16.to_f
  end
  play init-1
  sleep 2/16.to_f
  play init
  sleep 2/16.to_f
end
def prall_down(init)
  6.times do
    play init+2
    sleep 2/16.to_f
    play init
    sleep 2/16.to_f
  end
  play init-1
  sleep 2/16.to_f
  play init
  sleep 2/16.to_f*3
end
def prall_up(init)
  7.times do
    play init+2
    sleep 2/16.to_f
    play init
    sleep 2/16.to_f
  end
  play init-1
  sleep 2/16.to_f
  play init
  sleep 2/16.to_f
end
def line_prall(init)
  play init+4
  sleep 2/16.to_f
  14.times do
    play init+2
    sleep 2/32.to_f
    play init
    sleep 2/32.to_f
  end
end
def slide(init)
  play init
  sleep 2
end
def tremolo(init,times)
  times.times do
    play init
    sleep 2/times.to_f
  end
end
def pitch_bend(init,mid,term,time,rel,slide)
  s=play init,release:rel,note_slide:slide
  sleep time
  control s,note:mid
  sleep time
  control s,note:term
  sleep time
end
def overtone(note,init,term,dist,time)
  ary=[]
  for i in init..term do
    j=midi_to_hz(note)*(i+dist)
    k=hz_to_midi(j)
    ary.push(k)
  end
  play_pattern_timed ary,[time]
end
def tritone(init,time)
  play (ring init,init+6)
  sleep time
end
def longa(init)
  play init,sustain:8
  sleep 8
end
def double_whole_note(init)
  play init,sustain:4
  sleep 4
end
def whole_note(init)
  play init,sustain:2
  sleep 2
end
def half_note(init)
  play init,sustain:1
  sleep 1
end
def quarter_note(init)
  play init,sustain:2/4.to_f
  sleep 2/4.to_f
end
def eighth_note(init)
  play init,sustain:2/8.to_f
  sleep 2/8.to_f
end
def sixteenth_note(init)
  play init,sustain:2/16.to_f
  sleep 2/16.to_f
end
def thirty_second_note(init)
  play init,sustain:2/32.to_f
  sleep 2/32.to_f
end
