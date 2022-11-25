// licensed with CC BY-NC-SA 4.0 https://creativecommons.org/licenses/by-nc-sa/4.0/
p5 = new P5({
	mode: 'WEBGL'
})

p5.hide();
s0.init({
	src: p5.canvas
})

p5.draw = () => {
	p5.background(0);
	p5.rotateX(time / -10);
	p5.rotateY(time / -10);
	p5.box(50);
}

var plane = function(p, q) {
	return shape(4, "st.y+st.y", p)
		.scale(1 / 2 + p)
		.rotate(1 / 10, 1 / 10)
		.scale(q);
}

function modulator(name0, name1, a, b, c, d, e, f) {
	if (name0 === Math.atan2 || name0 === Math.hypot || name0 === Math.imul || name0 === Math.max || name0 === Math.min || name0 === Math.pow) {
		func0 = (a, f) => name0(time / a, time % f);
		func1 = (e) => name1(time % e);
		func2 = (a, b, c, d, e, f) => func0(a, f) ** b > c ? d : -func1(e);
		return () => func2(a, b, c, d, e, f);
	} else if (name1 === Math.atan2 || name1 === Math.hypot || name1 === Math.imul || name1 === Math.max || name1 === Math.min || name1 === Math.pow) {
		func0 = (a) => name0(time / a);
		func1 = (e, f) => name1(time % e, time / f);
		func2 = (a, b, c, d, e, f) => func0(a) ** b > c ? d : -func1(e, f);
		return () => func2(a, b, c, d, e, f);
	} else {
		func0 = (a) => name0(time / a);
		func1 = (e) => name1(time % e);
		func2 = (a, b, c, d, e) => func0(a) ** b > c ? d : -func1(e);
		return () => func2(a, b, c, d, e);
	}
};

function delta(w0, w1) {
	return solid("st.x", "st.y", () => Math.sin(time * w0))
		.diff(gradient(w1));
}

function frame(r, s, t, u, v, w0, w1) {
	return osc(r, s, t)
		.diff(delta(w0, w1))
		.kaleid(u)
		.rotate(Math.PI / u)
		.scale("st.y")
		.rotate(v, v);
}

synth = () => plane(1 / 4, 1 / 2)

function convert(geo) {
	if (geo === "x0") {
		return "st.x+st.x";
	} else if (geo === "x1") {
		return "st.x*st.x";
	} else if (geo === "y0") {
		return "st.y+st.y";
	} else if (geo === "y1") {
		return "st.y*st.y";
	} else if (geo === "z0") {
		return "st.x+st.y";
	} else if (geo === "z1") {
		return "st.x*st.y";
	};
};

var transition = function(axis, size, slow) {
	if (axis === "x0") {
		return synth()
			.scale(convert(axis), window.innerWidth / window.innerHeight / size)
			.diff(s0)
			.mult(frame(10, 1 / 8, modulator(Math.sin, Math.tan, 10, 2, 1, 2, 10), 4, 1 / 10, 2, 1))
			.scrollX(() => (time / slow))
			.modulateScale(osc(Math.PI + Math.E, -1 / 8));
	} else if (axis === "x1") {
		return synth()
			.scale(convert(axis), window.innerWidth / window.innerHeight / size)
			.diff(s0)
			.mult(frame(10, 1 / 8, modulator(Math.sin, Math.tan, 10, 2, 1, 2, 10), 4, 1 / 10, 2, 1))
			.scrollX(() => (time / -slow))
			.modulateScale(osc(Math.PI + Math.E, 1 / 8));
	} else if (axis === "y0") {
		return synth()
			.scale(convert(axis), window.innerWidth / window.innerHeight / size)
			.diff(s0)
			.mult(frame(10, 1 / 8, modulator(Math.sin, Math.tan, 10, 2, 1, 2, 10), 4, 1 / 10, 2, 1))
			.scrollY(() => (time / slow))
			.modulateScale(osc(Math.PI + Math.E, 1 / 8)
				.rotate(Math.PI / -2));
	} else if (axis === "y1") {
		return synth()
			.scale(convert(axis), window.innerWidth / window.innerHeight / size)
			.diff(s0)
			.mult(frame(10, 1 / 8, modulator(Math.sin, Math.tan, 10, 2, 1, 2, 10), 4, 1 / 10, 2, 1))
			.scrollY(() => (time / -slow))
			.modulateScale(osc(Math.PI + Math.E, 1 / 8)
				.rotate(Math.PI / 2));
	} else if (axis === "z0") {
		return synth()
			.scale(convert(axis), window.innerWidth / window.innerHeight / size)
			.diff(s0)
			.mult(frame(10, 1 / 8, modulator(Math.sin, Math.tan, 10, 2, 1, 2, 10), 4, 1 / 10, 2, 1))
			.scroll(() => (time / slow), () => (time / slow))
			.modulateScale(osc(Math.PI + Math.E, 1 / 8)
				.rotate(Math.PI / -4));
	} else if (axis === "z1") {
		return synth()
			.scale(convert(axis), window.innerWidth / window.innerHeight / size)
			.diff(s0)
			.mult(frame(10, 1 / 8, modulator(Math.sin, Math.tan, 10, 2, 1, 2, 10), 4, 1 / 10, 2, 1))
			.scroll(() => (time / -slow), () => (time / -slow))
			.modulateScale(osc(Math.PI + Math.E, 1 / 8)
				.rotate(Math.PI / 4));
	};
};

pad = (g) => solid()
	.diff(src(o0)
		.pixelate(g, g)
		.mult(shape(4, 0, 1)
			.repeat(g, g)
			.invert())
		.diff(src(o0)
			.scale(.99)
			.diff(src(o0)
				.scale(1.01))));

transition("z1", 5, 10)
	.add(pad(10))
	.blend(o0, [0, 1 / 8].reverse()
		.ease('linear')
		.fit(3 / 8)
		.offset(2 / 5)
		.fast(1 / 4))
	.out();
