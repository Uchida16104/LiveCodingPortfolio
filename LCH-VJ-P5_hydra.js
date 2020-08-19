speed=0.5
frame=1000
time=1
fps=20
linear=1
p1 = new P5()
let c = p1.color(p1.frameCount*256,p1.frameCount*256,p1.frameCount*256);
p1.fill(c);
p1.noStroke();
p1.textFont();
p1.textSize(width / 5);
p1.textAlign(p1.CENTER, p1.CENTER);
p1.text('hydra',500,500)
//p1.clear()
p1.stroke(p1.frameCount*256,p1.frameCount*256,p1.frameCount*256)
p1.hide()
s0.init({src: p1.canvas})
src(s0).diff(shape([3,7].smooth()).scale(2)).mult(osc(10,1).diff(gradient(1)).diff(solid([0,0,0,0,1,1,1,1].smooth(),[0,0,1,1,0,0,1,1].smooth(),[0,1,0,1,0,1,0,1].smooth())).mask(osc([2,6].ease(),[1,3].ease(),300).diff(gradient([1,10].ease()).color([0,0,0,1,1,1,1].fit().smooth(),[0,1,1,0,0,1,1].fit().smooth(),[1,0,1,0,1,0,1].fit().smooth()))),[0,1].ease().fast(0.125)).modulate(voronoi(3,2)).repeat().modulateScale(osc(5)).pixelate([250,1250].smooth(),[250,1250].smooth()).contrast([0,2].ease()).out(o0)
render()
src(s0).modulate(voronoi(3)).blend(shape([2].smooth().offset(),[0.1,0.5].smooth().offset(),[0.5,0.1].smooth().offset()).mult(osc(10,1).diff(gradient(15))).contrast(5)).scale(()=>(Math.sin(time)*1.5)).repeat(2,2).out(o1)
render()
src(s0).diff(shape([3,7].smooth()).scale(2)).mult(osc(10,1).diff(gradient(1)).diff(solid([0,0,0,0,1,1,1,1].smooth(),[0,0,1,1,0,0,1,1].smooth(),[0,1,0,1,0,1,0,1].smooth())).mask(osc([2,6].ease(),[1,3].ease(),300).diff(gradient([1,10].ease()).color([0,0,0,1,1,1,1].fit().smooth(),[0,1,1,0,0,1,1].fit().smooth(),[1,0,1,0,1,0,1].fit().smooth()))),[0,1].ease().fast(0.125)).modulate(voronoi(3,2)).repeat().modulateScale(osc(5)).pixelate([250,1250].smooth(),[250,1250].smooth()).contrast([0,2].ease()).out(o2)
render()
src(s0).modulate(voronoi(3)).blend(shape([2].smooth().offset(),[0.1,0.5].smooth().offset(),[0.5,0.1].smooth().offset()).mult(osc(10,1).diff(gradient(15))).contrast(5)).scale(()=>(Math.sin(time)*1.5)).repeat(2,2).out(o3)
render()