setResolution(1280, 1280);
osc(Math.random() * 60, 0)
	.thresh()
	.modulate(osc(60, 0)
		.rotate(Math.PI / 2))
	.diff(osc(Math.random() * 60, 0)
		.thresh()
		.modulate(osc(60, 0)
			.rotate(Math.PI))
		.rotate(Math.PI / 2))
	.pixelate()
	.scale(Math.PI * Math.E)
	.out();
screencap();