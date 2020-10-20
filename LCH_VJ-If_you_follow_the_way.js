//If you follow the way
//@HirotoshiUchida
//This is edited "https://github.com/Uchida16104/LiveCodingPortfolio/blob/master/LCH-VJ-P5_blending_backgrounds.js" for VJ of theme songs of aitunag (https://aitunag.com/).
speed = 0.5;
frame = 1000;
time = 1;
fps = 20;
linear = 1;
smooth = 3000;
p1 = new P5();
let c = p1.color(
  p1.frameCount * 256,
  p1.frameCount * 256,
  p1.frameCount * 256
);
p1.fill(c);
p1.noStroke();
p1.textFont();
p1.textSize(width / 15);
p1.textAlign(p1.CENTER, p1.CENTER);
p1.text("If you follow the way", 500, 500);
//p1.clear()
p1.stroke(
  p1.frameCount * 256,
  p1.frameCount * 256,
  p1.frameCount * 256
);
p1.hide();
s0.init({ src: p1.canvas });
src(s0)
  .diff(
    shape([3, 7].smooth())
      .scale(2)
      .scale(() => a.fft[0] * 0.25 + 1)
  )
  .mult(
    osc(10, 1)
      .diff(gradient(1))
      .diff(
        solid(
          [0, 0, 0, 0, 1, 1, 1, 1].smooth(),
          [0, 0, 1, 1, 0, 0, 1, 1].smooth(),
          [0, 1, 0, 1, 0, 1, 0, 1].smooth()
        )
      )
      .mask(
        osc(
          [2, 6].ease(),
          [1, 3].ease(),
          300
        ).diff(
          gradient([1, 10].ease()).color(
            [0, 0, 0, 1, 1, 1, 1].fit().smooth(),
            [0, 1, 1, 0, 0, 1, 1].fit().smooth(),
            [1, 0, 1, 0, 1, 0, 1].fit().smooth()
          )
        )
      ),
    [0, 1].ease().fast(0.125)
  )
  .modulate(voronoi(3, 2))
  .repeat()
  .modulateScale(osc(5))
  .pixelate(
    [250, 1250].smooth(),
    [250, 1250].smooth()
  )
  .contrast([0, 2].ease())
  .blend(
    osc(1, 2, 300)
      .diff(
        gradient(1).hue(
          () => Math.sin(time),
          () => Math.cos(time),
          () => Math.tan(time)
        )
      )
      .color(
        [0, 0, 0, 1, 1, 1, 1].smooth(),
        [0, 1, 1, 0, 0, 1, 1].smooth(),
        [1, 0, 1, 0, 1, 0, 1].smooth()
      )
      .scale(0.015625)
      .invert(1)
      .blend(
        shape([3, 7].smooth(), 0.1, 0.5)
          .contrast(5)
          .scale(1.25)
          .scale(() => a.fft[1] * 0.5 + 1)
          .blend(osc(1).diff(gradient(1)))
          .modulate(voronoi(3))
      ),
    [0, 1].smooth()
  )
  .blend(
    osc(1, 2, 300)
      .diff(
        gradient(1).hue(
          () => Math.sin(time),
          () => Math.cos(time),
          () => Math.tan(time)
        )
      )
      .color(
        [0, 0, 0, 1, 1, 1, 1].smooth(),
        [0, 1, 1, 0, 0, 1, 1].smooth(),
        [1, 0, 1, 0, 1, 0, 1].smooth()
      )
      .scale(0.015625)
      .invert(1)
      .blend(
        shape([3, 7].smooth(), 0.1, 0.5)
          .contrast(5)
          .scale(1.25)
          .scale(() => a.fft[2] * 0.75 + 1)
          .blend(osc(1).diff(gradient(1)))
          .modulate(voronoi(3))
      ),
    [0, 1].smooth()
  )
  .layer(
    src(s0)
      .modulate(voronoi(3))
      .blend(
        shape(
          [2].smooth().offset(),
          [0.1, 0.5].smooth().offset(),
          [0.5, 0.1].smooth().offset()
        )
          .mult(osc(10, 1).diff(gradient(15)))
          .contrast(5)
      )
      .scale(() => Math.sin(time) * 1.5)
      .scale(() => a.fft[1] * 1 + 1)
      .repeat(2, 2)
      .blend(
        osc(1, 2, 300)
          .diff(
            gradient(1).hue(
              () => Math.sin(time),
              () => Math.cos(time),
              () => Math.tan(time)
            )
          )
          .color(
            [0, 0, 0, 1, 1, 1, 1].smooth(),
            [0, 1, 1, 0, 0, 1, 1].smooth(),
            [1, 0, 1, 0, 1, 0, 1].smooth()
          )
          .scale(0.015625)
          .invert(1)
          .blend(
            shape([3, 7].smooth(), 0.1, 0.5)
              .contrast(5)
              .scale(1.25)
              .scale(() => a.fft[0] * 1.25 + 1)
              .blend(osc(1).diff(gradient(1)))
              .modulate(voronoi(3))
          ),
        [0, 1].smooth()
      )
      .color(
        [0, 0, 0, 1, 1, 1, 1].smooth(),
        [0, 1, 1, 0, 0, 1, 1].smooth(),
        [1, 0, 1, 0, 1, 0, 1].smooth(),
        ({ time }) => Math.sin(time * 2)
      )
  )
  .scale(() => a.fft[1] * 1.5 + 1)
  .blend(
    voronoi(20, 1, [0, 5].smooth())
      .modulatePixelate(
        shape(
          [3, 7].smooth(0.1),
          [0, 1].smooth(0.3),
          [1, 0].smooth(0.5)
        ).mult(
          gradient(1)
            .diff(
              solid(
                [0, 0, 0, 0, 1, 1, 1, 1].smooth(),
                [0, 0, 1, 1, 0, 0, 1, 1].smooth(),
                [0, 1, 0, 1, 0, 1, 0, 1].smooth()
              )
            )
            .hue(
              () => Math.sin(time),
              () => Math.cos(time),
              () => Math.tan(time)
            )
        )
      )
      .scale(() => a.fft[2] * 1.75 + 1)
  )
  .scale([0.5, 0.75].smooth())
  .out();
