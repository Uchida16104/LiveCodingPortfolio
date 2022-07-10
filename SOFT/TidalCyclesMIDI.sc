SuperDirt.start;
MIDIClient.init;
(
~midiOut1 = MIDIOut.newByName("IACDriver", "Bus1");
~dirt.soundLibrary.addMIDI(\midi1, ~midiOut1);
~midiOut2 = MIDIOut.newByName("IACDriver", "Bus2");
~dirt.soundLibrary.addMIDI(\midi2, ~midiOut2);
~midiOut3 = MIDIOut.newByName("IACDriver", "Bus3");
~dirt.soundLibrary.addMIDI(\midi3, ~midiOut3);
~midiOut4 = MIDIOut.newByName("IACDriver", "Bus4");
~dirt.soundLibrary.addMIDI(\midi4, ~midiOut4);
~midiOut5 = MIDIOut.newByName("IACDriver", "Bus5");
~dirt.soundLibrary.addMIDI(\midi5, ~midiOut5);
~midiOut6 = MIDIOut.newByName("IACDriver", "Bus6");
~dirt.soundLibrary.addMIDI(\midi6, ~midiOut6);
~midiOut7 = MIDIOut.newByName("IACDriver", "Bus7");
~dirt.soundLibrary.addMIDI(\midi7, ~midiOut7);
~midiOut8 = MIDIOut.newByName("IACDriver", "Bus8");
~dirt.soundLibrary.addMIDI(\midi8, ~midiOut8);
~midiOut9 = MIDIOut.newByName("IACDriver", "Bus9");
~dirt.soundLibrary.addMIDI(\midi9, ~midiOut9);
~midiOut10 = MIDIOut.newByName("IACDriver", "Bus10");
~dirt.soundLibrary.addMIDI(\midi10, ~midiOut10);
~midiOut11 = MIDIOut.newByName("IACDriver", "Bus11");
~dirt.soundLibrary.addMIDI(\midi11, ~midiOut11);
~midiOut12 = MIDIOut.newByName("IACDriver", "Bus12");
~dirt.soundLibrary.addMIDI(\midi12, ~midiOut12);
~midiOut13 = MIDIOut.newByName("IACDriver", "Bus13");
~dirt.soundLibrary.addMIDI(\midi13, ~midiOut13);
~midiOut14 = MIDIOut.newByName("IACDriver", "Bus14");
~dirt.soundLibrary.addMIDI(\midi14, ~midiOut14);
~midiOut15 = MIDIOut.newByName("IACDriver", "Bus15");
~dirt.soundLibrary.addMIDI(\midi15, ~midiOut15);
~midiOut16 = MIDIOut.newByName("IACDriver", "Bus16");
~dirt.soundLibrary.addMIDI(\midi16, ~midiOut16);
);
(
var on, off, cc;
var osc;

osc = NetAddr.new("127.0.0.1", 6010);

MIDIClient.init;
MIDIIn.connectAll;

on = MIDIFunc.noteOn({ |val, num, chan, src|
    osc.sendMsg("/ctrl", num.asString, val/127);
});

off = MIDIFunc.noteOff({ |val, num, chan, src|
    osc.sendMsg("/ctrl", num.asString, 0);
});

cc = MIDIFunc.cc({ |val, num, chan, src|
    osc.sendMsg("/ctrl", num.asString, val/127);
});

if (~stopMidiToOsc != nil, {
    ~stopMidiToOsc.value;
});

~stopMidiToOsc = {
    on.free;
    off.free;
    cc.free;
};
)
~stopMidiToOsc.value;