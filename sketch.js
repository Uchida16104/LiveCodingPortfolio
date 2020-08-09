let polySynth, playing, freq, amp;
function setup() {
  let cnv = createCanvas(400,400,WEBGL);
  detailX = createSlider(0,180);
  detailY = createSlider(0,360);
  detailZ = createSlider(0,540);
  mic = new p5.AudioIn();
  mic.start();
  fft = new p5.FFT();
  fft.setInput(mic);
  cnv.mousePressed(playSynth);
  polySynth = new p5.PolySynth();
  osc = new p5.Oscillator('sine');
  capture = createCapture(VIDEO);
  capture.size(400,400);
  //capture.hide();
}

function differ(){
if (mouseX - mouseY > 0){
mouseX - mouseY
}  else if (mouseX - mouseY < 0){
mouseY - mouseX
}
}

function draw() {
  background(detailX.value(),detailY.value(),detailZ.value());
  let spectrum = fft.analyze();
  freq = constrain(map(mouseX, 0, width, 100, 500), 100, 500);
  amp = constrain(map(mouseY, height, 0, 0, 1), 0, 1);
  micLevel = mic.getLevel();
  noStroke();
  fill(255, 0, 255);
  for (let i = 0; i< spectrum.length; i++){
    let x = map(i, 0, spectrum.length, 0, width);
    let h = -height + map(spectrum[i], 0, 255, height, 0);
    rect(x, height, width / spectrum.length, h );
  }
  
  if (playing) {
    // smooth the transitions by 0.1 seconds
    polySynth.freq(freq, 0.1);
    polySynth.amp(amp, 0.1);
  }
  noStroke();
colorMode(RGB, 100);
for (let i = 0; i < 10; i++) {
  for (let j = 0; j < 10; j++) {
    stroke(mouseX + detailX.value(), mouseY + detailY.value(), differ + detailZ.value());
  translate(mouseX - 200,mouseY - 200);
  shearX(mouseX * 0.01);
  shearY(mouseY * 0.01);
  rotateX(mouseX);
  rotateY(mouseY);
  torus(mouseX * 0.0156125, mouseY * 0.015625);
   }
  }
}

function playSynth() {
  userStartAudio();

  // note duration (in seconds)
  let dur = detailX.value() * 0.05;

  // time from now (in seconds)
  let time = detailY.value() * 0.05;

  // velocity (volume, from 0 to 1)
  let vel = detailZ.value() * 0.05;

  // notes can overlap with each other
  polySynth.play(freq - 100, vel + amp, time += 1/2, dur);
  polySynth.play(freq, vel + amp, time += 1/2, dur);
  polySynth.play(freq + 100, vel + amp, time += 1/2, dur);
}

function mouseReleased() {
  // ramp amplitude to 0 over 0.5 seconds
  osc.amp(0, 0.5);
  playing = false;
}