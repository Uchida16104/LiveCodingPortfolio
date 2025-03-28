await loadScript("https://nodegl.glitch.me/function-list.js");
setResolution(1280, 1280);
shape(99, 0, 1)
	.colorama(2)
	.hue("cos(st.x)+sin(st.y)")
	.diff(osc(10, 0)
		.kaleid(99)
		.r(3))
	.diff(chaos())
	.diff(osc()
		.swirl(Math.PI * 4))
	.invert()
	.add(shape(99, 1 / 2, 1 / 40))
	.scale(4 / 5)
.blend(o0,.925)
	.out();
screencap();