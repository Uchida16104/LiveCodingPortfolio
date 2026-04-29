await loadScript("https://unpkg.com/hydra-nodegl");
setFunction({
  name: "rotateX",
  type: "coord",
  inputs: [{ name: "angle", type: "float", default: 0.0 }],
  glsl: `
  vec2 p = _st * 2.0 - 1.0;
  float aspect = resolution.x / resolution.y;
  p.x *= aspect;
  float r2 = dot(p, p);
  if (r2 > 1.0) return _st;
  float z = sqrt(1.0 - r2);
  float c = cos(angle);
  float s = sin(angle);
  vec3 v = vec3(p.x, p.y, z);
  vec3 vr = vec3(
    v.x,
    v.y * c - v.z * s,
    v.y * s + v.z * c
  );
  vec2 q = vec2(vr.x / aspect, vr.y);
  return q * 0.5 + 0.5;
  `,
});
setFunction({
  name: "rotateY",
  type: "coord",
  inputs: [{ name: "angle", type: "float", default: 0.0 }],
  glsl: `
  vec2 p = _st * 2.0 - 1.0;
  float aspect = resolution.x / resolution.y;
  p.x *= aspect;
  float r2 = dot(p, p);
  if (r2 > 1.0) return _st;
  float z = sqrt(1.0 - r2);
  float c = cos(angle);
  float s = sin(angle);
  vec3 v = vec3(p.x, p.y, z);
  vec3 vr = vec3(
    v.x * c + v.z * s,
    v.y,
    -v.x * s + v.z * c
  );
  vec2 q = vec2(vr.x / aspect, vr.y);
  return q * 0.5 + 0.5;
  `,
});
setFunction({
  name: "rotateZ",
  type: "coord",
  inputs: [{ name: "angle", type: "float", default: 0.0 }],
  glsl: `
  vec2 p = _st * 2.0 - 1.0;
  float aspect = resolution.x / resolution.y;
  p.x *= aspect;
  float r2 = dot(p, p);
  if (r2 > 1.0) return _st;
  float z = sqrt(1.0 - r2);
  float c = cos(angle);
  float s = sin(angle);
  vec3 v = vec3(p.x, p.y, z);
  vec3 vr = vec3(
    v.x * c - v.y * s,
    v.x * s + v.y * c,
    v.z
  );
  vec2 q = vec2(vr.x / aspect, vr.y);
  return q * 0.5 + 0.5;
  `,
});
function videocap(target = o0, durationMs = 5000, options = {}) {
  const {
    filename = `hydra-${Date.now()}.webm`,
    renderTarget = true,
    restore = null,
  } = options;
  if (renderTarget) {
    render(target);
  }
  if (typeof vidRecorder === "undefined") {
    throw new Error("vidRecorder is not available in this Hydra environment.");
  }
  vidRecorder.start();
  setTimeout(() => {
    try {
      vidRecorder.stop();
    } finally {
      if (typeof restore === "function") {
        restore();
      }
    }
  }, durationMs);
  return {
    filename,
    target,
    durationMs,
  };
}
sphere().mult(osc(10,1/8,300).hue())
  .rotateX(()=>time)
  .rotateY(()=>time)
  .rotateZ(()=>time)
  .out();
videocap(o0,6000);
