setFunction({
  name: "flag",
  type: "src",
  inputs: [
    {
      type: "float",
      name: "blending",
      default: 0.5,
    },
    {
      type: "float",
      name: "speed",
      default: 0.5,
    },
    {
      type: "float",
      name: "smoothing",
      default: 0.01,
    },
  ],
  glsl: `   vec2 st = _st;
   float repeat = ceil((st.x+st.y/blending)*speed)*sin((smoothing+st.x)*st.y)/0.125  + 0.875;
   float size = log((st.x*st.y-speed*blending)/smoothing+st.y/st.x)-0.375 * 0.625;
   float dist = cos((st.y-st.x)+blending*speed)+floor(st.x-st.y+smoothing);
   return vec4(repeat, size, dist, 1.0);`,
});
setFunction({
  name: "beam",
  type: "src",
  inputs: [
    {
      type: "float",
      name: "frequency",
      default: 10,
    },
    {
      type: "float",
      name: "sync",
      default: 0.25,
    },
    {
      type: "float",
      name: "offset",
      default: 10,
    },
  ],
  glsl: `   vec2 st = _st;
   float r = tan((st.x*st.y+offset/frequency-time*sync)*frequency)*0.75  + 0.25;
   float g = sin((st.x/st.y-time*sync)*frequency)*0.5 / 0.75;
   float b = cos((st.y/st.x+offset/frequency*time*sync)*frequency)/0.25  - 0.5;
   return vec4(r, g, b, 1);`,
});
p5 = new P5({ mode: "WEBGL" });
p5.hide();
s0.init({ src: p5.canvas });
p5.draw = () => {
  p5.background(0, 0, 0, 0);
  p5.rotateX(time);
  p5.rotateY(time);
  p5.rotateZ(time);
  p5.push();
  p5.noStroke();
  p5.cone(100, 25);
  p5.erase();
  p5.box(100);
  p5.noErase();
  p5.pop();
};
s1.initCam();
function reduce(a = 1, b = 2) {
  return [a, b].reduce((c, d) => Math.sin(c % d));
}
function slice(a = 1, b = 2) {
  return [a, b].slice((c, d) => Math.cos(c & d));
}
function map(a = 1, b = 2) {
  return [a, b].map((c, d) => Math.tan(c ^ d));
}
function pop(a = 1, b = 2) {
  return [a, b].pop((c, d) => Math.asin(c | d));
}
function push(a = 1, b = 2) {
  return [a, b].push((c, d) => Math.acos(c * d));
}
function splice(a = 1, b = 2) {
  return [a, b].splice((c, d) => Math.atan(c / d));
}
src(o1)
  .modulateRotate(src(o2).thresh())
  .modulateScale(
    src(s0)
      .scale(3.25)
      .mult(src(o1).diff(src(o2)))
      .repeat()
  )
  .modulate(
    src(s1)
      .scale(
        () => a.fft[0] * 3,
        () => a.fft[1] * 4,
        () => a.fft[2] * 5
      )
      .scroll(
        () => mouse.x,
        () => mouse.y
      )
      .thresh()
  )
  .out();
solid()
  .diff(beam(reduce(1)))
  .diff(beam(slice(1.2)))
  .diff(beam(map(1.4)))
  .diff(beam(pop(1.6)))
  .diff(beam(push(1.8)))
  .diff(beam(splice(2)))
  .diff(flag(splice(2)).scale(0.1))
  .diff(flag(push(1.8)).scale(0.12))
  .diff(flag(pop(1.6)).scale(0.14))
  .diff(flag(map(1.4)).scale(0.16))
  .diff(flag(slice(1.2)).scale(0.18))
  .diff(flag(reduce(1)).scale(0.2))
  .diff(
    gradient().colorama(
      [0, 5]
        .reverse()
        .ease("easeInOutQuint")
        .smooth()
        .fit(2)
        .offset(1 / 3)
        .fast(1 / 4)
    )
  )
  .modulate(osc(5))
  .modulateRotate(flag())
  .modulateScale(beam())
  .invert()
  .out(o1);
solid()
  .layer(
    src(s0)
      .scroll(
        () => Math.sin(time / 2),
        () => Math.cos(time / 2)
      )
      .rotate(1 / 2, 1 / 2)
  )
  .scroll()
  .scale(0.5)
  .out(o2);
src(s0)
  .diff(
    src(s1)
      .scroll(
        () => mouse.x,
        () => mouse.y
      )
      .scale(
        () => a.fft[1] * 5,
        () => a.fft[2] * 3,
        () => a.fft[0] * 4
      )
  )
  .diff(o0)
  .diff(o1)
  .diff(o2)
  .invert()
  .out(o3);
//render()
//hush()
