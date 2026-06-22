setResolution(1600, 1600);

setFunction({
  name:"rain",
  type:"src",
  inputs:[
    {type:"float",name:"speed",default:2}
  ],
  glsl:`
    vec2 uv=_st;

    float t=time*speed;

    float col=floor(uv.x*80.0);

    float rnd=fract(
      sin(col*91.345)*43758.5453
    );

    float y=fract(
      uv.y*6.0-t-rnd
    );

    float d=
      smoothstep(
        0.03,
        0.0,
        abs(y)
      );

    return vec4(
      vec3(d),
      1.0
    );
  `
})
setFunction({
  name:"water",
  type:"src",
  inputs:[
    {type:"float",name:"speed",default:0.5}
  ],
  glsl:`
    vec2 uv=_st;

    float t=time*speed;

    float w=
      sin(uv.x*20.0+t)*0.5+
      sin(uv.x*11.0-t*1.4)*0.3+
      sin(uv.x*40.0+t*0.4)*0.2;

    w=0.5+w*0.2;

    vec3 col=
      mix(
        vec3(0.0,0.15,0.35),
        vec3(0.3,0.7,1.0),
        w
      );

    return vec4(col,1.0);
  `
})
setFunction({
  name:"river",
  type:"src",
  inputs:[
    {type:"float",name:"speed",default:0.2}
  ],
  glsl:`
    vec2 uv=_st;

    float t=time*speed;

    float river=
      smoothstep(
        0.45,
        0.15,
        abs(
          uv.x
          -0.5
          -sin(
            uv.y*4.0+t
          )*0.12
        )
      );

    vec3 bank=
      vec3(
        0.15,
        0.4,
        0.1
      );

    vec3 water=
      vec3(
        0.05,
        0.3,
        0.7
      );

    return vec4(
      mix(bank,water,river),
      1.0
    );
  `
})
setFunction({
  name:"drop",
  type:"coord",
  inputs:[
    {type:"float",name:"amount",default:0.01}
  ],
  glsl:`
    vec2 uv=_st;

    float t=time;

    vec2 p1=vec2(
      fract(sin(floor(t))*43.1),
      fract(cos(floor(t))*17.3)
    );

    float r=
      distance(uv,p1);

    uv +=
      normalize(uv-p1)
      *
      sin(
        r*60.0
        -t*10.0
      )
      *
      amount
      *
      exp(-r*8.0);

    return uv;
  `
})
setFunction({
  name:"flow",
  type:"coord",
  inputs:[
    {type:"float",name:"amount",default:0.02}
  ],
  glsl:`
    vec2 uv=_st;

    uv.x +=
      sin(
        uv.y*8.0+
        time*0.7
      )
      *
      amount;

    uv.y +=
      sin(
        uv.x*12.0+
        time
      )
      *
      amount
      *
      0.5;

    return uv;
  `
})
river(0.2)

.layer(
  water(0.5)
    .flow(
      () =>
      0.01+
      Math.sin(time*0.1)*0.005
    )
)

.layer(
  rain(
    () =>
    1.5+
    Math.sin(time*0.15)
  )
  .brightness(0.4)
)

.drop(
  () =>
  0.004+
  Math.abs(
    Math.sin(time*0.23)
  )*0.004
)

.flow(
  () =>
  0.015+
  Math.sin(time*0.11)*0.005
)

.modulate(
  noise(
    2,
    0.05
  ),
  0.01
)

.color(
  0.9,
  1.0,
  1.2
)

.contrast(1.15)

.out(o0);

render(o0);

screencap();