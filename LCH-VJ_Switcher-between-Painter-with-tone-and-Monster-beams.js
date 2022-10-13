await loadScript("https://unpkg.com/tone")
let o = [o0, o3];
let x = [1, 2, 4, 5, 8, 10];
let xRandom = Math.floor(Math.random() * x.length);
const option = {
	envelope: {
		attack: 0.01,
		decay: 0.01,
		sustain: 0.01,
		release: 0.01,
	},
	portamento: 0.01,
	volume: 0.01,
};

function tune() {
	let inst = ["pulse", "sine", "square", "sawtooth", "triangle"];
	const synth = new Tone.MonoSynth({
			oscillator: {
				type: inst[Math.floor(Math.random() * inst.length)]
			},
			option
		})
		.toDestination();
	synth.triggerAttackRelease(mouse.x * window.innerWidth / 5000, mouse.y / window.innerHeight / x[xRandom]);
};
let count = 0;
let ms = 1000;
const countUp = () => {
	count++;
};
const intervalId = setInterval(() => {
	countUp();
	if (count % o.length == 0) {
		render(o[0]);
	} else if (count % o.length == 1) {
		render(o[1]);
	}
}, ms);
p5 = new P5({
	mode: "WEBGL"
});
p5.hide();
s1.init({
	src: p5.canvas
});
p5.draw = () => {
	p5.background(0, 0, 0, 0);
	p5.noStroke();
	p5.rotateX(time);
	p5.rotateY(time);
	p5.rotateZ(time);
	p5.torus(30, 1);
};
let value = 0;
p5.mousePressed = () => {
	if (value === 0) {
		tune();
	} else {
		console.log("The sound is muted!!");
	}
};
setFunction({
	name: "flag",
	type: "src",
	inputs: [{
			type: "float",
			name: "blending",
			default: 0.5,
		},
		{
			type: "float",
			name: "speed",
			default: 0.5,
		},
		{
			type: "float",
			name: "smoothing",
			default: 0.01,
		},
	],
	glsl: `   vec2 st = _st;
   float repeat = ceil((st.x+st.y/blending)*speed)*sin((smoothing+st.x)*st.y)/0.125  + 0.875;
   float size = log((st.x*st.y-speed*blending)/smoothing+st.y/st.x)-0.375 * 0.625;
   float dist = cos((st.y-st.x)+blending*speed)+floor(st.x-st.y+smoothing);
   return vec4(repeat, size, dist, 1.0);`,
});
s0.initCam()
let freq = 0;
let rate = .1;
let init = .01;
let pattern = 99;
let thickness = () => (a.fft[freq] * rate + init);
let lazer = 1;
let velocity = 10;
let glitter = 10;
let lumen = 1;
let transition = 10;
let cluster = () => (a.fft[freq] * rate * 2 + init * 100);
brush = (form, weight) => shape(form, weight)
	.diff(s1)
	.scroll(() => mouse.x / -window.innerWidth + 1 / 2, () => mouse.y / -window.innerHeight + 1 / 2)
ink = (flash, slowness, coloring, light) => flag(() => Math.sin(time / 10), () => Math.cos(time / 10), () => Math.tan(time / 10))
	.colorama(flash)
	.hue(() => Math.sin(time / slowness), () => Math.cos(time / slowness),
		() => Math.tan(time / slowness))
	.saturate([0, coloring].smooth()
		.fast(1 / coloring))
	.brightness([0, light].smooth()
		.fast(1 / light))
picture = (form, weight, flash, slowness, coloring, light) => brush(form, weight)
	.mult(ink(flash, slowness, coloring, light))
timbre = (reversal) => src(s0)
	.invert(reversal)
synth = (reversal, mix) => solid()
	.add(timbre(reversal), mix)
modulator = (moderate) => osc(1, 2, 300)
	.diff(gradient(1)
		.diff(solid([0, 1].smooth()
				.fast(1 / 8), [0, 1].smooth()
				.fast(1 / 4), [0, 1].smooth()
				.fast(1 / 2), [0, 1].smooth())
			.colorama([0, 1].smooth()
				.fast(1 / moderate / 10))))
	.invert()
	.scale(.1)
	.hue(() => Math.sin(time / 10), () => Math.cos(time / 10), () => Math.tan(time / 10))
beam = (reversal, mix, moderate, amount, strength) => solid()
	.add(synth(reversal, mix))
	.invert()
	.luma(.7)
	.posterize(2, 2)
	.mult(modulator(moderate))
	.blend(src(o3)
		.pixelate(amount, amount)
		.scale(strength), .9)
solid()
	.add(o1, [0, 1].smooth()
		.fast(1 / transition))
	.add(o2, [0, 1].reverse()
		.smooth()
		.fast(1 / transition))
	.out();
picture(pattern, thickness, lazer, velocity, glitter, lumen)
	.add(o1)
	.out(o1);
picture(pattern, thickness, lazer, velocity, glitter, lumen)
	.diff(src(o2)
		.pixelate(75, 75)
		.mult(shape(4, 0, 1)
			.repeat(75, 75))
		.diff(src(o2)
			.scale(.99)
			.diff(src(o2)
				.scale(1.01))))
	.out(o2);
beam(0, 1, .1, 750, cluster)
	.out(o3);
