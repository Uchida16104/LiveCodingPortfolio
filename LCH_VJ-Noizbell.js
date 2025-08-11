await loadScript("https://unpkg.com/hydra-nodegl");
setResolution(1600,1600);
planet = () => gradient(1)
	.polar()
	.diff(visual()
		.modulateSpiral(o0))
	.diff(osc(10, 1 / 8, 300)
		.swirl(10))
	.diff(huecircle())
	.scale(1, 1 / 2)
	.mult(shape(99, 0, 1)
		.scale(1, 1 / 2));
solid()
	.add(planet())
	.blend(planet()
		.scrollX()
		.scrollY()
		.scale(1 / 2))
	.blend(src(o0)
		.repeat(4, 4)
		.hue("cos(st.x+time)-sin(st.y+time)")
		.brightness(1 / 10)
		.contrast(6 / 5)
		.shift("cos(st.x/time)", "sin(st.y/time)", "sin(st.x/time)", "cos(st.y/time)"),"cos(st.x-time)+sin(st.y-time)+0.5")
	.out();
screencap();