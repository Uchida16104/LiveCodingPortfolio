p1 = new P5({mode:'WEBGL'})
p2 = new P5({mode:'WEBGL'})
p1.draw = () => {
p1.ellipsoid(p1.mouseX/100,p1.mouseY/100,100)
p2.torus(p2.mouseX/100,p2.mouseY/100,100)
}
p1.clear()
p2.clear()
function differ(){
if (mouseX - mouseY > 0){
mouseX - mouseY
}  else if (mouseX - mouseY < 0){
mouseY - mouseX
}
}
p1.stroke(p1.mouseX, p1.mouseY, p1.differ)
p2.stroke(p2.mouseX, p2.mouseY, p2.differ)
p1.hide()
p2.hide()
s0.init({src: p1.canvas})
s1.init({src: p2.canvas})
s2.initCam()
speed=-0.5
fps=20
frame=1000
time=1
src(s0).diff(src(s1)).scrollX(1,1).rotate(1,1).add(shape([3,7].smooth().fit(),[0.1,0.5].smooth().fit(),[0.5,0.1].smooth().fit()).modulate(voronoi(()=>Math.sin(time)))).repeat([1,3].smooth(),[1,3].smooth()).scale([0.1,1].ease()).mult(gradient(1).diff(osc(10,1)).kaleid([3,7].ease())).diff(solid([0,0,0,1,1,1,1].smooth(),[0,1,1,0,0,1,1].smooth(),[1,0,1,0,1,0,1].smooth())).mask(src(s2).modulate(noise(()=>(a.fft[0]*1+1))).pixelate([100,500].ease(),[100,500].ease()).saturate([0,5].smooth()).blend(o0,[0,1].ease()),[0,1].smooth().fast(0.125)).out()