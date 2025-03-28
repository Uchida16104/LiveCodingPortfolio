await loadScript("https://nodegl.glitch.me/function-list.js");
setResolution(1280, 1280);
osc(60, 0)
	.kaleid(99)
	.pixelate(60, 60)
	.thresh()
	.mult(visual()
		.polar())
	.invert(0)
	.out();
screencap();