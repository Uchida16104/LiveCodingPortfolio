setResolution(1280, 1280);
await loadScript("https://nodegl.glitch.me/function-list.js");
solid()
	.add(
		parametriclaser("cos(time)*cos(2.0*time)+cos(3.0*time)","sin(time)*sin(2.0*time)+sin(3.0*time)", 100, 0.5, "sin(time)", "sin(time)*cos(time)", "cos(time)"))
	.scale(1)
	.hue()
	.saturate()
.scale(.5)
	.add(o0)
	.out();
screencap();