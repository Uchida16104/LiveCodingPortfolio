await loadScript("https://nodegl.glitch.me/function-list.js");
setResolution(1280, 1280);
osc(60, 0)
	.swirl(10)
	.pixelate(60, 60)
	.thresh()
	.mult(huecircle())
	.invert()
	.out();
screencap();