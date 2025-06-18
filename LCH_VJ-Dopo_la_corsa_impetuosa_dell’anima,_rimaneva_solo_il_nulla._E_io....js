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
xsin = "sin(st.x/time*10.0)";
ysin = "sin(st.y/time*10.0)";
xcos = "cos(st.x/time*10.0)";
ycos = "cos(st.y/time*10.0)";
setResolution(1280, 1280);
blade(ysin, xcos)
	.blend(o0, 9 / 10)
	.modulate(src(o0)
		.modulateRotate(src(o0)
			.modulateScale(o0, ysin, xcos), xsin, ycos), xsin, ycos)
	.out();