await loadScript("https://unpkg.com/hydra-nodegl");
setResolution(1600, 1600);
speed = Math.PI * Math.E;
beams = (rate) => shape(2, .01)
	.mult(solid(Math.cos(time / rate), Math.sin(time / rate), Math.acosh(time / rate), Math.asinh(time / rate))
		.laser()
		.hue(rate))
	.rotate(rate, rate)
	.scale([0, rate].smooth(rate)
		.fast(rate))
	.scroll(rate, rate)
	.repeat(rate, rate);
blur = (synth, output, value) => synth.blend(output, value);
let base = solid()
var ratios = new Array();
for (let i = 1 / 10; i <= 1; i += 1 / 10) {
	ratios.push(i);
}
for (let i = 0; i < ratios.length; i++) {
	base = base.blend(beams(ratios[i]))
}
blur(
		base
		.luma(-3 / 5)
		.shift(1, 1, 1)
		.contrast(3 / 2)
		.saturate(2)
		.brightness(-1 / 10),
		o0,
		[0, 1].smooth()
		.fast(1 / 2)
	)
	.sub(shape(99, 0, 1)
		.colorama(3)
		.luma()
		.mult(sphere()))
	.add(o0, .99)
	.out();
screencap();