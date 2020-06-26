speed=0.5
frame=1000
time=1
fps=1000
smooth=20000
s0.initCam()
voronoi([17,18,19,20,21,22,23,24],[1,2,3],[6,7,8,9,10]).mult(shape([3,4,5,6,7,8,9,10,11,12]).brightness(0.999).posterize(2)).mult(osc(1,2,300).modulate(noise(100))).scrollX([-0.1,0.1],[0.1,-0.1]).scrollY([0.1,-0.1],[-0.1,0.1]).rotate(()=>mouse.x+mouse.y).blend(osc(1,2,300).color(0.25,0.25,0.25).diff(gradient(1)).blend(solid([0,0,0],[0,0,1],[0,1,0],[0,1,1],[1,0,0],[1,0,1],[1,1,0],[1,1,1],0.1)).diff(voronoi(0.25)).colorama(1.5,1.5,1.5).luma(0.875).kaleid(()=>(a.fft[0]*10000+1),1).scale()).mult(src(s0).saturate(5).thresh(0.5)).blend(o0).modulate(s0).out()
