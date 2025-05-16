await loadScript("https://nodegl.glitch.me/function-list.js");
setResolution(800, 800);
src(o0)
	.painting()
	.over()
	.ringModulate()
	.modulateRingModulator(o0)
	.layer(sand()
		.modulateGlitch(o0)
		.sub(lightning()
			.mask(noise())))
	.invert()
	.blend(src(o0)
		.modulateShear(beam()), 3 / 4)
	.out();
