setResolution(1280, 720);
setFunction({
  name: "virus",
  type: "src",
  inputs: [
    {
      name: "density",
      type: "float",
      default: 30.0
    }
  ],
  glsl: `
    vec2 uv = _st * 2.0 - 1.0;

    vec3 col = vec3(0.0);

    for(int i = 0; i < 30; i++) {

      float fi = float(i);

      float seed =
        fi * 17.381 +
        time * 0.2;

      vec2 p = vec2(
        sin(seed * 1.71),
        cos(seed * 2.31)
      );

      p += 0.4 * vec2(
        sin(time * (0.3 + fi * 0.01)),
        cos(time * (0.5 + fi * 0.02))
      );

      float size =
        0.03 +
        0.08 *
        abs(sin(seed + time));

      vec2 d = uv - p;

      float r = length(d);

      float body =
        smoothstep(size,size*0.4,r);

      float spikes = 0.0;

      for(int j = 0; j < 12; j++) {

        float fj = float(j);

        float a =
          fj *
          6.28318 /
          12.0;

        vec2 sp =
          p +
          vec2(cos(a),sin(a))
          * size;

        float sr =
          length(uv - sp);

        spikes +=
          smoothstep(
            size*0.3,
            size*0.05,
            sr
          );
      }

      vec3 virusColor =
        0.5 +
        0.5 *
        cos(
          vec3(
            0.0,
            2.0,
            4.0
          )
          + seed
          + time
        );

      col +=
        virusColor *
        (
          body +
          spikes * 0.2
        );
    }

    return vec4(col,1.0);
  `
})
setFunction({
  name: "insect",
  type: "src",
  inputs: [
    {
      name: "density",
      type: "float",
      default: 24.0
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

    uv.x += sin(t * 0.71 + uv.y * 4.0) * 0.2;
    uv.y += cos(t * 0.53 + uv.x * 5.0) * 0.2;

    float a = atan(uv.y, uv.x);
    float r = length(uv);

    float swarm = 0.0;

    for(int i = 0; i < 8; i++) {

      float fi = float(i);

      vec2 p = vec2(
        sin(t * (0.3 + fi * 0.07) + fi * 2.3),
        cos(t * (0.5 + fi * 0.05) + fi * 1.7)
      );

      float rr =
        0.12 +
        0.05 * sin(t * 2.0 + fi * 4.0);

      swarm += rr / (
        length(uv - p) + 0.02
      );
    }

    float spikes =
      sin(a * density + t * 3.0) *
      sin(a * density * 0.5 - t * 2.0);

    float membrane =
      smoothstep(
        0.9 + spikes * 0.15,
        0.2,
        r + sin(t + r * 10.0) * 0.05
      );

    float body =
      membrane +
      swarm * 0.08;

    float pulse =
      0.5 +
      0.5 *
      sin(t * 5.0);

    vec3 col = vec3(
      body * (0.8 + pulse),
      body * abs(sin(t)),
      body * abs(cos(t * 0.7))
    );

    return vec4(col, 1.0);
  `
})
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
virus().diff(insect()).blend(o0,[1/10,9/10].reverse().ease("easeInOutHalf").smooth(1/3).fit(1/5).offset(1/7).fast(1/11)).out();
videocap(o0, 6000);
