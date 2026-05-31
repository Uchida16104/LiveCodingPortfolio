rate = 11 / 10;
min = 0;
max = 200;
med = () => (min + max) / 2;
frame = () => shape(4)
	.colorama(1)
	.hue(1 / 2);
solid()
	.add(o1)
	.add(o2)
	.hue("st.x+st.y")
	.modulatePixelate(osc(1, 0)
		.repeat(), [min, max].smooth()
		.fast(1 / med), [min, max].smooth()
		.fast(1 / med))
	.out();
frame()
	.diff(src(o1)
		.scale(2 - rate))
	.out(o1);
frame()
	.diff(src(o2)
		.scale(rate))
	.out(o2);
