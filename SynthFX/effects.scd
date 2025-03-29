SynthDef("chorus", {
    arg out_bus = 0, in_bus = 0, amp = 1.0, depth = 0.5, rate = 0.3;
    var input, mix, chorus;
    input = In.ar(in_bus, 1);
    chorus = CombL.ar(input, 0.1, rate, depth);
    mix = chorus * amp;
    Out.ar(out_bus, mix);
}).writeDefFile("/path/to/SynthFX/chorus");
SynthDef("reverse", {
    arg out_bus = 0, in_bus = 0, amp = 1.0, bufnum;
    var input, buf, playbuf, env;
    buf = LocalBuf(1024);
    input = In.ar(in_bus, 1);
    RecordBuf.ar(input, buf, loop: 1);
    playbuf = PlayBuf.ar(1, buf, BufRateScale.kr(buf) * -1, loop: 1);
    env = EnvGen.ar(Env.perc(0.01, 1.0), doneAction: 2);
    Out.ar(out_bus, playbuf * amp * env);
}).writeDefFile("/path/to/SynthFX/reverse");
SynthDef("glitch", {
    arg out_bus = 0, in_bus = 0, amp = 1.0;
    var input, mix, delay;
    input = In.ar(in_bus, 1);
    delay = DelayN.ar(input, 0.05, 0.05);
    mix = input + delay * amp;
    Out.ar(out_bus, mix);
}).writeDefFile("/path/to/SynthFX/glitch");
