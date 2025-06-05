function blade(s, t) {
	var origin = (s, t) => shape([3, 5].reverse()
			.smooth(1 / 2)
			.ease('easeInOutCubic')
			.fit(1 / 4)
			.offset(1 / 5)
			.fast(1 / 6))
		.rotate(s, s)
		.scale(t, t)
		.mult(osc(s, t, 300)
			.diff(gradient(s))
			.diff(solid(t, s, t, s))
			.hue(t));
	return origin(s, t);
}
setResolution(1280, 1280);
blade(() => Math.sin(time / 10), () => Math.cos(time / 10))
	.blend(o0, 9 / 10)
	.modulate(src(o0)
		.modulateRotate(src(o0)
			.modulateScale(o0)))
	.out();