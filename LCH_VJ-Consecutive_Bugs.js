setResolution(1280, 1280);
solid()
	.add(osc(1, 0, 0)
		.mult(solid(0, 0, 1))
		.diff(osc(100, 0, 0)
			.mult(solid(0, 0, 1))
			.rotate(Math.PI))
		.pixelate(10, 10))
	.add(osc(1, 0, 0)
		.mult(solid(0, 1, 1))
		.diff(osc(100, 0, 0)
			.mult(solid(0, 1, 1))
			.rotate(Math.PI / 2))
		.pixelate(20, 20))
	.rotate(Math.PI / 2 * 3)
	.out();
screencap();