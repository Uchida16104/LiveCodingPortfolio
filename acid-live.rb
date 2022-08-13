#Please try to paste "default:" values into "ampN (N is a number):" in order of "order:" values and run it.
#Each of their parts should be run every about 28 sec.
#use_bpm 66
amp0=[0.5,1].tick#bass0,default:[0.5,1].tick,order:0
amp1=[2,3].reverse.tick#bass1,default:[2,3].reverse.tick,order:0
amp2=2.5#bass2,default:2.5,order:0
amp3=1.5#bass3,default:1.5,order:0
amp4=3#bd,default:3,order:1
amp5=0.75#hh,default:0.75,order:1
amp6=[0.5,1,1.5,2].reverse.tick#synth,default:[0.5,1,1.5,2].reverse.tick,order:2
amp7=[0.5,1,1.5,2].tick#synth,default:[0.5,1,1.5,2].tick,order:2
amp8=1#cineboom,default:1,order:3
amp9=3#ambient,default:3,order:4
amp10=1.5#blip,default:1.5,order:4
live_loop :bass0 do
  with_fx :reverb,amp:1.5,room:0.99 do
    with_fx :flanger,amp:0.75,phase:0.25 do
      use_synth :bass_highend
      play ring(36,48),amp:amp0,sustain:7.5
      sleep 8
    end
  end
end
live_loop :bass1 do
  with_fx :reverb,amp:1.5,room:1 do
    2.times do
      sample :bass_voxy_c,amp:amp1
      sleep 8
    end
    sleep 16
  end
end
live_loop :bass2 do
  with_fx :reverb,amp:1.5,room:1 do
    sample :bass_hard_c,amp:amp2
    sleep 8
  end
end
live_loop :bass3 do
  with_fx :reverb,amp:2,room:1 do
    sample :bass_trance_c,amp:amp3
    sleep 32
  end
end
live_loop :bd do
  with_fx :reverb,amp:1.5,room:1 do
    sample :bd_haus,amp:amp4
    sleep 0.5
  end
end
live_loop :hh do
  with_fx :reverb,amp:1.5,room:1 do
    with_fx :distortion,distort:0.75 do
      sample :drum_cymbal_closed,amp:amp5
      sleep 0.125
    end
  end
end
live_loop :synth do
  h=0.125
  n=[3,4].reverse.tick
  m=60-n
  if m==72 then
    m=60-n
    m+=n
  else
    m+=n
  end
  4.times do
    ary=[0.25,0.5,0.75,1]
    k=rand(0..3).round
    l=rand(0..3).round
    method=ary[k..l]
    with_fx :reverb,amp:1.5,room:1 do
      with_fx :echo,amp:[0.25,0.5,1,2,4].shuffle.tick,phase:method.choose do
        with_fx :lpf,cutoff:rdist(30,90) do
          use_synth :tech_saws
          4.times do
            i=m
            j=n*2
            i-=j
            array=[]
            4.times do
              i+=j
              array.push(i)
              play array,amp:amp6,attack:h/4,decay:h/4,sustain:h/4,release:h/4
              sleep h
            end
            i=m
            j=n*3
            i-=j
            array=[]
            4.times do
              i+=j
              array.push(i)
              play array,amp:amp7,attack:h/4,decay:h/4,sustain:h/4,release:h/4
              sleep h
            end
          end
        end
      end
    end
  end
end
live_loop :cineboom do
  with_fx :distortion,amp:3,distort:0.5 do
    sleep [0,4].tick
    sample :misc_cineboom,amp:amp8
    sleep [16,12].tick
  end
end
live_loop :ambient do
  with_fx :reverb,amp:3,room:1 do
    sample :ambi_lunar_land,amp:amp9
    sleep 8
  end
end
live_loop :blip do
  with_fx :gverb,amp:2,room:20 do
    sleep 1.75
    sample :elec_blip,amp:amp10
    sleep 6.25
  end
end