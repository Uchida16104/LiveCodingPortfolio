setResolution(1280, 1280);
shape(99, 1 / 1000)
	.scroll(() => Math.cos(time), () => Math.sin(time))
	.rotate(1, 1)
	.scale(1 / 2)
	.repeat(5, 5)
	.add(o0)
	.out();
screencap();