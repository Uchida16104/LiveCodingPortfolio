speed = 8 / 6;
setFunction({
	name: 'diamond',
	type: 'src',
	inputs: [{
			name: 'size',
			type: 'float',
			default: 0.35
		},
		{
			name: 'edge',
			type: 'float',
			default: 0.01
		},
		{
			name: 'shine',
			type: 'float',
			default: 0.55
		}
	],
	glsl: `
    vec2 p = _st * 2.0 - 1.0;
    float d = abs(p.x) + abs(p.y);
    float r = max(size, 0.0001);
    float mask = 1.0 - smoothstep(r, r + max(edge, 0.0001), d);
    float core = clamp(1.0 - d / r, 0.0, 1.0);
    float f1 = clamp(0.5 + 0.5 * (p.x + p.y) / r, 0.0, 1.0);
    float f2 = clamp(0.5 + 0.5 * (p.x - p.y) / r, 0.0, 1.0);
    vec3 base = mix(vec3(0.05, 0.12, 0.25), vec3(0.88, 0.94, 1.0), f1);
    base = mix(base, vec3(1.0), shine * pow(core, 3.0));
    return vec4(base * mask, mask);
  `
});
setFunction({
	name: 'diamondProject',
	type: 'combineCoord',
	inputs: [{
		name: 'amount',
		type: 'float',
		default: 0.18
	}],
	glsl: `
    vec2 p = _st * 2.0 - 1.0;
    float d = abs(p.x) + abs(p.y);
    float face = clamp(1.0 - d, 0.0, 1.0);
    vec2 n;
    if (p.x >= 0.0 && p.y >= 0.0) {
      n = normalize(vec2(1.0, 1.0));
    } else if (p.x < 0.0 && p.y >= 0.0) {
      n = normalize(vec2(-1.0, 1.0));
    } else if (p.x < 0.0 && p.y < 0.0) {
      n = normalize(vec2(-1.0, -1.0));
    } else {
      n = normalize(vec2(1.0, -1.0));
    }
    float colorStrength = clamp((_c0.r + _c0.g + _c0.b) / 3.0, 0.0, 1.0);
    float pull = amount * face * (0.35 + 0.65 * colorStrength);
    p += n * pull;
    return p * 0.5 + 0.5;
  `
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
diamond()
	.diamondProject(osc()
		.kaleid()
		.thresh(), [0, 1].smooth()
		.fast(1 / 5))
	.colorama([0, 2].reverse()
		.smooth()
		.fast(1 / 2))
	.hue([0, 1].reverse()
		.smooth()
		.fast(1 / 3))
	.mult(osc()
		.kaleid()
		.luma()
		.pixelate()
		.repeat()
		.scale(1.01))
	.diff(src(o0)
		.scale(1.01))
	.out();
videocap(o0, 6000);
