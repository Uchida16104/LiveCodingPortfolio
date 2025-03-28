
await loadScript("https://nodegl.glitch.me/function-list.js");
setResolution(1280, 1280);
src(o0)
	.laser()
	.modulateGlitch(src(o0)
		.swirl())
	.layer(visual()
		.sub(huecircle()
			.mask(o1)))
	.out();
src(o1)
	.oil()
	.modulateWarp(src(o1)
		.polar())
	.layer(lightning()
		.sub(beam()
			.mask(o2)))
	.out(o1);
src(o2)
	.watercolor()
	.modulateSpiral(src(o2)
		.shake())
	.layer(chaos()
		.sub(lissajous()
			.mask(o3)))
	.out(o2);
src(o3)
	.ink()
	.modulateShear(src(o3)
		.crystal())
	.layer(lissajouslaser()
		.sub(sphere()
			.mask(o0)))
	.out(o3);
render(o3);
screencap();