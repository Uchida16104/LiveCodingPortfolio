//Wave beam meets shape expansion with moving blocks
//@HirotoshiUchida
speed=0.75
fps=20
frame=300
time=1
smooth=5
linear=2.5
osc(1,2,300).diff(gradient(1).hue(()=>(Math.sin(time)),()=>(Math.cos(time)),()=>(Math.tan(time)))).color([0,0,0,1,1,1,1].smooth(),[0,1,1,0,0,1,1].smooth(),[1,0,1,0,1,0,1].smooth()).scale(0.015625).invert(1).blend(shape([3,7].smooth(),0.1,0.5).contrast(5).scale(1.25).blend(osc(1).diff(gradient(1))).modulate(voronoi(3))).out()
