//This is the first work I made and arrange from a template on gibber.
"https://gibber.cc/?path=Hirotoshi%20Uchida/publications/Lesson%20-Arrange%20from%20template-"

Gibber.clear();
c = SoundFont( 'string_ensemble_1' );

d = Arp( 'db4dim', 1/8, 'updown', 4 );
d.target = c;

d.speed = 1/32;

d.chord( 'a#3Maj7' );

d.chord.seq( ['f3M9b5', 'g3aug'], 1);

s = Synth({ attack:ms(10), decay:ms(50) })
	.note.seq( [0,1,5,3,0,6,7,-5], 1/16 );
 
ss = Synth({ attack:ms(10), decay:ms(50) })
	.note.seq( [0,4,3,6,4,5,9,-3], 1/16 );

q = Bus().fx.add( Reverb() );
s.send( q, .5 );
ss.send( q, .5 );

Gibber.scale.mode = 'Phrygian';

Gibber.scale.root = 'c5';

s.scale = Scale('c4','MinorPentatonic');

t = XOX( 'x.o.*.oox.o.*.oo', 1/16 );

u = Drums( '****************', 1/16);

v = Drums('........-.--.--.', 1/16);

fftSize = 32;
fft = FFT( fftSize );

a = Canvas();

a.draw = function() {
  a.clear()
  var numBars = fftSize / 2,
      barHeight = ( a.height - 1 ) / numBars,
      barColor = null, 
      value = null

  for( var i = 0; i < numBars; i++ ) {
    barColor = Color({ h:( i / numBars ) * 255, s:255, v:255 })

    value = ( fft[ i ] / 255 ) * a.width

    a.rectangle( 0, barHeight * i, value, barHeight )
    a.fill( barColor.rgbString() ) 

  }
};
