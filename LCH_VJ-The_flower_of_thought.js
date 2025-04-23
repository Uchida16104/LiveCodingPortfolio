await loadScript("https://nodegl.glitch.me/function-list.js");
//setLoop(-1 / 2, 1 / 4, -1 / 8, 1 / 16, Math.random() * 1000);
synth = () => repeatoperator("modulatePixelate", () => chaos(16), 8, src(o0)
	.echo()
	.chorus()
	.vibrato()
	.ringModulate()
	.modulateRingModulator(o0))
	.layer(osc(60, 1 / 8, 300)
           .polar()
		.modulateWarp(solid(), 0.3)
		.modulateSpiral(o0, 2)
           .swirl(10)
           .crystal()
		.mult(sphere()
			.mask(beam().kaleid(99)
				.laser())))
	.diff(s0)
	.blend(o0);
synth()
	.disassemble()
	.out(o0);
delay(solid(), synth(), Math.random() * 10000, o1)
	.out(o1);
synth()
	.split()
	.out(o2);
delay(solid(), synth(), Math.random() * 10000, o3)
	.out(o3);
render();
screencap();