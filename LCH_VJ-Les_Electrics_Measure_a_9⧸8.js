setResolution(1600, 1600);

setFunction({
  name: "tree",
  type: "src",
  inputs: [
    {type:"float",name:"growth",default:1}
  ],
  glsl: `
    vec2 uv = _st;

    float g = clamp(growth,0.0,1.0);

    float trunk =
      smoothstep(
        0.03,
        0.0,
        abs(uv.x-0.5)
      )
      *
      step(
        1.0-g,
        uv.y
      );

    float canopy =
      smoothstep(
        0.35,
        0.0,
        distance(
          uv,
          vec2(
            0.5,
            0.65
          )
        )
      )
      *
      g;

    vec3 sky =
      mix(
        vec3(0.6,0.8,1.0),
        vec3(0.9,0.95,1.0),
        uv.y
      );

    vec3 col = sky;

    col = mix(
      col,
      vec3(0.35,0.2,0.1),
      trunk
    );

    col = mix(
      col,
      vec3(0.1,0.55,0.15),
      canopy
    );

    return vec4(col,1.0);
  `
})

setFunction({
  name:"forest",
  type:"src",
  inputs:[
    {type:"float",name:"density",default:1}
  ],
  glsl:`
    vec2 uv=_st;

    float rows =
      floor(uv.x*20.0*density);

    float local =
      fract(uv.x*20.0*density);

    float trunk =
      smoothstep(
        0.08,
        0.0,
        abs(local-0.5)
      );

    float canopy =
      smoothstep(
        0.42,
        0.0,
        distance(
          vec2(local,uv.y),
          vec2(
            0.5,
            0.35
          )
        )
      );

    vec3 sky =
      mix(
        vec3(0.55,0.8,1.0),
        vec3(0.9,0.95,1.0),
        uv.y
      );

    vec3 forest =
      vec3(
        0.08,
        0.35+canopy*0.4,
        0.08
      );

    vec3 col =
      mix(
        sky,
        forest,
        canopy
      );

    col =
      mix(
        col,
        vec3(
          0.25,
          0.15,
          0.05
        ),
        trunk*step(0.35,uv.y)
      );

    return vec4(col,1.0);
  `
})

setFunction({
  name:"wind",
  type:"coord",
  inputs:[
    {type:"float",name:"amount",default:0.02}
  ],
  glsl:`
    vec2 uv=_st;

    uv.x +=
      sin(
        uv.y*10.0+
        time*0.8
      )
      *
      amount
      *
      (1.0-uv.y);

    return uv;
  `
})

setFunction({
  name:"grow",
  type:"coord",
  inputs:[
    {type:"float",name:"amount",default:0.05}
  ],
  glsl:`
    vec2 uv=_st;

    float g =
      min(
        time*0.02,
        1.0
      );

    uv.y =
      mix(
        1.0,
        uv.y,
        g
      );

    return uv;
  `
})

forest(
  () =>
    0.5 +
    Math.min(
      time*0.03,
      1.5
    )
)

.grow(
  () =>
    0.05 +
    Math.sin(time*0.05)
    *0.01
)

.wind(
  () =>
    0.01 +
    Math.abs(
      Math.sin(time*0.15)
    )*0.02
)

.layer(
  tree(
    () =>
      Math.min(
        time*0.03,
        1
      )
  )
  .scale(0.3)
  .scrollX(0.2)
  .scrollY(0.15)
)

.layer(
  tree(
    () =>
      Math.min(
        time*0.025,
        1
      )
  )
  .scale(0.4)
  .scrollX(-0.25)
  .scrollY(0.1)
)

.modulate(
  noise(
    2,
    0.05
  ),
  0.01
)

.color(
  0.95,
  1.05,
  0.95
)

.contrast(1.1)
.saturate(1.3)

.out(o0);

render(o0);

screencap();