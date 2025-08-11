await loadScript("https://unpkg.com/hydra-nodegl");
setResolution(1600, 1600);
visual()
	.layer(osc(1, 0, 300)
		.polar()
		.echo()
		.sub(huecircle()
			.chorus()
			.mask(solid(1, 1, 1, 1)
				.modulateSpiral(o0, 5)
				.vibrato())))
	.modulate(sphere())
	.blend(lissajouslaser())
	.modulate(ringModulator()
		.ringModulate()
		.modulateRingModulator(o0))
	.rotate(-1)
	.scale("(st.x+st.y)*0.25")
	.out();
screencap();