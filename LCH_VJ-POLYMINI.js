await loadScript("https://unpkg.com/hydra-nodegl");
setResolution(1600, 1600);
function catEye(height, width) {
	return osc(10, 1 / 8, 300)
		.kaleid(99)
		.modulate(chaos())
		.modulateScale(visual()
			.swirl(10))
		.diff(huecircle())
		.diff(gradient(1)
			.modulateSpiral(o0, 5))
		.modulateRotate(beam()
			.polar())
		.scale(height, width)
		.diff(sphere())
		.diff(shape(99, 0, 1)
			.colorama(3)
			.scale(height, width))
		.modulate(lissajous()
			.laser()
			.blend(lissajouslaser()))
		.modulateRingModulator(ringModulator()
			.ringModulate())
		.blend(src(o0)
			.echo()
			.chorus()
			.vibrato()
			.rotate(Math.PI)
			.scale(1.1))
		.invert();
}
catEye(1, 1)
	.out();
//screencap();