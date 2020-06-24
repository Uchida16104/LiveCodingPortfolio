a.show()
a.setScale(1)
a.setBins(8)
a.fft[1]
a.fft[2]
a.fft[3]
a.fft[4]
a.setCutoff(1)
a.setSmooth(0.01)
a.settings[0].cutoff = 1
a.settings[1].cutoff = 2
a.settings[2].cutoff = 3
a.settings[3].cutoff = 4
a.settings[4].cutoff = 5
a.settings[5].cutoff = 6
a.settings[6].cutoff = 7
a.settings[7].cutoff = 8
osc(1,20,300).add(osc(0.04,0.5,6)).rotate(()=>(a.fft[1]*0.2+0.03)).scale(()=>(a.fft[2]*3+0.4)).kaleid(()=>(a.fft[3]*0.4+5)).colorama(()=>(a.fft[4]*5+60)).modulate(osc(0.7,8,90)).modulateRotate(osc(0.8,9,100)).modulateScale(osc(0.09,1,1)).modulateKaleid(osc(0.1,0.1,2)).colorama().luma().contrast().blend(o0).out()


a.show()
a.setScale(1)
a.setBins(8)
a.fft[0]
a.fft[1]
a.fft[2]
a.fft[3]
a.fft[4]
a.fft[5]
a.fft[6]
a.setCutoff(1)
a.setSmooth(0.01)
a.settings[0].cutoff = 1
a.settings[1].cutoff = 2
a.settings[2].cutoff = 3
a.settings[3].cutoff = 4
a.settings[4].cutoff = 5
a.settings[5].cutoff = 6
a.settings[6].cutoff = 7
a.settings[7].cutoff = 8
osc(()=>(a.fft[0]*1+2),0.2,30).modulate(osc(1,1,1).color(50,100,200).luma()).rotate().modulateRotate(osc()).scale(()=>(a.fft[1]*2+3)).modulateScale(osc()).kaleid(()=>(a.fft[2]*3+4)).modulateKaleid(osc(()=>(a.fft[3]*4+5))).color(()=>(a.fft[4]*0.005+0.006),()=>(a.fft[5]*0.06+0.07),()=>(a.fft[6]*0.7+0.8)).contrast(7).brightness(-1.5).out()



a.show()
a.setScale(1)
a.setBins(8)
a.fft[0]
a.fft[1]
a.fft[2]
a.fft[3]
a.fft[4]
a.fft[5]
a.fft[6]
a.setCutoff(1)
a.setSmooth(0.01)
a.settings[0].cutoff = 1
a.settings[1].cutoff = 2
a.settings[2].cutoff = 3
a.settings[3].cutoff = 4
a.settings[4].cutoff = 5
a.settings[5].cutoff = 6
a.settings[6].cutoff = 7
a.settings[7].cutoff = 8
s0.initCam()
src(s0).out()
osc(1,2,300).blend(s0).add(noise(()=>(a.fft[0]*1+1))).rotate(()=>(a.fft[1]*2+3)).scale(()=>(a.fft[2]*3+0.4)).out(o0)
render()
osc(10,2,3).luma(()=>(a.fft[5]*6000+0.07)).colorama().contrast(()=>(a.fft[3]*4+5)).modulate(o0).out(o1)
render()
osc(10,1,0.1).kaleid(3600).posterize(()=>(a.fft[4]*0.05+60)).modulate(o0).out(o2)
render()
osc(10,0.1,10).rotate(()=>(a.fft[5]*6+7)).modulateRotate(osc()).scale(()=>(a.fft[6]*0.07+0.8)).modulateScale(osc()).modulate(o0).out(o3)



a.show()
a.setScale(1)
a.setBins(8)
a.fft[1]
a.fft[2]
a.fft[3]
a.fft[4]
a.setCutoff(1)
a.setSmooth(0.01)
a.settings[0].cutoff = 1
a.settings[1].cutoff = 2
a.settings[2].cutoff = 3
a.settings[3].cutoff = 4
a.settings[4].cutoff = 5
a.settings[5].cutoff = 6
a.settings[6].cutoff = 7
a.settings[7].cutoff = 8
noise(1).add(osc()).modulate(osc().color(()=>(a.fft[0]*10+2),()=>(a.fft[1]*20+3),()=>(a.fft[2]*30+4)).luma().colorama()).kaleid().modulateScale(osc(()=>(a.fft[3]*4+5))).modulateRotate(osc(()=>(a.fft[4]*5+6))).out(o0)
render()
gradient(2.5).invert(1).saturate().scrollX().repeatX().scrollY().repeatY().kaleid(()=>(a.fft[3]*4+5)).modulateScale(osc(()=>(a.fft[5]*6+7))).modulateHue(osc(()=>(a.fft[4]*0.5+6))).modulateRotate(osc(()=>(a.fft[6]*7+8))).mask(voronoi(()=>(a.fft[0]*0.1+35),()=>(a.fft[1]*0.00002+1.5),()=>(a.fft[2]*3+4)),1,1,1).colorama().mult(osc([1],[2],[300].fast(0.5))).contrast(30).out(o1)
render()
voronoi().scale(()=>(a.fft[3]*0.04+0.5)).rotate(()=>(a.fft[2]*0.03+0.04)).mask(osc(1,2,300).add(noise(1))).add(shape(100).scale(()=>(a.fft[1]*0.2+0.3))).add(gradient(1)).add(shape(4).scale().scale().scale().colorama().mask(osc(100,2,30).add(noise(10)).kaleid().modulateScale(osc()).modulateRotate(osc()))).out(o2)
render()
osc(1,2,300).add(noise(1)).shift(()=>(a.fft[1]*0.2+0.3),()=>(a.fft[2]*0.3+0.4),()=>(a.fft[3]*0.4+0.5),()=>(a.fft[4]*0.5+0.6)).kaleid(()=>(a.fft[5]*0.6+0.7)).scrollX().scrollY().modulatePixelate(osc(a.fft[6]*7+80)).out(o3)



a.show()
a.setScale(1)
a.setBins(8)
a.fft[1]
a.fft[2]
a.fft[3]
a.fft[4]
a.fft[5]
a.fft[6]
a.setCutoff(1)
a.setSmooth(0.01)
a.settings[0].cutoff = 1
a.settings[1].cutoff = 2
a.settings[2].cutoff = 3
a.settings[3].cutoff = 4
a.settings[4].cutoff = 5
a.settings[5].cutoff = 6
a.settings[6].cutoff = 7
a.settings[7].cutoff = 8
gradient(2.5).invert(1).saturate().scrollX().repeatX().scrollY().repeatY().kaleid(()=>(a.fft[3]*4+5)).modulateScale(osc(()=>(a.fft[5]*6+7))).modulateHue(osc(()=>(a.fft[4]*0.5+6))).modulateRotate(osc(()=>(a.fft[6]*7+8))).mask(voronoi(()=>(a.fft[0]*0.1+35),()=>(a.fft[1]*0.00002+1.5),()=>(a.fft[2]*3+4)),1,1,1).colorama().mult(osc([1],[2],[300].fast(0.5))).contrast(30).out(o0)

a.show()
a.setScale(1)
a.setBins(8)
a.fft[1]
a.fft[2]
a.fft[3]
a.fft[4]
a.fft[5]
a.fft[6]
a.setCutoff(1)
a.setSmooth(0.01)
voronoi().scale(()=>(a.fft[3]*0.04+0.5)).rotate(()=>(a.fft[2]*0.03+0.04)).mask(osc(1,2,300).add(noise(1))).add(shape(100).scale(()=>(a.fft[1]*0.2+0.3))).add(gradient(1)).add(shape(4).scale().scale().scale().colorama().mask(osc(100,2,30).add(noise(10)).kaleid().modulateScale(osc()).modulateRotate(osc()))).out()

a.show()
a.setScale(1)
a.setBins(8)
a.fft[1]
a.fft[2]
a.fft[3]
a.fft[4]
a.fft[5]
a.fft[6]
a.setCutoff(1)
a.setSmooth(0.01)
osc(1,2,300).add(noise(1)).shift(()=>(a.fft[1]*0.2+0.3),()=>(a.fft[2]*0.3+0.4),()=>(a.fft[3]*0.4+0.5),()=>(a.fft[4]*0.5+0.6)).kaleid(()=>(a.fft[5]*0.6+0.7)).scrollX().scrollY().modulatePixelate(osc(a.fft[6]*7+80)).out()

//Production
a.show()
a.setScale(1)
a.setBins(8)
a.fft[1]
a.fft[2]
a.fft[3]
a.fft[4]
a.setCutoff(1)
a.setSmooth(0.01)
a.settings[0].cutoff = 1
a.settings[1].cutoff = 2
a.settings[2].cutoff = 3
a.settings[3].cutoff = 4
a.settings[4].cutoff = 5
a.settings[5].cutoff = 6
a.settings[6].cutoff = 7
a.settings[7].cutoff = 8
noise(1).add(osc()).modulate(osc().color(()=>(a.fft[0]*10+2),()=>(a.fft[1]*20+3),()=>(a.fft[2]*30+4)).luma().colorama()).kaleid().modulateScale(osc(()=>(a.fft[3]*4+5))).modulateRotate(osc(()=>(a.fft[4]*5+6))).out(o1)
render()
gradient(2.5).invert(1).saturate().scrollX().repeatX().scrollY().repeatY().kaleid(()=>(a.fft[3]*4+5)).modulateScale(osc(()=>(a.fft[5]*6+7))).modulateHue(osc(()=>(a.fft[4]*0.5+6))).modulateRotate(osc(()=>(a.fft[6]*7+8))).mask(voronoi(()=>(a.fft[0]*0.1+35),()=>(a.fft[1]*0.00002+1.5),()=>(a.fft[2]*3+4)),1,1,1).colorama().mult(osc([1],[2],[300].fast(0.5))).contrast(30).out(o3)
render()
voronoi().scale(()=>(a.fft[3]*0.04+0.5)).rotate(()=>(a.fft[2]*0.03+0.04)).mask(osc(1,2,300).add(noise(1))).add(shape(100).scale(()=>(a.fft[1]*0.2+0.3))).add(gradient(1)).add(shape(4).scale().scale().scale().colorama().mask(osc(100,2,30).add(noise(10)).kaleid().modulateScale(osc()).modulateRotate(osc()))).out(o2)
render()
osc(1,2,300).add(noise(1)).shift(()=>(a.fft[1]*0.2+0.3),()=>(a.fft[2]*0.3+0.4),()=>(a.fft[3]*0.4+0.5),()=>(a.fft[4]*0.5+0.6)).kaleid(()=>(a.fft[5]*0.6+0.7)).scrollX().scrollY().modulatePixelate(osc(a.fft[6]*7+80)).out(o0)

voronoi().layer(osc()).add(gradient()).add(osc(1,2,300)).add(noise(1)).mult(osc()).diff(osc().modulateRotate(osc()).modulate(osc().invert(1).saturate().luma().colorama()).modulateScale(osc()).kaleid().modulateHue(osc())).mask(shape(4).rotate(()=>(a.fft[1]*2+3)).scale(()=>(a.fft[2]*1+0.4)).add(solid([0.1,0.02,0.3],[0.04,0.05,0.06]))).scale(()=>(a.fft[0]*1+2)).repeat().scrollX().scrollY().out()

gradient(1).add(osc(1,2,300).color(0,0,0)).modulate(shape(1).add(osc()).add(noise(1)).brightness(-20).colorama()).modulateKaleid(voronoi()).mask(osc(1,2,300).color(0,0,0).brightness(0.5).colorama().add(shape(2.5)).rotate().modulate(osc().kaleid()).modulateScale(osc(()=>(a.fft[0]*1+2))).modulateHue(osc())).out()

osc(1,2,300).add(noise(1)).luma().thresh(2,2).mult(osc()).colorama(10).add(voronoi(5)).add(gradient(1)).shift().saturate(3).add(osc(0,0,0).color(0,0,0)).kaleid().scale().out()

gradient(1).add(osc(1,2,300).colorama().shift().saturate()).add(noise(1).luma()).modulateRotate(voronoi().mask(osc(1,2,300).kaleid())).modulateScale(shape(360).scale().mask(osc(100,2,30).add(noise(10000)).kaleid().modulateKaleid(osc(1,2,3)).contrast(-1))).contrast(-1).out()

gradient(1).add(osc(1,2,300,voronoi())).add(noise(1).colorama().luma()).saturate().invert().shift().modulateKaleid(solid([1,0,0],[0,1,0],[0,0,1],[1,1,0],[1,0,1],[0,1,1],[1,1,1],[0,0,0],0.25).add(shape(360).scale())).rotate(()=>(a.fft[0]*0.5+0.05)).scale(()=>(a.fft[1]*0.5+0.5)).hue().out()

voronoi(5,(()=>(a.fft[0]*0.00025+1.5)),25,10,fps=5,speed=1,time=(()=>(Math.PI())),frame=0.5).add(osc(1,2,300)).out()

solid().add(o1,[1,0,0]).add(o2,[0,1,0]).add(o3,[0,0,1]).out()
osc(1,2,300,speed=1,frame=2,fps=200,time=2).add(gradient(1)).add(noise(1)).add(voronoi()).modulateKaleid(shape(360).scale(()=>(a.fft[0]*1+1)).luma()).hue().out(o1)
osc([1,2,3].fast(2)).luma().add(solid([0,0,0],[0,0,1],[0,1,0],[0,1,1],[1,0,0],[1,0,1],[1,1,0],[1,1,1],1)).modulatePixelate(noise(()=>(a.fft[0]*1+1))).hue().out(o2)
osc(1,2,300).add(noise(1).colorama()).add(gradient(1)).modulate(shape(()=>(a.fft[0]*1+3))).scale().luma().hue().out(o3)

s0.initCam()
src(s0).pixelate(75,75).mask(gradient(1).add(osc(1,2,300)).add(noise(1)).add(voronoi()).add(shape(360).scale().scale().kaleid())).diff(voronoi()).diff(voronoi()).diff(gradient(1).add(osc(1,2,300).add(noise(1).add(voronoi())))).hue().out(o0)

osc(1,2,300,fps=1000,speed=2,frame=100,time=(()=>(Math.PI()))).add(gradient(1)).add(noise(1)).add(voronoi()).add(solid([0,0,0],[0,0,1],[0,1,0],[0,1,1],[1,0,0],[1,0,1],[1,1,0],[1,1,1],0.1)).colorama().luma().modulatePixelate(noise(1)).modulateHue(osc(1,2,300)).modulateKaleid(gradient(1)).out()

voronoi().add(osc(1,2,300)).modulate(noise(1)).mult(gradient()).modulate(osc(1,2,300).add(noise(1)).thresh().colorama().kaleid(()=>(a.fft[1]*20+1)).scale(()=>(a.fft[0]*20+1)).hue()).out()

shape(360).blend(shape(3)).mask(shape(4)).layer(osc(1,2,300)).diff(gradient().luma()).mult(voronoi().invert()).modulateKaleid(noise(1).colorama()).modulatePixelate(solid([0,0,0],[0,0,1],[0,1,0],[0,1,1],[1,0,0],[1,0,1],[1,1,0],[1,1,1],0.1),750,750).hue().out()

osc(1,2,300).modulateKaleid(shape(360)).modulateRotate(voronoi(1)).modulateScale(noise(1)).colorama().luma().modulatePixelate(gradient(1),750,750).modulateHue(solid([0,0,0],[0,0,1],[0,1,0],[0,1,1],[1,0,0],[1,0,1],[1,1,0],[1,1,1],0.1)).out()

s0.initCam()
osc(1,2,300).diff(voronoi().shift()).diff(gradient(1).luma()).diff(noise(1).colorama()).diff(solid([0,0,0],[0,0,1],[0,1,0],[0,1,1],[1,0,0],[1,0,1],[1,1,0],[1,1,1],0.1).invert()).modulatePixelate(shape(3),750,750).modulateKaleid(shape(4).scale(()=>(a.fft[0]*(()=>(Math.PI))+1))).rotate(()=>mouse.x).mask(src(s0).colorama(0.05).luma(0.25).saturate(0.01).thresh(0.05)).hue().out(o0)

s0.initScreen()
osc(1,2,300).mult(noise(1)).diff(src(s0)).scale(1.5).modulatePixelate(solid([0,0,0],[0,0,1],[0,1,0],[0,1,1],[1,0,0],[1,0,1],[1,1,0],[1,1,1],0.1),10000,10000).modulate(voronoi()).scale(1.175).modulateRotate(shape(3).colorama().shift()).rotate().modulateScale(shape(4).modulateKaleid(noise(0.00001,0.1).invert(),3).luma().invert()).modulateHue(osc(100,200,300).add(gradient())).scale(1.5).hue().out(o0)

s0.initCam()
src(s0).add(gradient(1).invert()).brightness(-0.5).saturate(1.25).posterize(2).diff(voronoi(20,1,()=>Math.PI).luma()).mult(noise(1.125).colorama(2).luma(0.001).thresh(0.225).hue()).out()

voronoi([6,7,8,9,10],[1,2,3,4,5],[1]).blend(shape([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50],[1],[5],speed=50,fps=10000,time=1,frame=500000).modulateRotate(noise(1))).colorama().luma().scale(0.1).out()

voronoi(1.25,80,1).blend(voronoi(2.5,20,2)).blend(voronoi(5,100/15,3)).blend(voronoi(10,2.5,4)).blend(voronoi(20,1,5)).mult(osc(1,2,75)).mult(osc(1,2,150)).mult(osc(1,2,300)).blend(gradient(1)).blend(gradient(2)).blend(gradient(4)).blend(gradient(8)).modulate(noise(1)).modulate(noise(2)).modulate(noise(4)).modulate(noise(8)).colorama().luma().scale().out()

shape([360]).modulateKaleid(voronoi(25,25),[1,1.1,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,2,2.1,2.2,2.3,2.4,2.5,2.6,2.7,2.8,2.9,3,3.1,3.2,3.3,3.4,3.5,3.6,3.7,3.8,3.9,4,4.1,4.2,4.3,4.4,4.5,4.6,4.7,4.8,4.9,5],speed=100,fps=10000,frame=50000,time=1,smooth=2000).blend(noise(2,0.005)).diff(gradient(0.01,2)).diff(osc(0.1,0.125,75)).out()

speed=1
frame=500
time=2
fps=1000
smooth=10000
s0.initCam()
osc(1,2,300).layer(src(s0)).diff(gradient(1)).diff(noise(1)).diff(voronoi(1)).diff(voronoi(2)).diff(voronoi(3)).diff(voronoi(4)).diff(voronoi(5)).diff(voronoi(6)).diff(voronoi(7)).diff(voronoi(8)).diff(voronoi(9)).diff(voronoi(10)).blend(solid([0,0,0],[0,0,1],[0,1,0],[0,1,1],[1,0,0],[1,0,1],[1,1,0],[1,1,1],0.1)).colorama().luma(0.01).mult(shape(3).modulate(voronoi(1))).mult(shape(4).modulate(voronoi(2))).mult(shape(5).modulate(voronoi(3))).mult(shape(6).modulate(voronoi(4))).mult(shape(7).modulate(voronoi(5))).mult(shape(8).modulate(voronoi(6))).mult(shape(9).modulate(voronoi(7))).mult(shape(10).modulate(voronoi(8))).scrollX(1.5,1.5).scrollY(1.5,1.5).repeatX(2,2).repeatY(2,2).mult(src(s0)).out()

osc(10,1,5000).diff(noise(1)).diff(gradient(1).colorama().luma()).diff(shape([3,4,5,6,7,8,9,10])).diff(voronoi([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20],[1,2,3,4,5,6,7,8,9,10],[1,2,3,4,5])).scrollX().scrollY().kaleid().out()

speed=0.5
frame=1000
time=1
fps=1000
smooth=20000
s0.initCam()
voronoi([17,18,19,20,21,22,23,24],[1,2,3],[6,7,8,9,10]).mult(shape([3,4,5,6,7,8,9,10,11,12]).brightness(0.999).posterize(2)).mult(osc(1,2,300).modulate(noise(100))).scrollX([-0.1,0.1],[0.1,-0.1]).scrollY([0.1,-0.1],[-0.1,0.1]).rotate(()=>mouse.x+mouse.y).blend(osc(1,2,300).color(0.25,0.25,0.25).diff(gradient(1)).blend(solid([0,0,0],[0,0,1],[0,1,0],[0,1,1],[1,0,0],[1,0,1],[1,1,0],[1,1,1],0.1)).diff(voronoi(0.25)).colorama(1.5,1.5,1.5).luma(0.875).kaleid(()=>(a.fft[0]*10000+1),1).scale()).mult(src(s0).saturate(5).thresh(0.5)).out()

//Under the sea
osc(2,1,300).diff(gradient(1).blend(solid([0,1,0],[0,1,1],[1,0,0],[1,0,1],[1,1,0],[1,1,1],0.1)).diff(noise(1))).mult(shape([3,4,5,6,7,8,9,10,11,12],[0.7],[0.4,0.5,0.6,0.7,0.8])).mult(voronoi(100,1,1)).modulateRotate(o0).modulateScale(o0).blend(o0).scale(()=>(a.fft[0]*0.5+1)).out()

//Carpet
shape(1).blend(osc(2,1,300)).diff(gradient(1)).mult(shape([4],[0.1,0.2,0.3,0.4,0.5],[0.5,0.6,0.7])).modulatePixelate(solid([0,1,0],[0,1,1],[1,0,0],[1,0,1],[1,1,0],[1,1,1],0.1),50,50).modulateScale(voronoi(0.5,1,5)).modulateRotate(noise(1)).out()

//Flower
shape([3,4,5,6,7,8,9,10,11,12]).diff(voronoi([1,2,3,4,5])).diff(gradient()).diff(osc(1,2,300)).modulateKaleid(o0).modulateRotate(o0).blend(o0).blend(o0).blend(o0).blend(o0).blend(o0).out()

//Donut
osc(10,time=0.1).kaleid(100,speed=-3).blend(gradient(1),2.5,fps=10000).modulate(o0,frame=0.01).out()

osc([1,2,4],[1,2],[300,150,75]).color([1,0,0,1,0,1,1,1,0,1,1,1,0,0,0,0,0,1,0,1,0,0,1,1],[0,1,0,0,1,1,1,0,0,1,0,1,1,1,0,1,1,1,0,0,0,0,0,1],[0,0,1,0,1,0,0,1,1,1,0,0,1,0,1,1,1,0,1,1,1,0,0,0]).diff(gradient(1)).diff(solid([0,1,0],[0,1,1],[1,0,0],[1,0,1],[1,1,0],[1,1,1],0.1)).mult(noise(1)).add(shape(360)).modulate(voronoi(1)).modulateScale(o0).modulateRotate(o0).modulateKaleid(o0).modulateHue(o0).shift([0,0,0],[0,0,1],[0,1,0],[0,1,1],[1,0,0],[1,0,1],[1,1,0],[1,1,1]).invert().out()

osc(0.25,0.125,300).diff(gradient(1)).diff(noise([1,2])).diff(shape([3,4,5,6,7,8,9,10,11,12])).diff(solid([0,1,0],[0,1,1],[1,0,0],[1,0,1],[1,1,0],[1,1,1],0.1)).repeatX().repeatY().scrollX().scrollY().modulatePixelate(voronoi(1),0.5,0.5).kaleid([1,2,3,4,5,6,7,8,9,10,11,12]).modulateRotate(o0,20).out()

osc(2,1,300,speed=0.5).diff(gradient(1,fast=0.0625)).modulate(voronoi(10,1,0.1,fps=10)).modulateScale(shape([3,4,5,6,7,8,9,10,11,12],time=5)).modulateHue(solid([0,1,0],[0,1,1],[1,0,0],[1,0,1],[1,1,0],[1,1,1],0.1)).modulateKaleid(noise(1,frame=0.01)).modulateRotate(o0,1).color([0,0,1,0,1,1,1],[0,1,0,1,0,1,1],[1,0,0,1,1,0,1].smooth=200).colorama().out()

noise(2,smooth=0.1).colorama().diff(osc(2,1,300,speed=0.5)).diff(gradient(1,fps=10)).color([0,0,1,0,1,1,1],[0,1,0,1,0,1,1],[1,0,0,1,1,0,1]).diff(solid([0,1,0],[0,1,1],[1,0,0],[1,0,1],[1,1,0],[1,1,1],0.1).colorama(10).luma(()=>Math.PI())).modulateKaleid(shape([3,4,5,6,7,8,9,10,11,12],time=20)).modulatePixelate(voronoi(5,frame=100),562.5,562.5).modulateRotate(o0,3).out()

shape([3,4,5,6,7,8,9,10,11,12],[0.1,0.2],[0.35,0.45,0.55],smooth=0.375).modulate(noise(1)).modulate(voronoi(3)).mult(gradient(1)).diff(osc(1,2,300)).repeat(1).scrollX(2).scrollY(2).modulateRotate(o1,0.05).colorama(10).luma(0.1).scale([0.5,0.75,1,1.25,1.5],[0.5,0.625,0.75,0.875,1,1.125,1.25,1.375,1.5]).repeatX([1,2,3,4],[5,6,7]).repeatY([1,2,3],[4,5,6,7]).modulate(o1,0.000001).modulateScrollY(o2,100).rotate([1,2],[3,4,5]).mask(osc(1,2,300).brightness(0.75).contrast(3)).blend(voronoi(5,1,1).brightness(0.0625)).diff(gradient(1)).out(o0)
osc(100,20,3,speed=0.25).color([1,0,0,1,1,0,1],[0,1,0,1,0,1,0],[0,0,1,0,1,1,1]).modulateKaleid(o2,0.05).modulateScrollX(o3,100).mask(noise(1).add(voronoi(1).brightness(0.5).contrast(5)).contrast(2)).out(o1)
voronoi([1,2,34,8,16],[1,2],[1,2,3,4],fps=10).diff(solid([0,1,0],[0,1,1],[1,0,0],[1,0,1],[1,1,0],[1,1,1],0.1)).modulatePixelate(o3,1000000,10000000).mask(osc(1,2,300,fast=2).layer(shape([1,2,3,4,5,6,7,8,9,10])).brightness(0.25).contrast(7)).posterize(10).out(o2)
noise(1,frame=0.1).modulateScale(o0,0.000001).mask(osc(1,1,1,time=0.25).thresh(0.01).mult(solid([0,1,0],[0,1,1],[1,0,0],[1,0,1],[1,1,0],[1,1,1],0.1)).brightness(0.75).contrast(2).saturate(5)).out(o3)

shape([3,4,5,6,7,8,9,10,11,12],0.1,0.5).colorama(5).luma(0.3).mult(osc(6,3,300).diff(gradient(10))).modulate(voronoi(1)).modulate(voronoi(2)).modulate(voronoi(3)).modulate(voronoi(4)).blend(o0).modulate(o0).repeat(1,1).rotate(0.5,0.5).scroll(1,1).rotate(-0.25,-0.25).scale(0.5).out()

osc(2.5,1.25,300).diff(gradient(5)).diff(noise(1.5)).blend(o0).modulatePixelate(voronoi(10),50,50).modulateRotate(o0,2.5).colorama(0.025).luma(0.01).saturate(1.5).posterize(3).out()

osc(6,3,300).diff(gradient(2.5)).mult(shape([2,3,4,5,6],0.1,0.5)).modulatePixelate(noise(1.5)).modulateRotate(voronoi(5,2,2.5)).colorama(5).luma(0.0001).blend(o0).modulate(o0).shift([1,2,3,4,5,6,7],[2,3,4],[5,6,7,8,9,10,11,12,13,14,15]).saturate(3).brightness(0.0625).posterize(10).out()

osc(10,1,speed=0.75).thresh(0.01).colorama(0.000001).kaleid([3,4,5,6,7,8,9,10,11,12]).modulate(voronoi(10),time=0.1).color([0,0,0,1,1,1,1],[0,1,1,0,0,1,1],[1,0,1,0,1,0,1],smooth=1).mult(osc(6,3,300).diff(gradient(2,frame=1))).modulate(shape([1,2],0.1,0.5,fast=2).contrast(0.5).posterize(1).brightness(0.01).saturate(5).shift(2),fps=10).rotate([-1,-1,1,1],[-1,1,-1,1]).scale(0.75,0.75).out()

osc(10,0.5,3000000).diff(gradient(0.01)).color([0,0,0,1,1,1,1],[0,1,1,0,0,1,1],[1,0,1,0,1,0,1],smooth=10000).colorama(0.000000625).luma(0.0001).blend(o0).modulate(o0).modulate(shape([1,1.1,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,2],0.5,0.1)).kaleid([3,4,5,6,7,8,9,10,11,12].fast=0.5).modulate(voronoi(3)).modulate(noise(2)).repeatX([-1,-1,1,1],[-1,1,-1,1]).repeatY([1,-1,1,-1],[1,1,-1,-1]).scrollX([-1,-1,1,1],[-1,1,-1,1]).scrollY(1,1).rotate(0.015625,0.015625).out()

osc(5,1).blend(noise(1)).diff(gradient(1)).kaleid([3,4,5,6,7,8,9,10,11,12]).blend(o0,0.025).modulateScale(shape([3,4,5,6,7,8,9,10,11,12],0.1,0.5)).modulateRotate(voronoi(2,2.5,5)).colorama(2).luma(0.05).shift(1).thresh(0.125).saturate(5).brightness(-1).posterize(3).color([1,0,0,1,1,0,1],[0,1,0,1,0,1,0],[0,0,1,0,1,1,1]).mult(osc(3,1.125,300).diff(gradient(1))).out()

voronoi(20,1.5,5).mult(osc(1,2,300).diff(gradient(3))).modulatePixelate(shape([3,4,5,6,7,8,9,10,11,12],0.1,0.5,speed=2).contrast(1.5).brightness(0.3)).out()

osc(10,1).diff(gradient(1)).kaleid([3,4,5,6,7,8,9,10,11,12]).mult(shape([3,4,5,6,7,8,9,10,11,12],0.1,0.5)).modulate(voronoi(3,1,2)).repeat().modulateScrollX(osc(1),10).modulateScrollY(osc(1),10).modulateKaleid(osc(1),5).modulateRotate(osc(1),5).out()

//Slow motion
shape([1,2],0.1,0.5).modulate(voronoi(20,5,fps=7.5)).modulateKaleid(noise(5),[3,4,5,6,7,8,9,10,11,12],speed=0.5).modulateRotate(osc(10,0.1,100,fast=0.1)).colorama(2).luma(0.01).color([0,0,0,1,1,1,1],[0,1,1,0,0,1,1],[1,0,1,0,1,0,1],smooth=50).diff(solid([0,1,0],[0,1,1],[1,0,0],[1,0,1],[1,1,0],[1,1,1],frame=10).blend(osc(1,2,300)).mult(gradient(1,time=2.5))).out(o0)

osc(10,1).colorama(10).luma(0.1).diff(solid([0,1,0],[0,1,1],[1,0,0],[1,0,1],[1,1,0],[1,1,1],0.1)).diff(gradient(1)).color([0,0,0,1,1,1,1],[0,1,1,0,0,1,1],[1,0,1,0,1,0,1]).modulateRotate(osc(10,1)).diff(gradient(2)).modulateScale(osc(1,10)).diff(gradient(3)).kaleid([3,4,5,6,7,8,9,10,11,12]).diff(gradient(4)).modulate(shape([1,2],0.1,0.5).diff(gradient(5)).modulate(voronoi(15,1,2))).diff(gradient(6)).out(o0)