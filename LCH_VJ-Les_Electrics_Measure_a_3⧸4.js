setResolution(1600, 1600);
setFunction({
  name: "spark",
  type: "src",
  inputs: [
    {
      name: "density",
      type: "float",
      default: 80.0
    },
    {
      name: "speed",
      type: "float",
      default: 1.0
    }
  ],
  glsl: `
    vec2 uv = _st * 2.0 - 1.0;
    float t = time * speed;

    float r = length(uv);
    float a = atan(uv.y, uv.x);

    float n =
      fract(
        sin(
          floor(a * density) * 127.1 +
          floor(t * 8.0) * 311.7
        ) * 43758.5453123
      );

    float burst =
      smoothstep(
        0.04 + n * 0.02,
        0.0,
        abs(r - fract(t * 0.4 + n))
      );

    float center =
      smoothstep(
        0.15,
        0.0,
        r
      );

    float spark =
      burst *
      center *
      (0.5 + n);

    vec3 sodium =
      vec3(1.0, 0.85, 0.15);

    vec3 potassium =
      vec3(0.8, 0.3, 1.0);

    vec3 copper =
      vec3(0.1, 1.0, 0.8);

    vec3 lithium =
      vec3(1.0, 0.2, 0.3);

    vec3 barium =
      vec3(0.5, 1.0, 0.2);

    float phase =
      fract(
        t * 0.12 +
        n * 5.0
      );

    vec3 flame =
      mix(
        sodium,
        potassium,
        smoothstep(0.0, 0.2, phase)
      );

    flame =
      mix(
        flame,
        copper,
        smoothstep(0.2, 0.4, phase)
      );

    flame =
      mix(
        flame,
        lithium,
        smoothstep(0.4, 0.6, phase)
      );

    flame =
      mix(
        flame,
        barium,
        smoothstep(0.6, 0.8, phase)
      );

    flame =
      mix(
        flame,
        sodium,
        smoothstep(0.8, 1.0, phase)
      );

    vec3 col =
      flame * spark * 4.0;

    col +=
      flame *
      smoothstep(
        0.3,
        0.0,
        r
      ) *
      0.15;

    return vec4(col, 1.0);
  `
})
setFunction({
  name: "fire",
  type: "src",
  inputs: [
    {
      type: "float",
      name: "speed",
      default: 1.0
    },
    {
      type: "float",
      name: "intensity",
      default: 1.0
    }
  ],
  glsl: `
    vec2 uv = _st;

    float t = time * speed;

    float n =
      sin(uv.x * 8.0 + t * 1.7) * 0.5 +
      sin(uv.x * 17.0 - t * 2.1) * 0.25 +
      sin(uv.x * 31.0 + t * 1.3) * 0.125;

    float flame =
      1.0 - uv.y +
      n * (1.0 - uv.y);

    flame *= intensity;

    float core =
      smoothstep(
        0.15,
        0.8,
        flame
      );

    float mid =
      smoothstep(
        0.0,
        0.6,
        flame
      );

    float outer =
      smoothstep(
        -0.2,
        0.4,
        flame
      );

    vec3 col = vec3(
      core * 1.5 + mid * 0.8,
      mid * 0.9,
      outer * 0.2
    );

    return vec4(col, 1.0);
  `
})

fire(1.5, 1.2)
  .contrast(1.4)
  .saturate(1.6)
.scale(-1)
.blend(
spark()
  .contrast(1.4)
  .saturate(1.8)
.scale(8))
  .out();
screencap();