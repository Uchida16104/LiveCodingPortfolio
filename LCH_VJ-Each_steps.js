setResolution(1600, 1600);

setFunction({
  name: "spiral",
  type: "src",

  inputs: [
    {
      type: "float",
      name: "steps",
      default: 24
    },
    {
      type: "float",
      name: "twist",
      default: 6
    },
    {
      type: "float",
      name: "radius",
      default: 0.35
    }
  ],

  glsl: `
    vec2 uv = _st * 2.0 - 1.0;

    float a = atan(uv.y, uv.x);
    float r = length(uv);

    float s = fract(
        a / 6.2831853 * steps
        + r * twist
    );

    float stair =
        smoothstep(radius, radius-0.02, abs(r-s*radius));

    return vec4(vec3(stair),1.0);
  `
});

spiral(28,10,0.55)
.mult(
    osc(3,0.02,1)
      .color(
          1,
          Math.sin(time*0.3)*0.5+0.5,
          Math.cos(time*0.4)*0.5+0.5
      )
)
.modulateRotate(
    noise(2,0.1),
    0.4
)
.repeat(2,2)
.rotate(
    ()=>time*0.03
)
.scale(
    1.15
)
.kaleid(9)
.colorama(1)
.saturate(2)
.out();