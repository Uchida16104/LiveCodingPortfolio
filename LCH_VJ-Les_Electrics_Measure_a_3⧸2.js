setResolution(1600, 1600);
setFunction({
  name: "aurora",
  type: "src",
  inputs: [
    {
      type: "float",
      name: "speed",
      default: 0.3
    }
  ],
  glsl: `
    vec2 uv = _st;

    float t = time * speed;

    float wave1 =
      sin(uv.x * 6.0 + t) * 0.15;

    float wave2 =
      sin(uv.x * 13.0 - t * 1.7) * 0.08;

    float band =
      smoothstep(
        0.0,
        0.25,
        0.45 - abs(uv.y - 0.5 - wave1 - wave2)
      );

    float shimmer =
      0.7 +
      0.3 * sin(
        uv.x * 40.0 +
        uv.y * 15.0 +
        t * 4.0
      );

    vec3 col = mix(
      vec3(0.0, 0.2, 0.1),
      vec3(0.1, 1.0, 0.7),
      band * shimmer
    );

    return vec4(col, 1.0);
  `
})
setFunction({
  name: "rainbow",
  type: "src",
  inputs: [
    {
      type: "float",
      name: "speed",
      default: 0.25
    }
  ],
  glsl: `
    vec2 uv = _st;

    float t = time * speed;

    float x =
      fract(
        uv.x +
        t +
        sin(uv.y * 6.0 + t) * 0.1
      );

    vec3 col =
      0.5 +
      0.5 *
      cos(
        6.28318 *
        (
          x +
          vec3(
            0.0,
            0.33,
            0.67
          )
        )
      );

    return vec4(col, 1.0);
  `
})
setFunction({
  name: "thunder",
  type: "src",
  inputs: [
    {
      type: "float",
      name: "speed",
      default: 1.0
    },
    {
      type: "float",
      name: "branches",
      default: 12.0
    }
  ],
  glsl: `
    vec2 uv = _st * 2.0 - 1.0;

    float t = time * speed;

    float flash = pow(
      max(
        sin(t * 1.7 + sin(t * 0.43) * 2.0),
        0.0
      ),
      18.0
    );

    float bolt = 0.0;

    for (int i = 0; i < 12; i++) {
      float fi = float(i);

      vec2 p = uv;

      p.x += sin(
        p.y * (8.0 + fi * 0.7)
        + t * (2.0 + fi * 0.15)
      ) * 0.08;

      p.x += sin(
        p.y * (20.0 + fi)
        - t * (3.0 + fi * 0.1)
      ) * 0.03;

      float line =
        0.015 /
        (abs(p.x + sin(fi * 12.345) * 0.4) + 0.001);

      bolt += line;
    }

    bolt *= smoothstep(1.2, -0.9, uv.y);

    float glow = pow(bolt, 1.4);

    vec3 col = vec3(
      glow * 0.7,
      glow * 0.9,
      glow * 1.6
    );

    col += flash * vec3(0.4, 0.5, 0.8);

    return vec4(col, 1.0);
  `
})
setFunction({
  name: "thunder",
  type: "src",
  inputs: [
    {
      type: "float",
      name: "speed",
      default: 1.0
    },
    {
      type: "float",
      name: "branches",
      default: 12.0
    }
  ],
  glsl: `
    vec2 uv = _st * 2.0 - 1.0;

    float t = time * speed;

    float flash = pow(
      max(
        sin(t * 1.7 + sin(t * 0.43) * 2.0),
        0.0
      ),
      18.0
    );

    float bolt = 0.0;

    for (int i = 0; i < 12; i++) {
      float fi = float(i);

      vec2 p = uv;

      p.x += sin(
        p.y * (8.0 + fi * 0.7)
        + t * (2.0 + fi * 0.15)
      ) * 0.08;

      p.x += sin(
        p.y * (20.0 + fi)
        - t * (3.0 + fi * 0.1)
      ) * 0.03;

      float line =
        0.015 /
        (abs(p.x + sin(fi * 12.345) * 0.4) + 0.001);

      bolt += line;
    }

    bolt *= smoothstep(1.2, -0.9, uv.y);

    float glow = pow(bolt, 1.4);

    vec3 col = vec3(
      glow * 0.7,
      glow * 0.9,
      glow * 1.6
    );

    col += flash * vec3(0.4, 0.5, 0.8);

    return vec4(col, 1.0);
  `
})
setFunction({
  name: "clouds",
  type: "src",
  inputs: [
    {type:"float",name:"speed",default:0.15}
  ],
  glsl: `
    vec2 uv = _st;
    float t = time * speed;

    float n =
      sin(uv.x*3.0+t)*0.3 +
      sin(uv.y*5.0-t*0.7)*0.3 +
      sin((uv.x+uv.y)*7.0+t*0.4)*0.2;

    n = smoothstep(-0.2,0.5,n);

    vec3 col =
      mix(
        vec3(0.02,0.02,0.05),
        vec3(0.9,0.9,1.0),
        n
      );

    return vec4(col,1.0);
  `
})

setFunction({
  name: "rain",
  type: "src",
  inputs: [
    {type:"float",name:"speed",default:2.0}
  ],
  glsl: `
    vec2 uv = _st;

    float t = time * speed;

    float x =
      floor(uv.x * 120.0);

    float shift =
      fract(
        sin(x * 91.7) *
        43758.5453
      );

    float y =
      fract(
        uv.y * 8.0 -
        t -
        shift
      );

    float drop =
      smoothstep(
        0.12,
        0.0,
        abs(y - 0.05)
      );

    return vec4(
      vec3(drop),
      1.0
    );
  `
})
speed = 0.5

thunder(
  () => 0.8 + Math.sin(time*0.13)*0.4,
  12
)

.mult(
  clouds(
    () => 0.1 + Math.sin(time*0.07)*0.08
  )
)

.add(
  aurora(
    () => 0.3 + Math.sin(time*0.09)*0.2
  )
  .modulate(
    noise(
      () => 2 + Math.sin(time*0.05),
      0.15
    ),
    () => 0.03 + Math.abs(Math.sin(time*0.11))*0.05
  )
  .brightness(0.1),
  () => 0.5 + 0.2*Math.sin(time*0.17)
)

.add(
  rainbow(
    () => 0.15 + Math.cos(time*0.08)*0.1
  )
  .scrollX(
    () => Math.sin(time*0.03)*0.3
  )
  .rotate(
    () => Math.sin(time*0.04)*0.15
  ),
  () => 0.25 + 0.15*Math.sin(time*0.21)
)

.add(
  rain(
    () => 1.5 + Math.sin(time*0.14)
  )
  .brightness(
    () => 0.1 + Math.random()*0.05
  ),
  () => 0.4 + 0.2*Math.sin(time*0.31)
)

.modulate(
  noise(
    () => 3 + Math.sin(time*0.05),
    0.05
  ),
  () => 0.01 + Math.abs(Math.sin(time*0.07))*0.03
)

.kaleid(
  () =>
    3 +
    Math.floor(
      Math.abs(
        Math.sin(time*0.02)
      ) * 4
    )
)

.color(
  () => 0.8 + 0.2*Math.sin(time*0.12),
  () => 0.8 + 0.2*Math.sin(time*0.15),
  () => 1.0 + 0.3*Math.sin(time*0.18)
)

.contrast(
  () => 1.2 + 0.4*Math.sin(time*0.09)
)

.saturate(
  () => 1.3 + 0.7*Math.sin(time*0.06)
)

.blend(
  src(o0)
    .scale(1.001)
    .rotate(
      () => Math.sin(time*0.01)*0.001
    ),
  0.15
)

.out(o0);

render(o0);

screencap();