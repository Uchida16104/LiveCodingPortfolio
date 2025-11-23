await loadScript("https://unpkg.com/hydra-nodegl");
setResolution(1600, 1600);
solid(0, "sin(st.y)", "cos(st.x)")
	.rotate(Math.PI)
	.diff(visual()
		.polar())
	.diff(osc(10, 0, 300)
		.kaleid(99))
	.diff(gradient()
		.swirl())
	.diff(huecircle())
	.hue()
	.blend(solid(0, 1, 1))
	.modulateSpiral(o0, 5)
	.modulate(o0, .9)
	.blend(o0, .9)
	.out();
screencap();