setFunction({
  name: "mesh",
  type: "src",
  inputs: [
    {
      type: "float",
      name: "scale",
      default: 10,
    },
    {
      type: "float",
      name: "offset",
      default: 0.1,
    },
  ],
  glsl: `  vec2 st = _st;
vec2 s_st=sin(st);
vec2 c_st=cos(st);
vec2 t_st=tan(st);
vec2 sc=sin(c_st);
vec2 cs=cos(s_st);
float p = 0.01;
float xsin=sin(st.x);
float xcos=cos(st.x);
float ysin=sin(st.y);
float ycos=cos(st.y);
return vec4(vec3(_noise(vec3(sin(st*scale+c_st*t_st+p*cs*xsin/ycos), cos(time/offset*st+s_st/t_st-p*sc/ysin*xcos)))), 1.0);`,
});
setFunction({
  name: "swing",
  type: "coord",
  inputs: [
    {
      type: "float",
      name: "angle",
      default: 10,
    },
    {
      type: "float",
      name: "speed",
      default: 0,
    },
    {
      type: "float",
      name: "amount",
      default: 1.5,
    },
    {
      type: "float",
      name: "xMult",
      default: 1,
    },
    {
      type: "float",
      name: "yMult",
      default: 1,
    },
    {
      type: "float",
      name: "offsetX",
      default: 0.5,
    },
    {
      type: "float",
      name: "offsetY",
      default: 0.5,
    },
  ],
  glsl: `   vec2 xy = _st - vec2(0.5)- vec2(offsetX, offsetY);
   float ang = angle + log(tan(speed)) *sin(cos(time));
   xy = mat2(cos(ang),-sin(ang), sin(ang),cos(ang))*xy;
   xy += 0.5;
   xy*=(1.0/vec2(cos(amount)*asin(xMult), sin(amount)*acos(yMult)));
   xy+=vec2(offsetX, offsetY);
   return xy;`,
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
  p5.torus(100, 25);
  p5.erase();
  p5.sphere(100);
  p5.noErase();
  p5.pop();
};
sat = () => src(s0).diff(src(s0).scale(0.9));
osc(1, 2, 300)
  .diff(
    mesh(5, 100).swing(
      [0, -0.1].smooth(),
      -100,
      [7 / 16, 9 / 16]
        .ease("easeInOutQuart")
        .fit(4)
        .offset(1 / 4)
        .fast(1 / 4),
      0.5,
      0.5,
      [7 / 16, 9 / 16]
        .reverse()
        .ease("easeInOutQuart")
        .fit(1 / 4)
        .offset(4)
        .fast(1 / 4),
      [7 / 16, 9 / 16]
        .reverse()
        .ease("easeInOutQuart")
        .fit(1 / 4)
        .offset(4)
        .fast(1 / 4)
    )
  )
  .modulateKaleid(
    src(o0)
      .swing(
        [0, 0.1].reverse().smooth(),
        -100,
        [7 / 16, 9 / 16]
          .reverse()
          .ease("easeInOutQuart")
          .fit(4)
          .offset(1 / 4)
          .fast(1 / 4),
        0.5,
        0.5,
        [7 / 16, 9 / 16]
          .ease("easeInOutQuart")
          .fit(1 / 4)
          .offset(4)
          .fast(1 / 4),
        [7 / 16, 9 / 16]
          .ease("easeInOutQuart")
          .fit(1 / 4)
          .offset(4)
          .fast(1 / 4)
      )
      .thresh(),
    (speed = 1 / 4),
    (fps = 22.5),
    (bpm = 45)
  )
  .modulate(
    sat()
      .scale(() => a.fft[0] + 1)
      .add(sat().scale(() => a.fft[1] + 1.5))
      .add(sat().scale(() => a.fft[2] + 2))
      .add(sat().scale(() => a.fft[3] + 2.5))
      .thresh()
  )
  .luma(0.9, -0.6, 0.2)
  .out();
//hush()
