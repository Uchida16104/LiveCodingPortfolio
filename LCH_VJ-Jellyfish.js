await loadScript("https://nodegl.glitch.me/function-list.js");
setResolution(1280, 1280);
shape(99, 0, 1)
	.colorama(2)
	.hue("cos(st.x)+sin(st.y)")
	.diff(osc(10, 0)
		.kaleid(99)
		.r(3))
	.invert()
	.scale(4 / 5)
	.out();
screencap();