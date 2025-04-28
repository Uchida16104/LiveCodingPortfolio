// code hydra [+/-] p5 or drag + drop .js hydra/p5 file(s) here
// p5 » hydra - typo rays
// pass p5 typography into hydra
// cc teddavis.org 2024
// https://hy5live.teddavis.org/

s0.initP5() // send p5 to hydra
P5.toggle(0) // hide p5

H.pixelDensity(2) // set res
setResolution(1280, 1280);
src(s0).mult(osc(1,2,300).diff(solid("sin(st.x/time)+sin(st.y/time)","sin(st.y/time)+cos(st.x/time)","cos(st.x/time)+cos(st.y/time)").hue("cos(st.x/time)+sin(st.y/time)").sub(gradient(1).luma()))).out();;

let cols, rows;
let symbolSize = 20;
let streams = [];

function setup() {
  createCanvas(windowWidth, windowHeight);
  background(0);
  cols = floor(width / symbolSize);
  rows = floor(height / symbolSize);
  textSize(symbolSize);
  textFont('monospace');

  for (let i = 0; i < cols; i++) {
    let stream = new Stream(i * symbolSize, random(-1000, 0));
    streams.push(stream);
  }
}

function draw() {
  background(0, 255);
  for (let stream of streams) {
    stream.render();
  }
}

class MySymbol {
  constructor(x, y, speed, first) {
    this.x = x;
    this.y = y;
    this.value;
    this.speed = speed;
    this.switchInterval = round(random(2, 20));
    this.first = first;
    this.setToRandomSymbol();
  }

  setToRandomSymbol() {
    let charType = round(random(0, 2));
    if (charType === 0) {
      this.value = String.fromCharCode(0x30A0 + floor(random(0, 96)));
    } else if (charType === 1) {
      this.value = String.fromCharCode(65 + floor(random(0, 26)));
    } else {
      this.value = String.fromCharCode(97 + floor(random(0, 26)));
    }
  }

  rain() {
    this.y = (this.y >= height) ? 0 : this.y + this.speed;
    if (frameCount % this.switchInterval === 0) {
      this.setToRandomSymbol();
    }
  }

  render() {
    fill(this.first ? [180, 255, 180, random(0, 255)] : [0, 255, 70, random(0, 255)]);
    text(this.value, this.x, this.y);
    this.rain();
  }
}

class Stream {
  constructor(x, y) {
    this.symbols = [];
    this.totalSymbols = round(random(5, 30));
    this.speed = random(2, 5);
    this.generateSymbols(x, y);
  }

  generateSymbols(x, y) {
    let first = round(random(0, 4)) === 1;
    for (let i = 0; i < this.totalSymbols; i++) {
      let symbol = new MySymbol(x, y, this.speed, first);
      this.symbols.push(symbol);
      y -= symbolSize;
      first = false;
    }
  }

  render() {
    for (let symbol of this.symbols) {
      symbol.render();
    }
  }
}