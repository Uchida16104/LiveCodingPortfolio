await loadScript("https://unpkg.com/hydra-nodegl");
setResolution(1600, 1600);
base = () => visual()
	.polar()
	.diff(gradient()
		.kaleid(99))
	.diff(osc(10, 0, 300)
		.swirl(10));
function colorize(synth, h, s, b, c) {
	return synth.invert()
		.hue(h)
		.saturate(s)
		.brightness(b)
		.contrast(c);
}
colorize(base(), 1 / 2, 1, -1 / 2, 2)
	.diff(colorize(src(o0)
		.rotate(-1 / 10, -1 / 10), 1 / 2, 1, -1 / 2, 2))
	.brightness(1 / 2)
	.invert()
	.blend(o0, 99 / 100)
	.out();
//screencap();