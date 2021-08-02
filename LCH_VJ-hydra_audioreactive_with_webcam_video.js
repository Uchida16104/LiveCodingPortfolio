s0.initCam();
src(s0)
  .invert()
  .diff(
    src(o0).scale(0.99).diff(src(o0).scale(1.01))
  )
  .diff(
    shape(
      2,
      () => a.fft[0] * 0.5,
      () => a.fft[1] * 0.5
    )
      .mult(
        osc(1, 2, 300)
          .diff(gradient(1))
          .scale(0.1)
          .invert()
      )
      .modulate(
        osc(() => a.fft[2] * 0.125 + 60)
          //.hue(()=>Math.sin(time),()=>Math.cos(time),()=>Math.tan(time))
          //.saturate([0,10].smooth().fast(1/10))
          //.brightness([-1,1].smooth())
          .contrast(() => a.fft[3] + 1)
        //.colorama()
        //.luma()
        //.thresh()
        //.posterize()
      )
      .diff(
        src(o0)
          .scale(0.99)
          .diff(src(o0).scale(1.01))
      )
      .luma()
  )
  .out();
