p1 >>MidiOut([0,1,1,2,3,5,8,13],amp=0.125,dur=PDur(2,8),channel=0).every(2,"stutter",4,dur=4,oct=(1,2,3,4,5))

p2>>MidiOut([1],channel=0,amp=0.0625)

p2.stop()
