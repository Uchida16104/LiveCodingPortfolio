SynthDef("prepared_piano", {
    arg out_bus = 0, note = 60, amp = 1, attack = 0.01, release = 1.0, pan = 0;
    var freq, mix, env, noise, filter;
    freq = note.midicps;
    mix = SinOsc.ar(freq, 0, amp);
    noise = WhiteNoise.ar(amp * 0.2);
    filter = RLPF.ar(noise, freq * 1.5, 0.1);
    mix = mix + filter;
    env = EnvGen.ar(Env.perc(attack, release, 1.0), doneAction: 2);
    mix = mix * env;
    mix = Pan2.ar(mix, pan);
    Out.ar(out_bus, mix);
}).writeDefFile("/path/to/SynthFX/prepared_piano");
