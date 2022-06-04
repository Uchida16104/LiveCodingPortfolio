let n=50;
p5=new P5({mode : 'WEBGL'})
p5.hide()
s0.init({src:p5.canvas})
s1.initCam()
p5.draw=()=>{
p5.background(0);
p5.stroke(p5.hour(),p5.minute(),p5.second(),p5.millis());
p5.shearX(time/20);
p5.shearY(time/30);
p5.rotateX(time);
p5.rotateY(time);
p5.rotateZ(time);
p5.translate(p5.width / 10, p5.height / 10);
p5.scale(p5.width/3600);
p5.torus(300,100);
}
synth=()=>src(s1).modulate(src(s0).thresh())
const array = [];
let j = 10;
let o=Math.PI;
let m=Math.E;
let cos = ()=>Math.cos(time);
let tan = ()=>Math.tan(time);
let csc = ()=>Math.csc(time);
let sec = ()=>Math.sec(time);
let cot = ()=>Math.cot(time);
for (let i=0; i<j; i++) {
array.push(i);
const reducer = (quotient,currentValue) => currentValue / j;
const increaser = (quotient,currentValue)=> currentValue / j * 5;
k=array.map(reducer);
r=array.map(increaser);
}
const shuffle = (array) => {
  for (let p = array.length - 1; p >= 0; p--) {
    const q = Math.floor(Math.random() * (p + 1));
    [array[p], array[q]] = [array[q], array[p]];
  }
  return array;
}
function ratio(l=0,h=1) {
return ()=>Math.sin(time^2*h)+Math.cos(time)+2*h^(-l);
}
function shake(s=0,b=1) {
return ()=>Math.csc(time^2*b)-Math.sec(time)-2*(-b)^s;
}
glitch=()=>src(o1).modulate(gradient(1).colorama(shuffle(array).smooth()).shift(shuffle(array).smooth().fast(1/m))).mult(shape(4,1).repeat(n,n)).diff(src(o1).pixelate(n,n)).diff(src(o1).scale(.99).diff(src(o1).scale(1.01))).luma(1)
pop=()=>solid().modulate(gradient(1).colorama(shuffle(k).smooth()).shift(shuffle(k).smooth().fast(1/m))).mult(shape(4,1).repeat(n,n)).diff(src(o1).pixelate(n,n)).diff(src(o1).scale(.99).diff(src(o1).scale(1.01)))
solid().add(shape(2,.1).mult(src(o1).scrollY(-.1)).scroll(shuffle(k).fit(1/m).offset(1/o).smooth(1/4).ease('easeInOutHalf').fit(1/11).offset(1/12).smooth(1/13).fast(1/m),.1),shuffle(k).smooth(1/m).fast(m/o)).add(shape(2,.1).mult(src(o1).scrollY(-.2)).scroll(shuffle(k).fit(1/o).offset(1/4).smooth(1/5).ease('easeInOutCubic').fit(1/j).offset(1/11).smooth(1/12).fast(1/o),.2),shuffle(k).reverse().smooth(1/o).fast(3/5)).add(shape(2,.1).mult(src(o1).scrollY(-.3)).scroll(shuffle(k).ease('easeInOutQuart').fit(1/9).offset(1/j).smooth(1/11).fast(1/4),.3),shuffle(k).smooth(1/4).fast(4/7)).add(shape(2,.1).mult(src(o1).scrollY(-.4)).scroll(shuffle(k).ease('sin').fit(1/8).offset(1/9).smooth(1/j).fast(1/5),.4),shuffle(k).reverse().smooth(1/5).fast(5/9)).add(shape(2,.1).mult(src(o1).scrollY(-.5)).scroll(shuffle(k).ease('cos').fit(1/7).offset(1/8).smooth(1/9).fast(1/6),.5),shuffle(array).smooth(1/6).fast(6/11)).add(shape(2,.1).mult(src(o1).scrollY(-.6)).scroll(shuffle(k).ease('tan').fit(1/6).offset(1/7).smooth(1/8).fast(1/7),.6),shuffle(k).reverse().smooth(1/7).fast(7/13)).add(shape(2,.1).mult(src(o1).scrollY(-.7)).scroll(shuffle(k).ease('csc').fit(1/5).offset(1/6).smooth(1/7).fast(1/8),.7),shuffle(array).smooth(1/8).fast(8/15)).add(shape(2,.1).mult(src(o1).scrollY(-.8)).scroll(shuffle(k).ease('sec').fit(1/4).offset(1/5).smooth(1/6).fast(1/9),.8),shuffle(k).reverse().smooth(1/9).fast(9/17)).add(shape(2,.1).mult(src(o1).scrollY(-.9)).scroll(shuffle(k).ease('cot').fit(1/m).offset(1/4).smooth(1/5).fast(1/j),.9),shuffle(k).smooth(1/j).fast(j/19)).add(shape(2,.1).mult(src(o1).scrollY(-1)).scroll(shuffle(k).ease('easeInOut').fit(1/m).offset(1/o).smooth(1/4).fast(1/11),1),shuffle(k).reverse().smooth(1/11).fast(11/21)).blend(o0,shuffle(k).smooth()).modulateScale(osc(r.reverse().smooth(m/o).fast(1/j)),[0,window.innerWidth/n/(j^2),window.innerHeight/(n+j^2)/j].reverse().smooth(1/4).ease('easeInOutQuint').fit(1/6).offset(1/7).fast(1/8))
//.scale(o/(m^2))
.out()
synth().invert().luma().posterize(m,m).diff(synth().invert().luma().posterize(m,m).scale(.99)).add(glitch(shake()),shuffle(k).smooth()).add(pop(ratio()),shuffle(k).reverse().smooth()).out(o1)
//src(o0).mult(shape(2,.01).scrollY(()=>(time/4)).rotate([0,Math.PI/2].fast(1/4)),[0,1].fast(1/2)).add(o3,[0,1].fast(1/2)).out(o2)
//render(o3)
