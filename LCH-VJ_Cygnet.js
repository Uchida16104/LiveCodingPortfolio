await loadScript("https://unpkg.com/hydra-nodegl");
setResolution(1600, 1600);
s0.initImage("https://upload.wikimedia.org/wikipedia/commons/b/bb/SwansCygnus_olor.jpg");
synth = () => src(s0)
	//.painting(6.0, 0.2, 0.8, 0.4, 0.6, 2.0, 0.4, 0.4, 1.0, 1.5, 0.3, 0.2, 0.6, 0.3)
	//.over(2, 0, 50, 0)
	//.sketch(1, 1 / 100, 1 / 4, 1 / 4)
	.watercolor()
	.oil()
//.ink()
synth()
	.disassemble()
	.out(o0);
synth()
	.pixelate(225, 225)
	.out(o1);
synth()
	.split()
	.out(o2);
synth()
	.diff(src(o3)
		.hue("cos(st.x)+sin(st.y)")
		.shift())
	.invert()
	.out(o3);
render();
screencap();