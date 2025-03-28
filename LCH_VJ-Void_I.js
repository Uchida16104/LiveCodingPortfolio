setResolution(1280, 1280);
await loadScript("https://nodegl.glitch.me/function-list.js");
solid()
	.add(
		parametriclaser("cos(2.0*time)*cos(time)", "cos(2.0*time)*sin(time)", 100, 0.5, "sin(time)", "sin(time)-cos(time)", "cos(time)"))
	.add(
		parametriclaser("cos(4.0*time)*cos(time)", "cos(4.0*time)*sin(time)", 100, 0.5, "sin(time)*sin(time)", "cos(time)-sin(time)", "cos(time)*cos(time)"))
	.add(
		parametriclaser("cos(6.0*time)*cos(time)", "cos(6.0*time)*sin(time)", 100, 0.5, "sin(time)*cos(time)", "cos(time)*sin(time)", "cos(time)*sin(time)"))
	.add(
		parametriclaser("cos(8.0*time)*cos(time)", "cos(8.0*time)*sin(time)", 100, 0.5, "cos(time)*cos(time)", "cos(time)/sin(time)", "sin(time)*sin(time)"))
	.add(
		parametriclaser("cos(10.0*time)*cos(time)", "cos(10.0*time)*sin(time)", 100, 0.5, "cos(time)", "sin(time)/cos(time)", "sin(time)"))
	.scale(1)
	.hue()
	.saturate()
	.add(o0)
	.out();
screencap();