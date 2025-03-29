SynthDef("woodwind", {
    arg out_bus = 0, note = 60, amp = 1, attack = 0.01, release = 1.0, pan = 0;
    var freq, mix, env;
    freq = note.midicps;
    mix = SinOsc.ar(freq, 0) * amp;
    env = EnvGen.ar(Env.perc(attack, release, 1.0), doneAction: 2);
    mix = mix * env;
    mix = Pan2.ar(mix, pan);
    Out.ar(out_bus, mix);
}).writeDefFile("/path/to/SynthFX/woodwind");
SynthDef("brass", {
    arg out_bus = 0, note = 60, amp = 1, attack = 0.01, release = 1.0, pan = 0;
    var freq, mix, env;
    freq = note.midicps;
    mix = Pulse.ar(freq, 0.5) * amp;
    env = EnvGen.ar(Env.perc(attack, release, 1.0), doneAction: 2);
    mix = mix * env;
    mix = Pan2.ar(mix, pan);
    Out.ar(out_bus, mix);
}).writeDefFile("/path/to/SynthFX/brass");
SynthDef("strings", {
    arg out_bus = 0, note = 60, amp = 1, attack = 0.01, release = 1.0, pan = 0;
    var freq, mix, env;
    freq = note.midicps;
    mix = Saw.ar(freq) * amp;
    env = EnvGen.ar(Env.perc(attack, release, 1.0), doneAction: 2);
    mix = mix * env;
    mix = Pan2.ar(mix, pan);
    Out.ar(out_bus, mix);
}).writeDefFile("/path/to/SynthFX/strings");
SynthDef("percussion", {
    arg out_bus = 0, amp = 1, attack = 0.01, release = 1.0, pan = 0;
    var mix, env;
    mix = WhiteNoise.ar * amp;
    env = EnvGen.ar(Env.perc(attack, release, 1.0), doneAction: 2);
    mix = mix * env;
    mix = Pan2.ar(mix, pan);
    Out.ar(out_bus, mix);
}).writeDefFile("/path/to/SynthFX/percussion");