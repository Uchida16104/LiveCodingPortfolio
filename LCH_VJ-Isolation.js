setResolution(1280, 1280);
const oscNode = osc(1, 2, 300);
const gradShader = gradient(1);
let s = solid();
for (let i = 1; i <= 10; i++) {
	const r = 0.1 * i;
	const baseScale = [i / 5, i / 10]
		.reverse()
		.smooth()
		.ease('easeInOutHalf')
		.fit(1 / 3)
		.offset(1 / 4)
		.fast(1 / 5);
	const baseRepeat = [i / 5, i / 10]
		.reverse()
		.smooth()
		.ease('easeInOut')
		.fit(1 / 2)
		.offset(1 / 3)
		.fast(1 / 4);
	const scrollX = [r, r + 0.5]
		.reverse()
		.smooth()
		.ease('easeInOutQuart')
		.fit(1 / 5)
		.offset(1 / 6)
		.fast(1 / 7);
	const scrollY = [r, r + 0.5]
		.reverse()
		.smooth()
		.ease('easeInOutQuint')
		.fit(1 / 6)
		.offset(1 / 7)
		.fast(1 / 8);
	const shapeLayer = shape(2, 0.1)
		.rotate(r, r)
		.scale("st.x", 1 / 4)
		.scale([0, 5].reverse()
			.smooth()
			.ease('easeInOutCubic')
			.fit(1 / 4)
			.offset(1 / 5)
			.fast(1 / 6))
		.mult(oscNode.diff(gradShader))
		.hue(r)
		.scroll(scrollX, scrollY);
	s = s
		.diff(shapeLayer)
		.repeat(baseRepeat, baseRepeat)
		.scale(baseScale, baseScale);
}
s.blend(o0, 0.9)
	.out();