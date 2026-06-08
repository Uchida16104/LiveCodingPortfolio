speed=10
setResolution(1600, 1600);
osc("st.x*0.1", 1, 300)
	.diff(osc("st.y*0.1", 1, 300))
	.diff(osc("(st.x+st.y)*0.1", 1, 300))
	.invert()
	.rotate(Math.PI / 4)
	.blend(o0, 99 / 100)
	.out();
screencap();