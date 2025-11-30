await loadScript("https://unpkg.com/hydra-nodegl");
setResolution(1600, 1600);
setFunction({
	name: 'jigsawPauseShift',
	type: 'combineCoord',
	inputs: [{
			type: 'float',
			name: 'tilesX',
			default: 4
		},
		{
			type: 'float',
			name: 'tilesY',
			default: 4
		},
		{
			type: 'float',
			name: 'amplitude',
			default: 0.2
		},
		{
			type: 'float',
			name: 'pauseDuration',
			default: 1.0
		},
		{
			type: 'float',
			name: 'speed',
			default: 0.1
		}
	],
	glsl: `
    vec2 st = _st;
    vec2 tile = floor(st * vec2(tilesX, tilesY));
    vec2 tileSize = vec2(1.0 / tilesX, 1.0 / tilesY);
    float seedX = fract(sin(dot(tile, vec2(12.9898,78.233))) * 43758.5453);
    float seedY = fract(sin(dot(tile, vec2(93.9898,67.345))) * 43758.5453);
    vec2 randDir = vec2(seedX*2.0-1.0, seedY*2.0-1.0);
    float phase = fract((time + (tile.x + tile.y)) / pauseDuration);
    float active = step(phase, 0.5);
    vec2 offset = randDir * amplitude * active;
    float t = clamp(1.0 - (time * speed), 0.0, 1.0);
    st += offset * t;
    return st;
  `
});
normalize = (src) => src.scale(1, 1 / 2);
base=()=>sphere()
	.colorama(2)
	.hue()
	.mult(huecircle()
		.modulateScale(shape(99, 0, 1)
			.scale(1, 1 / 2))
		.diff(normalize(visual()
			.swirl(10)))
		.diff(normalize(osc(10, 0, 300)
			.kaleid(99)))
		.diff(normalize(gradient()
			.polar()))
		.invert())
first=()=>init()
	.modulateScrollY(shape(2, .1)
		.scale(() => Math.random(), () => Math.random())
		.repeat(() => Math.random(), () => Math.random()), () => Math.random())
	.modulateScrollX(shape(2, .1)
		.scale(() => Math.random(), () => Math.random())
		.repeat(() => Math.random() * 10, () => Math.random() * 10), () => Math.random())
	.jigsawPauseShift(o0, 10, 10, 1, 1, 0.01)
init=()=>base();
synth = () => first();
synth()
.disassemble()
.modulateScrollY(shape(2, .1)
		.scale(() => Math.random(), () => Math.random())
		.repeat(() => Math.random(), () => Math.random()), () => Math.random())
	.modulateScrollX(shape(2, .1)
		.scale(() => Math.random(), () => Math.random())
		.repeat(() => Math.random() * 10, () => Math.random() * 10), () => Math.random())
	.jigsawPauseShift(o0, 10, 10, 1, 1, 0.01)
.out(o0);
synth()
.modulateScrollY(shape(2, .1)
		.scale(() => Math.random(), () => Math.random())
		.repeat(() => Math.random(), () => Math.random()), () => Math.random())
	.modulateScrollX(shape(2, .1)
		.scale(() => Math.random(), () => Math.random())
		.repeat(() => Math.random() * 10, () => Math.random() * 10), () => Math.random())
	.jigsawPauseShift(o1, 10, 10, 1, 1, 0.01)
.pixelate(() => Math.cos(time / 10) * window.innerWidth, () => Math.sin(time / 10) * window.innerHeight)
.out(o1);
synth()
.modulateScrollY(shape(2, .1)
		.scale(() => Math.random(), () => Math.random())
		.repeat(() => Math.random(), () => Math.random()), () => Math.random())
	.modulateScrollX(shape(2, .1)
		.scale(() => Math.random(), () => Math.random())
		.repeat(() => Math.random() * 10, () => Math.random() * 10), () => Math.random())
	.jigsawPauseShift(o2, 10, 10, 1, 1, 0.01)
.split()
.out(o2);
synth()
.diff(src(o3)
      .modulateScrollY(shape(2, .1)
		.scale(() => Math.random(), () => Math.random())
		.repeat(() => Math.random(), () => Math.random()), () => Math.random())
	.modulateScrollX(shape(2, .1)
		.scale(() => Math.random(), () => Math.random())
		.repeat(() => Math.random() * 10, () => Math.random() * 10), () => Math.random())
	.jigsawPauseShift(o3, 10, 10, 1, 1, 0.01)
.hue("cos(st.x+time)/sin(st.y+time)"))
.out(o3);
render();
screencap();