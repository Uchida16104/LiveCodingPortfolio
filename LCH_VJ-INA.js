setResolution(1600, 1600);

function synth(n, k) {
	return gradient()
		.modulateRotate(src(o0)
			.hue("cos(st.x)+sin(st.y)+(time/5.0)")
			.rotate(Math.PI / 2)
			.scale(n))
		.hue("cos(st.y)+sin(st.x)+(time/5.0)")
		.rotate(Math.PI / 2)
		.scale(k)
		.modulatePixelate(src(o0)
			.repeat(5, 5), 10, 10)
		.modulate(src(o0)
			.modulateScale(src(o0)
				.modulateRotate(o0)))
		.blend(o0, k);
}

synth(.5, .9)
	.out();