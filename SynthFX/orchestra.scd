SynthDef("orchestra", {
    arg out_bus = 0, amp = 1.0, startPos = 0;
    var sig, buf;
    buf = Buffer.read(s, "/path/to/SynthFX/orchestra/140bpmC#minor.wav");
    sig = PlayBuf.ar(2, buf, BufRateScale.kr(buf), startPos: startPos, doneAction: 2);
    sig = sig * amp;
    Out.ar(out_bus, sig);
}).writeDefFile("/path/to/SynthFX/orchestra/");
SynthDef("vocoder", {
    arg out_bus = 0, in_bus = 0, note = 60, amp = 1.0, attack = 0.01, release = 1.0;
    var source, carrier, fft1, fft2, chain, mix, env;
    source = In.ar(in_bus, 1);
    carrier = LFSaw.ar(note.midicps, 0, 0.5);
    fft1 = FFT(LocalBuf(1024, 1), carrier, wintype: 1);
    fft2 = FFT(LocalBuf(1024, 1), source, wintype: 1);
    chain = PV_MagMul(fft1, fft2);
    mix = IFFT(chain);
    env = EnvGen.ar(Env.perc(attack, release, amp), doneAction: 2);
    mix = mix * env;
    Out.ar(out_bus, mix);
}).writeDefFile("/path/to/SynthFX/vocoder");