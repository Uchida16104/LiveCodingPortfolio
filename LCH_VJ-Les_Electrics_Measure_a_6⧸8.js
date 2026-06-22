setResolution(1600, 1600);

setFunction({
  name: "storm",
  type: "coord",
  inputs: [
    { type: "float", name: "strength", default: 0.03 },
    { type: "float", name: "speed", default: 0.6 }
  ],
  glsl: `
    vec2 uv = _st;

    float t = time * speed;

    float swirl =
      sin(uv.y * 8.0 + t) * cos(uv.x * 6.0 - t * 0.7);

    uv.x += swirl * strength;
    uv.y += cos(uv.x * 5.0 + t) * strength * 0.5;

    return uv;
  `
})
setFunction({
  name: "cyclone",
  type: "coord",
  inputs: [
    { type: "float", name: "amount", default: 0.04 }
  ],
  glsl: `
    vec2 uv = _st - 0.5;

    float r = length(uv);
    float a = atan(uv.y, uv.x);

    float t = time * 0.4;

    a += sin(r * 6.0 - t) * amount;

    uv = vec2(cos(a), sin(a)) * r;

    return uv + 0.5;
  `
})
setFunction({
  name: "tornado",
  type: "coord",
  inputs: [
    { type: "float", name: "power", default: 0.05 }
  ],
  glsl: `
    vec2 uv = _st;

    float t = time;

    float d = uv.y;

    float spin =
      sin(d * 10.0 + t) * power;

    uv.x += spin * (1.0 - uv.y);

    return uv;
  `
})
setFunction({
  name: "typhoon",
  type: "coord",
  inputs: [
    { type: "float", name: "intensity", default: 0.02 }
  ],
  glsl: `
    vec2 uv = _st;

    float t = time;

    uv.x += sin(uv.y * 12.0 + t) * intensity;
    uv.y += cos(uv.x * 10.0 - t) * intensity;

    return uv;
  `
})
osc(10,0.2,1)

.storm(0.02, 0.5)
.tornado(0.04)
.cyclone(0.03)
.typhoon(0.02)

.color(0.2,0.3,0.4)
.contrast(1.5)
.saturate(1.2)

.add(
  noise(3,0.2)
    .brightness(-0.3),
  0.3
)

.modulate(
  noise(2,0.1),
  0.02
)

.scale(1.01)

.out();

screencap();