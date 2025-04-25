await loadScript("https://nodegl.glitch.me/function-list.js");
src(o0)
	.modulateShear(src(o0)
		.scale(1.01))
	.layer(flower()
		.sub(lissajous()
			.laser()
			.mask(lissajouslaser())))
	.add(visual()
		.diff(huecircle()
			.mult(chaos())))
	.invert()
.blend(o0,9/10)
	.out();
screencap();