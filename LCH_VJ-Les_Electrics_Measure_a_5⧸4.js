setResolution(1600, 1600);
setFunction({
  name:"bigbang",
  type:"src",
  inputs:[],
  glsl:`
    vec2 uv=_st*2.0-1.0;
    float t=min(time*0.05,1.0);

    float r=length(uv);

    float blast=
      smoothstep(
        0.4*t,
        0.0,
        r
      );

    return vec4(
      vec3(blast),
      1.0
    );
  `
})

setFunction({
  name:"cosmos",
  type:"src",
  inputs:[],
  glsl:`
    vec2 uv=_st;

    float s=
      step(
        0.995,
        fract(
          sin(dot(
            floor(uv*400.0),
            vec2(12.9898,78.233)
          ))*43758.5453
        )
      );

    return vec4(vec3(s),1.0);
  `
})

setFunction({
  name:"planet",
  type:"src",
  inputs:[],
  glsl:`
    vec2 uv=_st;

    float p=
      smoothstep(
        0.25,
        0.24,
        distance(
          uv,
          vec2(
            0.5+
            sin(time*0.05)*0.2,
            0.5
          )
        )
      );

    vec3 c=
      mix(
        vec3(0.1,0.2,0.8),
        vec3(0.1,0.8,0.4),
        uv.y
      );

    return vec4(c*p,1.0);
  `
})

setFunction({
  name:"lifeform",
  type:"src",
  inputs:[],
  glsl:`
    vec2 uv=_st;

    float l=
      sin(
        uv.x*40.0+
        time
      )*
      sin(
        uv.y*40.0-
        time
      );

    l=smoothstep(
      0.6,
      1.0,
      l
    );

    return vec4(
      vec3(
        0.2,
        1.0,
        0.4
      )*l,
      1.0
    );
  `
})

setFunction({
  name:"nature",
  type:"src",
  inputs:[],
  glsl:`
    vec2 uv=_st;

    float g=
      smoothstep(
        0.3,
        1.0,
        uv.y
      );

    return vec4(
      vec3(
        0.1,
        0.5+
        g*0.4,
        0.1
      ),
      1.0
    );
  `
})

setFunction({
  name:"earth",
  type:"src",
  inputs:[],
  glsl:`
    vec2 uv=_st;

    return vec4(
      mix(
        vec3(
          0.2,
          0.5,
          0.1
        ),
        vec3(
          0.4,
          0.25,
          0.1
        ),
        uv.y
      ),
      1.0
    );
  `
})

setFunction({
  name:"creature",
  type:"src",
  inputs:[],
  glsl:`
    vec2 uv=_st;

    float c=
      smoothstep(
        0.05,
        0.0,
        distance(
          uv,
          vec2(
            0.5+
            sin(time)*0.2,
            0.6+
            cos(time*0.8)*0.1
          )
        )
      );

    return vec4(
      vec3(1.0,0.8,0.4)*c,
      1.0
    );
  `
})

setFunction({
  name:"entropy",
  type:"src",
  inputs:[],
  glsl:`
    vec2 uv=_st;

    float n=
      fract(
        sin(
          dot(
            floor(
              uv*500.0+
              time*10.0
            ),
            vec2(
              12.9898,
              78.233
            )
          )
        )*
        43758.5453
      );

    return vec4(
      vec3(n),
      1.0
    );
  `
})

setFunction({
  name:"bustle",
  type:"coord",
  inputs:[
    {
      type:"float",
      name:"amount",
      default:0.02
    }
  ],
  glsl:`
    vec2 uv=_st;

    uv.x +=
      sin(
        uv.y*10.0+
        time
      )*amount;

    uv.y +=
      cos(
        uv.x*8.0+
        time*0.7
      )*amount;

    return uv;
  `
})
bigbang()

.blend(
  cosmos(),
  () => Math.min(time*0.03,1)
)

.blend(
  planet(),
  () => Math.max(
    0,
    Math.min(
      (time-10)*0.03,
      1
    )
  )
)

.blend(
  lifeform(),
  () => Math.max(
    0,
    Math.min(
      (time-20)*0.03,
      1
    )
  )
)

.blend(
  nature(),
  () => Math.max(
    0,
    Math.min(
      (time-30)*0.03,
      1
    )
  )
)

.blend(
  earth(),
  () => Math.max(
    0,
    Math.min(
      (time-40)*0.03,
      1
    )
  )
)

.blend(
  creature(),
  () => Math.max(
    0,
    Math.min(
      (time-50)*0.03,
      1
    )
  )
)

.add(
  entropy()
    .brightness(-0.8),
  () => Math.min(
    time*0.002,
    0.2
  )
)

.bustle(
  () =>
    0.01+
    Math.sin(time*0.1)*0.01
)

.modulate(
  noise(
    2,
    0.1
  ),
  0.02
)

.saturate(1.4)
.contrast(1.2)

.out(o0);

render(o0);
screencap();