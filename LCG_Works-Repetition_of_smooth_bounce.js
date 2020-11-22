//Repetition of smooth bounce

bd=XOX('x...x...x...x...');

hc=XOX('****************');

sn=XOX('..o...o...o...o.');

ho=XOX('..........-.....');

lt=Tom( {amp:.5} ).play(80, 1/8 );

ht=Tom( {amp:.5} ).play(160, 1/4 );

cb=Cowbell( {amp:.25} ).play( 44100, 1/2 );

cl=Clave( {amp:.75} ).play( 1764, 1/16 );

cg=Conga( {amp:.5} ).play( 320, 1/8 );

b = FM('bass', {amp:.65} )
  .note.seq( [0,1,1,2,3,5,8,13].rnd(), [1/4,1/8,1/16,1/32].rnd(1/16,2) );

r = Synth( 'rhodes', {amp:.35} )
  .chord.seq( Rndi(2,3,5,7), 1 )
  .fx.add( Delay() );

Gibber.scale.root.seq( ['f#3', 'g3', 'g#3', 'a3', 'bb3', 'b3', 'c4', 'c#4', 'd4', 'eb4', 'e4', 'f4', 'f#4', 'g4', 'g#4', 'a4', 'bb4', 'b4', 'c5', 'c#5', 'd5', 'eb5', 'e5', 'f5'].random(), [8,4,4,2,2,2,2] );
Gibber.scale.mode.seq( ['Ionian', 'Dorian', 'Phrygian', 'Lydian', 'Mixolydian', 'Aeolian', 'Locrian', 'MajorPentatonic', 'MinorPentatonic', 'Chromatic', 'Adams', 'Just', 'HalfWhole', 'WholeHalf', 'Equal5Tone', 'Equal7Tone', 'Mess3', 'Mess4', 'Mess5', 'Mess6', 'Mess7', 'Pythagorean'].random(), Rndi(22) );

s = SoundFont( 'string_ensemble_1', {amp:.3} )
  .chord.seq( Rndi(3,5,7,11), 2 )
  .fx.add( Delay() );

Gibber.scale.root.seq( ['f#3', 'g3', 'g#3', 'a3', 'bb3', 'b3', 'c4', 'c#4', 'd4', 'eb4', 'e4', 'f4', 'f#4', 'g4', 'g#4', 'a4', 'bb4', 'b4', 'c5', 'c#5', 'd5', 'eb5', 'e5', 'f5'].random(), [4,4,2,2,2,2,8] );
Gibber.scale.mode.seq( ['Ionian', 'Dorian', 'Phrygian', 'Lydian', 'Mixolydian', 'Aeolian', 'Locrian', 'MajorPentatonic', 'MinorPentatonic', 'Chromatic', 'Adams', 'Just', 'HalfWhole', 'WholeHalf', 'Equal5Tone', 'Equal7Tone', 'Mess3', 'Mess4', 'Mess5', 'Mess6', 'Mess7', 'Pythagorean'].random(), Rndi(22) );

m = SoundFont( 'marimba', {amp:.75} )
  .note.seq( [1,1,2,3,5,8,13,21].rnd(), [1/4,1/8].rnd(2,2) );

p = SoundFont( 'acoustic_grand_piano', {amp:.25} )
  .note.seq( [1,1,2,3,5,8,13,21].rnd(), [1,1/2].rnd(1,4) );
