await loadScript("https://unpkg.com/hydra-nodegl");
setResolution(1600, 1600);
synth = (rot) => shape(2, .01)
	.rotate(rot, rot)
	.mult(shape(99, .5)
		.colorama(1)
		.hue("cos(st.x+time)*sin(st.y+time)"))
	.mult(osc(10, 1 / 8, 300)
		.kaleid(99)
		.diff(gradient(1)
			.swirl(10)
			.diff(visual()
				.polar()
				.diff(huecircle()))))
	.contrast(1.01)
	.hue("cos(st.y)+sin(st.x)")
	.saturate(10);
solid()
	.diff(
		synth(Math.PI / 10)
		.add(src(o0)
			.scale(.9))
		.diff(src(o0)
			.scale(1.01)))
	.out();
screencap();