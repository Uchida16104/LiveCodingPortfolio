setResolution(1280, 1280);
await loadScript("https://nodegl.glitch.me/function-list.js");
chaos()
	.r(3)
	.modulateGlitch(o0)
	.modulateRandomNoise(o0, .1)
	.invert()
	.luma()
	.diff(src(o0)
		.scale(.99))
	.diff(src(o0)
		.scale(1.01))
	.blend(src(o0)
		.echo()
		.chorus()
		.vibrato()
		.ringModulate()
		.rotate(.1, .1)
		.scale(1.01)
		.modulateRingModulator(o0))
	.out();
screencap();