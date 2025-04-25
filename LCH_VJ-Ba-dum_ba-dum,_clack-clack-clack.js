setResolution(1280, 1280);
await loadScript("https://nodegl.glitch.me/function-list.js");
let basePattern = () => {
	let layers = Math.random(time) * 10;
	let result = null;
	for (let i = 0; i < layers; i++) {
		let size = Math.random() * 0.9 + 0.1;
		let xPos = Math.random();
		let yPos = Math.random();
		let rotation = Math.random() * Math.PI * 2;
		s0.initCam()
		let shapePattern = shape(4)
			.mult(src(s0)
				.scroll(xPos, yPos))
			.scale(size)
			.scroll(xPos, yPos);
		if (result === null) {
			result = shapePattern;
		} else {
			result = result.add(shapePattern);
		}
	}
	return result;
}
synth = () => solid().diff(zebra(repeatoperator("modulatePixelate", () => src(o0)
		.rotate(Math.PI / 2)
		.scale(1.01), 1, osc(1)
		.mult(src(s0).laser().oil().watercolor().ink().painting(6.0, 0.2, 0.8, 0.4, 0.6, 2.0, 0.4, 0.4, 1.0, 1.5, 0.3, 0.2, 0.6, 0.3)
.over(2, 0, 50, 0)
.sketch(1, 1 / 100, 1 / 4, 1 / 4)
	.modulateScrollX(shape(2)
		.repeatY(1), () => Math.random(time / -2) / 10)
	.modulateScrollY(osc(6, -1 / 8)
		.luma()
		.thresh()
		.repeatX(2), () => Math.random(time / -3) / 10)
	.modulateScrollX(shape(2)
		.repeatY(3), () => Math.random(time / 4) / 10)
	.modulateScrollY(osc(6, 1 / 8)
		.luma()
		.thresh()
		.repeatX(4), () => Math.random(time / 5) / 10)
	.modulateScrollX(shape(2)
		.repeatY(5), () => Math.random(time / -6) / 10)
	.modulateScrollY(osc(6, -1 / 8)
		.luma()
		.thresh()
		.repeatX(6), () => Math.random(time / -7) / 10)
	.modulateScrollX(shape(2)
		.repeatY(7), () => Math.random(time / 8) / 10)
	.modulateScrollY(osc(6, 1 / 8)
		.luma()
		.thresh()
		.repeatX(8), () => Math.random(time / 9) / 10))).hue("sin(st.x/time)+cos(st.y/time)")
	.saturate("sin(st.y/time)-cos(st.x/time)")
	.brightness("cos(st.y/time)*sin(st.x/time)")
	.contrast("sin(st.y/time)+cos(st.x/time)"), 2, 4, Math.sin, 0.1));
basePattern()
	.layer(shape(4, 1)
		.mask(synth()
			.invert([0, 1 / 4, 1 / 2, 3 / 4, 1].reverse()
				.ease(() => Math.random(time / 11) / 11)
				.smooth(1 / 7)
				.fit(1 / 5)
				.offset(1 / 3)
				.fast(1 / 2))
			.luma()
			.shift("cos(st.x/time)-sin(st.y/time)")
			.posterize(Math.PI, Math.E)
			.hue("sin(st.x/time)+cos(st.y/time)")
			.saturate(Math.E / Math.PI)
			.brightness("cos(st.y/time)*sin(st.x/time)")
			.contrast(Math.PI)))
	.color("st.x*st.y", "st.x/st.y", "st.y/st.x")
.modulateGlitch(o0).invert().hue("cos(st.x/time)/sin(st.y/time)")
	.out();
screencap();