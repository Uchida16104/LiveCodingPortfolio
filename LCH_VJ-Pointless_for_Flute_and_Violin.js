setResolution(1600, 1600);
osc()
	.modulateScrollX(osc()
		.thresh()
		.shift()
		.pixelate())
	.posterize()
	.colorama(1)
	.hue()
	.diff(src(o0)
		.rotate(Math.PI / 2)
		.hue())
	.scale(2)
	.blend(src(o0))
	.out();
screencap();