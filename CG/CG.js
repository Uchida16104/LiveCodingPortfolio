      // create a new hydra-synth instance
      var hydra = new Hydra({
        canvas: document.getElementById("myCanvas")
      })
       osc(10,0.5,300).diff(gradient(1)).diff(solid([0,0,0,0,1,1,1,1].smooth(),[0,0,1,1,0,0,1,1].smooth(),[0,1,0,1,0,1,0,1].smooth())).hue(()=>Math.sin(time),()=>Math.cos(time),()=>Math.tan(time)).invert().out()
      
      function production() {
        noise(1).add(osc()).modulate(osc().color(()=>(a.fft[0]*10+2),()=>(a.fft[1]*20+3),()=>(a.fft[2]*30+4)).luma().colorama()).kaleid().modulateScale(osc(()=>(a.fft[3]*4+5))).modulateRotate(osc(()=>(a.fft[4]*5+6))).out(o1)
gradient(2.5).invert(1).saturate().scrollX().repeatX().scrollY().repeatY().kaleid(()=>(a.fft[3]*4+5)).modulateScale(osc(()=>(a.fft[5]*6+7))).modulateHue(osc(()=>(a.fft[4]*0.5+6))).modulateRotate(osc(()=>(a.fft[6]*7+8))).mask(voronoi(()=>(a.fft[0]*0.1+35),()=>(a.fft[1]*0.00002+1.5),()=>(a.fft[2]*3+4)),1,1,1).colorama().mult(osc([1],[2],[300].fast(0.5))).contrast(30).out(o3)
voronoi().scale(()=>(a.fft[3]*0.04+0.5)).rotate(()=>(a.fft[2]*0.03+0.04)).mask(osc(1,2,300).add(noise(1))).add(shape(100).scale(()=>(a.fft[1]*0.2+0.3))).add(gradient(1)).add(shape(4).scale().scale().scale().colorama().mask(osc(100,2,30).add(noise(10)).kaleid().modulateScale(osc()).modulateRotate(osc()))).out(o2)
osc(1,2,300).add(noise(1)).shift(()=>(a.fft[1]*0.2+0.3),()=>(a.fft[2]*0.3+0.4),()=>(a.fft[3]*0.4+0.5),()=>(a.fft[4]*0.5+0.6)).kaleid(()=>(a.fft[5]*0.6+0.7)).scrollX().scrollY().modulatePixelate(osc(a.fft[6]*7+80)).out(o0)
render()
      }
      
      function carpet() {
        shape(1).blend(osc(2,1,300)).diff(gradient(1)).mult(shape([4],[0.1,0.2,0.3,0.4,0.5],[0.5,0.6,0.7])).modulatePixelate(solid([0,1,0],[0,1,1],[1,0,0],[1,0,1],[1,1,0],[1,1,1],0.1),50,50).modulateScale(voronoi(0.5,1,5)).modulateRotate(noise(1)).out()
      }

      function flower() {
        shape([3,4,5,6,7,8,9,10,11,12]).diff(voronoi([1,2,3,4,5])).diff(gradient()).diff(osc(1,2,300)).modulateKaleid(o0).modulateRotate(o0).blend(o0).blend(o0).blend(o0).blend(o0).blend(o0).out()
      }

      function donut() {
        osc(10,time=0.1).kaleid(100,speed=-3).blend(gradient(1),2.5,fps=10000).modulate(o0,frame=0.01).out()
      }

      function slowmotion() {
        shape([1,2],0.1,0.5).modulate(voronoi(20,5,fps=7.5)).modulateKaleid(noise(5),[3,4,5,6,7,8,9,10,11,12],speed=0.5).modulateRotate(osc(10,0.1,100,fast=0.1)).colorama(2).luma(0.01).color([0,0,0,1,1,1,1],[0,1,1,0,0,1,1],[1,0,1,0,1,0,1],smooth=50).diff(solid([0,1,0],[0,1,1],[1,0,0],[1,0,1],[1,1,0],[1,1,1],frame=10).blend(osc(1,2,300)).mult(gradient(1,time=2.5))).out(o0)
      }

      function simulationfromeachperspectiveofabloodvesselexpressedin2dthatlookslike3d() {
voronoi(10).repeat(()=>Math.sin(time),()=>Math.cos(time)).scroll(()=>Math.cos(time),()=>Math.sin(time)).rotate(()=>Math.tan(time)).layer(shape(2,[0,0.05].smooth(),[0,0.25].smooth()).mult(solid([0,1].smooth(),0,0)).modulate(noise([0,10].ease('sin')).mult(noise([0,5].ease('easeInOut')))).modulateScale(osc(3)).scale(1)).contrast(2).out(o0)
voronoi(10).repeat(()=>Math.sin(time),()=>Math.cos(time)).scroll(()=>Math.cos(time),()=>Math.sin(time)).rotate(()=>Math.tan(time)).layer(shape(2,[0,0.05].smooth(),[0,0.25].smooth()).mult(solid([0,1].smooth(),0,0)).modulate(noise([0,10].ease('sin')).mult(noise([0,5].ease('easeInOut')))).modulateScale(osc(3)).scale(1)).rotate(()=>Math.sin(time)).contrast(2).out(o1)
voronoi(10).repeat(()=>Math.sin(time),()=>Math.cos(time)).scroll(()=>Math.cos(time),()=>Math.sin(time)).rotate(()=>Math.tan(time)).layer(shape(2,[0,0.05].smooth(),[0,0.25].smooth()).mult(solid([0,1].smooth(),0,0)).modulate(noise([0,10].ease('sin')).mult(noise([0,5].ease('easeInOut')))).modulateScale(osc(3)).scale(1)).rotate(()=>Math.cos(time)).contrast(2).out(o2)
voronoi(10).repeat(()=>Math.sin(time),()=>Math.cos(time)).scroll(()=>Math.cos(time),()=>Math.sin(time)).rotate(()=>Math.tan(time)).layer(shape(2,[0,0.05].smooth(),[0,0.25].smooth()).mult(solid([0,1].smooth(),0,0)).modulate(noise([0,10].ease('sin')).mult(noise([0,5].ease('easeInOut')))).modulateScale(osc(3)).scale(1)).rotate(1,1).contrast(2).out(o3)
render()
      }

function movementsatdifferenttimings1() {
        voronoi(20,1,[0,5].smooth()).modulatePixelate(shape([3,7].smooth(0.1),[0,1].ease('sin'),[1,0].ease('easeInOut')).scale([0.5,1.5].smooth(0.1))).mult(osc(10,0.5,300).diff(gradient(1)).diff(solid([0,0,0,0,1,1,1,1].smooth(),[0,0,1,1,0,0,1,1].smooth(),[0,1,0,1,0,1,0,1].smooth())).hue(()=>Math.sin(time),()=>Math.cos(time),()=>Math.tan(time)).invert([0,1].smooth()).kaleid([3,7].smooth(0.1))).scale(0.5).rotate([0,1].ease('sin'),[0,1].ease('easeInOut')).modulateScrollY(osc(1).repeat(()=>Math.cos(time),()=>Math.sin(time)).scroll(()=>Math.tan(time),()=>Math.tan(time))).repeat(2,2).modulateScrollY(osc(1).repeat(()=>Math.cos(time),()=>Math.sin(time)).scroll(()=>Math.sin(time),()=>Math.cos(time))).repeat(2,2).modulateScrollY(osc(1).repeat(()=>Math.cos(time),()=>Math.sin(time)).scroll([0,2].smooth(),[2,0].smooth())).repeat(2,2).modulateScrollY(osc(1).repeat(()=>Math.cos(time),()=>Math.sin(time)).scroll([2,0].smooth(),[0,2].smooth())).repeat(2,2).modulateScrollY(osc(1).repeat(()=>Math.cos(time),()=>Math.sin(time)).scroll([0,2].smooth(),[0,2].smooth())).repeat(2,2).modulateScrollY(osc(1).repeat(()=>Math.cos(time),()=>Math.sin(time)).scroll([2,0].smooth(),[2,0].smooth())).blend(voronoi(20,1,[2,0].smooth()).mult(noise(5).thresh()).mult(osc(1,2,300).diff(gradient(1)).color([0,0,0,1,1,1,1].smooth(),[0,1,1,0,0,1,1].smooth(),[1,0,1,0,1,0,1].smooth()).hue(()=>Math.cos(time),()=>Math.tan(time),()=>Math.sin(time)).invert(1))).contrast(5).brightness(2).modulateRotate(shape([7,3].smooth(0.1),[1,0].ease('easeInOut'),[0,1].ease('sin')).scale([1,0].smooth(0.1)),()=>Math.tan(time/16)).modulateScale(osc(16)).scale(8).out()
      }

function movementsatdifferenttimings2() {
        shape([3,7].smooth(),[0,1].ease('sin'),[1,0].ease('easeInOut')).mult(osc(10,0.5,300).diff(gradient(1)).diff(solid([0,0,0,0,1,1,1,1].smooth(),[0,0,1,1,0,0,1,1].smooth(),[0,1,0,1,0,1,0,1].smooth())).hue(()=>Math.sin(time),()=>Math.cos(time),()=>Math.tan(time)).invert([0,1].smooth()).kaleid([3,7].smooth())).scale(0.5).rotate(1,1).modulateScrollY(osc(1).repeat(()=>Math.cos(time),()=>Math.sin(time)).scroll(()=>Math.tan(time),()=>Math.tan(time))).repeat(2,2).modulateScrollY(osc(1).repeat(()=>Math.cos(time),()=>Math.sin(time)).scroll(()=>Math.sin(time),()=>Math.cos(time))).repeat(2,2).modulateScrollY(osc(1).repeat(()=>Math.cos(time),()=>Math.sin(time)).scroll([0,2].smooth(),[2,0].smooth())).repeat(2,2).modulateScrollY(osc(1).repeat(()=>Math.cos(time),()=>Math.sin(time)).scroll([2,0].smooth(),[0,2].smooth())).repeat(2,2).modulateScrollY(osc(1).repeat(()=>Math.cos(time),()=>Math.sin(time)).scroll([0,2].smooth(),[0,2].smooth())).repeat(2,2).modulateScrollY(osc(1).repeat(()=>Math.cos(time),()=>Math.sin(time)).scroll([2,0].smooth(),[2,0].smooth())).modulateScale(osc(16)).scale(8).scale(()=>Math.sin(time/3)).out(o0)
shape([3,7].smooth(),[0,1].ease('sin'),[1,0].ease('easeInOut')).mult(osc(10,0.5,300).diff(gradient(1)).diff(solid([0,0,0,0,1,1,1,1].smooth(),[0,0,1,1,0,0,1,1].smooth(),[0,1,0,1,0,1,0,1].smooth())).hue(()=>Math.sin(time),()=>Math.cos(time),()=>Math.tan(time)).invert([0,1].smooth()).kaleid([3,7].smooth())).scale(0.5).rotate(1,1).modulateScrollY(osc(1).repeat(()=>Math.cos(time),()=>Math.sin(time)).scroll(()=>Math.tan(time),()=>Math.tan(time))).repeat(2,2).modulateScrollY(osc(1).repeat(()=>Math.cos(time),()=>Math.sin(time)).scroll(()=>Math.sin(time),()=>Math.cos(time))).repeat(2,2).modulateScrollY(osc(1).repeat(()=>Math.cos(time),()=>Math.sin(time)).scroll([0,2].smooth(),[2,0].smooth())).repeat(2,2).modulateScrollY(osc(1).repeat(()=>Math.cos(time),()=>Math.sin(time)).scroll([2,0].smooth(),[0,2].smooth())).repeat(2,2).modulateScrollY(osc(1).repeat(()=>Math.cos(time),()=>Math.sin(time)).scroll([0,2].smooth(),[0,2].smooth())).repeat(2,2).modulateScrollY(osc(1).repeat(()=>Math.cos(time),()=>Math.sin(time)).scroll([2,0].smooth(),[2,0].smooth())).modulateScale(osc(16)).scale(8).scale(()=>Math.cos(time/4)).out(o1)
shape([3,7].smooth(),[0,1].ease('sin'),[1,0].ease('easeInOut')).mult(osc(10,0.5,300).diff(gradient(1)).diff(solid([0,0,0,0,1,1,1,1].smooth(),[0,0,1,1,0,0,1,1].smooth(),[0,1,0,1,0,1,0,1].smooth())).hue(()=>Math.sin(time),()=>Math.cos(time),()=>Math.tan(time)).invert([0,1].smooth()).kaleid([3,7].smooth())).scale(0.5).rotate(1,1).modulateScrollY(osc(1).repeat(()=>Math.cos(time),()=>Math.sin(time)).scroll(()=>Math.tan(time),()=>Math.tan(time))).repeat(2,2).modulateScrollY(osc(1).repeat(()=>Math.cos(time),()=>Math.sin(time)).scroll(()=>Math.sin(time),()=>Math.cos(time))).repeat(2,2).modulateScrollY(osc(1).repeat(()=>Math.cos(time),()=>Math.sin(time)).scroll([0,2].smooth(),[2,0].smooth())).repeat(2,2).modulateScrollY(osc(1).repeat(()=>Math.cos(time),()=>Math.sin(time)).scroll([2,0].smooth(),[0,2].smooth())).repeat(2,2).modulateScrollY(osc(1).repeat(()=>Math.cos(time),()=>Math.sin(time)).scroll([0,2].smooth(),[0,2].smooth())).repeat(2,2).modulateScrollY(osc(1).repeat(()=>Math.cos(time),()=>Math.sin(time)).scroll([2,0].smooth(),[2,0].smooth())).modulateScale(osc(16)).scale(8).scale(()=>Math.sin(time/5)).out(o2)
shape([3,7].smooth(),[0,1].ease('sin'),[1,0].ease('easeInOut')).mult(osc(10,0.5,300).diff(gradient(1)).diff(solid([0,0,0,0,1,1,1,1].smooth(),[0,0,1,1,0,0,1,1].smooth(),[0,1,0,1,0,1,0,1].smooth())).hue(()=>Math.sin(time),()=>Math.cos(time),()=>Math.tan(time)).invert([0,1].smooth()).kaleid([3,7].smooth())).scale(0.5).rotate(1,1).modulateScrollY(osc(1).repeat(()=>Math.cos(time),()=>Math.sin(time)).scroll(()=>Math.tan(time),()=>Math.tan(time))).repeat(2,2).modulateScrollY(osc(1).repeat(()=>Math.cos(time),()=>Math.sin(time)).scroll(()=>Math.sin(time),()=>Math.cos(time))).repeat(2,2).modulateScrollY(osc(1).repeat(()=>Math.cos(time),()=>Math.sin(time)).scroll([0,2].smooth(),[2,0].smooth())).repeat(2,2).modulateScrollY(osc(1).repeat(()=>Math.cos(time),()=>Math.sin(time)).scroll([2,0].smooth(),[0,2].smooth())).repeat(2,2).modulateScrollY(osc(1).repeat(()=>Math.cos(time),()=>Math.sin(time)).scroll([0,2].smooth(),[0,2].smooth())).repeat(2,2).modulateScrollY(osc(1).repeat(()=>Math.cos(time),()=>Math.sin(time)).scroll([2,0].smooth(),[2,0].smooth())).modulateScale(osc(16)).scale(8).scale(()=>Math.cos(time/6)).out(o3)
render()
      }

function graphicswitchwhitoutp5js() {
        src(s0).diff(shape([3, 7].smooth()).scale(2).scale(() => a.fft[0] * 0.25 + 1)).mult(osc(10, 1).diff(gradient(1)).diff(solid([0, 0, 0, 0, 1, 1, 1, 1].smooth(),[0, 0, 1, 1, 0, 0, 1, 1].smooth(),[0, 1, 0, 1, 0, 1, 0, 1].smooth())).mask(osc([2, 6].ease(),[1, 3].ease(),300).diff(gradient([1, 10].ease()).color([0, 0, 0, 1, 1, 1, 1].fit().smooth(),[0, 1, 1, 0, 0, 1, 1].fit().smooth(),[1, 0, 1, 0, 1, 0, 1].fit().smooth()))),[0, 1].ease().fast(0.125)).modulate(voronoi(3, 2)).repeat().modulateScale(osc(5)).pixelate([250, 1250].smooth(),[250, 1250].smooth()).contrast([0, 2].ease()).blend(osc(1, 2, 300).diff(gradient(1).hue(() => Math.sin(time),() => Math.cos(time),() => Math.tan(time))).color([0, 0, 0, 1, 1, 1, 1].smooth(),[0, 1, 1, 0, 0, 1, 1].smooth(),[1, 0, 1, 0, 1, 0, 1].smooth()).scale(0.015625).invert(1).blend(shape([3, 7].smooth(), 0.1, 0.5).contrast(5).scale(1.25).scale(() => a.fft[1] * 0.5 + 1).blend(osc(1).diff(gradient(1))).modulate(voronoi(3))),[0, 1].smooth()).blend(osc(1, 2, 300).diff(gradient(1).hue(() => Math.sin(time),() => Math.cos(time),() => Math.tan(time))).color([0, 0, 0, 1, 1, 1, 1].smooth(),[0, 1, 1, 0, 0, 1, 1].smooth(),[1, 0, 1, 0, 1, 0, 1].smooth()).scale(0.015625).invert(1).blend(shape([3, 7].smooth(), 0.1, 0.5).contrast(5).scale(1.25).scale(() => a.fft[2] * 0.75 + 1).blend(osc(1).diff(gradient(1))).modulate(voronoi(3))),[0, 1].smooth()).layer(src(s0).modulate(voronoi(3)).blend(shape([2].smooth().offset(),[0.1, 0.5].smooth().offset(),[0.5, 0.1].smooth().offset()).mult(osc(10, 1).diff(gradient(15))).contrast(5)).scale(() => Math.sin(time) * 1.5).scale(() => a.fft[1] * 1 + 1).repeat(2, 2).blend(osc(1, 2, 300).diff(gradient(1).hue(() => Math.sin(time),() => Math.cos(time),() => Math.tan(time))).color([0, 0, 0, 1, 1, 1, 1].smooth(),[0, 1, 1, 0, 0, 1, 1].smooth(),[1, 0, 1, 0, 1, 0, 1].smooth()).scale(0.015625).invert(1).blend(shape([3, 7].smooth(), 0.1, 0.5).contrast(5).scale(1.25).scale(() => a.fft[0] * 1.25 + 1).blend(osc(1).diff(gradient(1))).modulate(voronoi(3))),[0, 1].smooth()).color([0, 0, 0, 1, 1, 1, 1].smooth(),[0, 1, 1, 0, 0, 1, 1].smooth(),[1, 0, 1, 0, 1, 0, 1].smooth(),({ time }) => Math.sin(time * 2))).scale(() => a.fft[1] * 1.5 + 1).blend(voronoi(20, 1, [0, 5].smooth()).modulatePixelate(shape([3, 7].smooth(0.1),[0, 1].smooth(0.3),[1, 0].smooth(0.5)).mult(gradient(1).diff(solid([0, 0, 0, 0, 1, 1, 1, 1].smooth(),[0, 0, 1, 1, 0, 0, 1, 1].smooth(),[0, 1, 0, 1, 0, 1, 0, 1].smooth())).hue(() => Math.sin(time),() => Math.cos(time),() => Math.tan(time)))).scale(() => a.fft[2] * 1.75 + 1),[0, 1].smooth()).scale([0.5, 0.75].smooth()).out() 
      }
function graphicswitchedited() {
shape([3,7].smooth(),[0,1].smooth(),[1,0].smooth()).rotate(()=>Math.tan(time)).add(voronoi(20,1,5).luma(0.05)).blend(noise(2).thresh()).mult(osc(10,0.5,300).diff(gradient(1).hue(()=>Math.sin(time),()=>Math.cos(time),()=>Math.tan(time))).color([0,0,0,1,1,1,1].smooth(),[0,1,1,0,0,1,1].smooth(),[1,0,1,0,1,0,1].smooth()).invert().scale(1/8)).out()
      }

function moonmodulation() {
shape(360,[0,1].smooth(),[1,0].smooth()).color(1,0.875,0.125).modulate(shape(360,[1,0].smooth(),[0,1].smooth()),[0,1].smooth()).blend(o0).scrollX(()=>Math.sin(time)/10).scrollY(()=>Math.cos(time)/10).scale(()=>Math.tan(time)/10).out()
      }

function limitedpatterns() {
solid().add(o1,[1,0,0].smooth()).add(o2,[0,1,0].smooth()).add(o3,[0,0,1].smooth()).out()
shape([3,7].smooth(),[0,1].smooth(),[1,0].smooth()).modulate(o1,[0,1].ease('sin')).saturate(5).posterize(5).invert().colorama([-1,1].smooth().fast(1/16)).luma([-1,1].smooth()).layer(voronoi(20,1,[0,1].smooth()).add(osc(10,0.5,300).diff(gradient(1)).kaleid([3,7].smooth()).scroll(()=>Math.sin(time),()=>Math.cos(time)).scale(1/4).blend(o1,[0,1].ease('easeInOut').smooth().fast(1/4)),[0,1].smooth()).color(1,1,1,[0,1].smooth())).blend(osc(10,1).mask(noise().thresh(),[1,0].smooth()).mask(shape([3,7].smooth()).modulate(voronoi(3)).repeat(),[0,1].smooth()),[1,0].smooth()).blend(solid(()=>Math.sin(time),()=>Math.cos(time),()=>Math.tan(time)).mult(voronoi(3,[0,1/2].smooth().fast(1/64),[0,1/2].smooth().fast(1/64))),[0,1].smooth()).out(o1)
shape(2,0.001,0.005).modulate(noise([0,3].smooth())).rotate([0,1].smooth()).rotate(()=>Math.sin(time)).rotate([0,1].ease('sin')).rotate(()=>Math.cos(time)).rotate([1,0].ease('easeInOut')).rotate(()=>Math.sin(timme)).layer(noise([0,5].smooth()).thresh().invert([0,1].smooth()).blend(o2).color(1,1,1,[1,0].smooth())).mask(shape([1,2].smooth()).scroll(()=>Math.sin(time),()=>Math.cos(time)).rotate(1,1).repeat(5,5).contrast([1,3].smooth()),[0,1].smooth()).out(o2)
shape([3,7].smooth(),[0,1].smooth(),[1,0].smooth()).mult(osc(10,0.5,300).diff(gradient(1)).diff(solid([0,0,0,0,1,1,1,1].smooth(),[0,0,1,1,0,0,1,1].smooth(),[0,1,0,1,0,1,0,1].smooth())).hue(()=>Math.sin(time),()=>Math.cos(time),()=>Math.tan(time)).colorama([0,5].smooth().fast(1/16)).luma([0,1].smooth().fast(1/16))).kaleid([3,7].smooth()).modulateKaleid(shape([3,7].smooth(),[0,1].smooth(),[1,0].smooth()),[3,7].smooth()).layer(noise(7.5).thresh().modulate(o3).color(1,1,1,[1,0,0].smooth())).layer(voronoi(1,1,5).color(1,1,1,[0,1,0].smooth())).layer(osc(10,1,300).modulate(voronoi(3)).modulate(noise(3)).color([0,0,1].smooth())).mult(osc(10,0.5,300).diff(gradient(1)).diff(solid([0,0,0,0,1,1,1,1].smooth(),[0,0,1,1,0,0,1,1].smooth(),[0,1,0,1,0,1,0,1].smooth())).hue(()=>Math.sin(time),()=>Math.cos(time),()=>Math.tan(time)).invert([0,1].smooth().fast(1/4))).blend(shape([3,7].smooth(),[0,1].smooth(),[1,0].smooth()).rotate(()=>Math.tan(time)).scale(()=>Math.tan(time)*(-1)),[0,1].smooth()).out(o3)
      }

function colofulcells() {
osc(10,1).mult(osc(10,1).rotate(1.57)).add(shape(4,0,1).repeat(2,2).scroll([0,1].smooth(0.5),[0,1].smooth(0.5))).mult(osc(10,0.5,300).diff(gradient(1)).diff(solid([0,0,0,0,1,1,1,1].smooth(),[0,0,1,1,0,0,1,1].smooth(),[0,1,0,1,0,1,0,1].smooth())).hue(()=>Math.sin(time),()=>Math.cos(time),()=>Math.tan(time))).saturate([0,5].smooth()).brightness([0,1/8].smooth()).contrast([2,5].smooth()).out()
      }

function electricscoreboardandsquaresmoke() {
shape(360,0,1).repeat(64,64).add(voronoi(20,1,5)).mask(osc(10,0.5).add(osc(10,0.5).rotate(1.57))).mult(osc(10,0.5,300).diff(gradient(1)).diff(solid([0,0,0,0,1,1,1,1].smooth(),[0,0,1,1,0,0,1,1].smooth(),[0,1,0,1,0,1,0,1].smooth())).hue(()=>Math.sin(time),()=>Math.cos(time),()=>Math.tan(time)).saturate([0,2].ease('sin')).brightness([0,1].smooth()).contrast([1,3].smooth())).out()
      }

function seamofwavelightversion() {
shape([3,7].smooth(),[0,1].smooth(),[0,1].reverse().smooth()).mult(osc(10,0.5,300).diff(gradient(1)).diff(solid([0,0,0,0,1,1,1,1].smooth(),[0,0,1,1,0,0,1,1].smooth(),[0,1,0,1,0,1,0,1].smooth())).hue(()=>Math.sin(time),()=>Math.cos(time),()=>Math.tan(time)).saturate([0,5].smooth()).brightness([0,1].smooth()).contrast([1,3].smooth()).scale(0.1)).rotate(()=>Math.sin(time)).diff(shape([3,7].reverse().smooth(),[0,1].reverse().smooth(),[0,1].smooth()).mult(osc(-10,-0.5,300).diff(gradient(-1)).diff(solid([0,0,0,0,1,1,1,1].smooth().fast(1/2),[0,0,1,1,0,0,1,1].smooth().fast(1/2),[0,1,0,1,0,1,0,1].smooth().fast(1/2))).hue(()=>Math.sin(time/2),()=>Math.cos(time/2),()=>Math.tan(time/2)).saturate([0,5].smooth().fast(1/2)).brightness([0,1].smooth().fast(1/2)).contrast([1,3].smooth().fast(1/2)).scale(0.1)).rotate(()=>Math.cos(time))).scale(1.5).out()
      }

function seamofwavedarkversion() {
shape([3,7].smooth(),[0,1].smooth(),[0,1].reverse().smooth()).mult(osc(10,0.5,300).diff(gradient(1)).diff(solid([0,0,0,0,1,1,1,1].smooth(),[0,0,1,1,0,0,1,1].smooth(),[0,1,0,1,0,1,0,1].smooth())).hue(()=>Math.sin(time),()=>Math.cos(time),()=>Math.tan(time)).saturate([0,5].smooth()).brightness([0,1].smooth()).contrast([1,3].smooth()).scale(0.1)).rotate(()=>Math.sin(time)).diff(shape([3,7].reverse().smooth(),[0,1].reverse().smooth(),[0,1].smooth()).mult(osc(-10,-0.5,300).diff(gradient(-1)).diff(solid([0,0,0,0,1,1,1,1].smooth().fast(1/2),[0,0,1,1,0,0,1,1].smooth().fast(1/2),[0,1,0,1,0,1,0,1].smooth().fast(1/2))).hue(()=>Math.sin(time/2),()=>Math.cos(time/2),()=>Math.tan(time/2)).saturate([0,5].smooth().fast(1/2)).brightness([0,1].smooth().fast(1/2)).contrast([1,3].smooth().fast(1/2)).scale(0.1)).rotate(()=>Math.cos(time))).scale(1.5).invert().out()
      }

function marbleswithpaintoverandflash() {
t = 8;
marbles = () => osc(10,0.5,300).diff(gradient(1)).diff(solid([0,0,0,0,1,1,1,1].smooth(),[0,0,1,1,0,0,1,1].smooth(),[0,1,0,1,0,1,0,1].smooth())).hue(()=>Math.sin(time),()=>Math.cos(time),()=>Math.tan(time)).saturate([0,5].smooth()).brightness([0,1].smooth()).contrast([1,2].smooth()).diff(noise(()=>time/1000).thresh()).mask(voronoi(2,1,5).scale(3)).scale(0.1).invert();
flash = () => shape(360,[0,1].smooth(),[0,1].reverse().smooth()).colorama([0,10].smooth()).mult(osc(10,0.5).diff(osc(10,0.5).rotate(1.57))).mult(osc(10,0.5,300).diff(gradient(1)).diff(solid([0,0,0,0,1,1,1,1].smooth(),[0,0,1,1,0,0,1,1].smooth(),[0,1,0,1,0,1,0,1].smooth())).hue(()=>Math.cos(time),()=>Math.tan(time),()=>Math.sin(time)).saturate([0,5].reverse().ease('sin')).brightness([0,1].reverse().smooth()).contrast([0,1].reverse().smooth()).invert());
marbles().invert().add(flash()).blend(o0,[0,t-1/t].smooth().fast(1/t)).out(o0);
      }

function glossofdropandsphereescalator() {
solid().add(o3).modulateScale(src(o3).add(noise(1).thresh()),()=>Math.tan(time)).out(o0)
shape(360,[0.1,0.5].smooth(),[0.1,0.5].reverse().smooth()).scale(0.99).repeat(8,8).scroll(()=>(time/-10),()=>(time/-10)).diff(osc(50,0.25).mult(osc(50,0.25).rotate(1.57)).thresh()).out(o1)
voronoi(1,4,3).repeat(8,8).scroll(()=>(time/-10),()=>(time/-10)).blend(osc(50,0.25).mult(osc(50,0.25).rotate(1.57)).thresh()).out(o2)
solid().add(o1,[1,0].fast(1/4)).add(o2,[0,1].fast(1/4)).mult(osc(10,0.5,300).diff(gradient(1)).diff(solid([0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1].smooth(),[0,0,0,0,1,1,1,1].smooth(),[0,0,1,1].smooth(),[0,1].smooth())).invert().hue(()=>Math.sin(time),()=>Math.cos(time),()=>Math.tan(time)).saturate([0,5].ease('sin')).brightness([0,1].smooth()).contrast([1,2].smooth())).scale([0,1].smooth().fast(1/2)).out(o3)
      }

function kaleidcoaster() {
osc([10,100].smooth().fast(1/16),1,300).diff(gradient(1)).diff(solid([0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1].smooth(),[0,0,0,0,1,1,1,1].smooth(),[0,0,1,1].smooth(),[0,1].smooth())).hue(()=>Math.sin(time),()=>Math.cos(time),()=>Math.tan(time)).saturate([0,5].smooth()).brightness([0,1].smooth()).contrast([1,2].smooth()).invert().kaleid([3,4,5,6,7].smooth()).diff(shape([3,4,5,6,7].smooth(),[0,1].smooth(),[0,1].reverse().smooth()).colorama([1,10].smooth().fast(1/16)).thresh().rotate([2.62,2.35,2.2,2.1,2.03].smooth())).blend(o0,[0.01,0.99].smooth()).out()
      }

function imaginetheimageofthesea() {
osc(10).modulate(noise(()=>Math.PI)).modulate(o1).modulate(o2).modulate(o3).add(solid(0,0.25,1,1),3/4).out()
shape(360,[0,1].smooth(),[0,1].reverse().smooth()).repeat(8,8).out(o1)
noise(10).thresh().out(o2)
voronoi(20,1,5).out(o3)
      }

function surge() {
solid().add(o1,[0,1].smooth()).add(o2,[0,1].reverse().smooth()).modulatePixelate(shape(360,[0,1].smooth(),[0,1].reverse().smooth()).colorama(1)).mult(osc(10,0.5,300).diff(gradient(1)).diff(solid([0,1].smooth().fast(1/8),[0,1].smooth().fast(1/4),[0,1].smooth().fast(1/2),[0,1])).hue(()=>Math.sin(time),()=>Math.cos(time),()=>Math.tan(time)).brightness([0,1].smooth()).contrast([1,2].smooth()).kaleid(360)).modulateScrollY(osc(1).repeat(1,1).scroll(()=>Math.sin(time),()=>Math.cos(time))).modulateScrollY(osc(2).repeat(2,2).scroll(()=>Math.cos(time/2),()=>Math.sin(time/2))).modulateScrollY(osc(3).repeat(3,3).scroll(()=>Math.sin(time/3),()=>Math.cos(time/3))).modulateScrollY(osc(4).repeat(4,4).scroll(()=>Math.cos(time/4),()=>Math.sin(time/4))).out(o0)
noise(20).thresh([0,1].smooth()).out(o1)
voronoi(20,1,[0,5].smooth().fast(1/20)).out(o2)
      }

function surgepaintoverversion() {
solid().add(o1,[0,1].smooth()).add(o2,[0,1].reverse().smooth()).modulatePixelate(shape(360,[0,1].smooth(),[0,1].reverse().smooth()).colorama(1)).mult(osc(10,0.5,300).diff(gradient(1)).diff(solid([0,1].smooth().fast(1/8),[0,1].smooth().fast(1/4),[0,1].smooth().fast(1/2),[0,1])).hue(()=>Math.sin(time),()=>Math.cos(time),()=>Math.tan(time)).brightness([0,1].smooth()).contrast([1,2].smooth()).kaleid(360)).modulateScrollY(osc(1).repeat(1,1).scroll(()=>Math.sin(time),()=>Math.cos(time))).modulateScrollY(osc(2).repeat(2,2).scroll(()=>Math.cos(time/2),()=>Math.sin(time/2))).modulateScrollY(osc(3).repeat(3,3).scroll(()=>Math.sin(time/3),()=>Math.cos(time/3))).modulateScrollY(osc(4).repeat(4,4).scroll(()=>Math.cos(time/4),()=>Math.sin(time/4))).diff(o0,[0,8].smooth()).out(o0)
noise(20).thresh([0,1].smooth()).out(o1)
voronoi(20,1,[0,5].smooth().fast(1/20)).out(o2)
      }

function electriccircuit() {
shape(4).colorama(2).scroll(()=>Math.random(time),()=>Math.random(time)).blend(o0,[0.9,0.99].smooth().fast(1/4)).colorama().contrast(1.1).out()
      }

function retromodern() {
shape(4).scrollX(()=>(time)).scale(3.3).diff(o0).diff(osc(10,1)).scale([0.5,0.875].smooth()).invert([0,1]).color(0,1,1).out()
      }

function blurandpaintover() {
noise(2,0).thresh().scroll(1.145,0.65625).scale(2.2,1.2,0.96875).rotate(2).add(shape(360,0.1,2.47).scale(0.5)).mult(voronoi(2,0,50),0.1).repeat(2,2).mult(osc(1,2,300).diff(gradient(1)).diff(solid([0,1].smooth().fast(1/8),[0,1].smooth().fast(1/4),[0,1].smooth().fast(1/2),[0,1].smooth())).hue(()=>Math.sin(time),()=>Math.cos(time),()=>Math.tan(time)).saturate([0,5].ease('sin')).brightness([0,1].smooth()).contrast([1,2].smooth()).scale(0.1)).modulateScale(osc([0,5].smooth().fast(1/16)),()=>Math.tan(time)).add(o0,()=>Math.tan(time)).blend(o0,[0,1].ease('sin')).out()
      }

function likealacesheercurtainthatcirclesdesignshiftsandpopsout() {
shape(360,[0,1].smooth(),[0,1].reverse().smooth()).scale(0.05).mult(osc(10,0.5,300).diff(gradient(1)).diff(solid([0,1].smooth().fast(1/8),[0,1].smooth().fast(1/4),[0,1].smooth().fast(1/2),[0,1].smooth())).invert([0,1].smooth().fast(1/2)).hue(()=>Math.sin(time),()=>Math.cos(time),()=>Math.tan(time)).saturate([0,5].smooth()).brightness([0,1].smooth()).contrast([1,2].smooth()).scale(0.01)).scroll([0,0,1/2,1/2].fast(8),[0,1/2,0,1/2].fast(8)).scale(7/8).add(o0,7/8).modulateScrollY(osc(1).repeat(2,2).scroll(()=>Math.sin(time),()=>Math.cos(time))).modulateScrollY(osc(2).repeat(2,2).scroll(()=>Math.cos(time/2),()=>Math.sin(time/2))).diff(osc(10,0.0175).scale(0.7)).scale(()=>Math.tan(time/32)).out(o0)
      }

function vividinvertrosemodulation() {
src(o1).rotate(1,1).add(o0,[0,1].smooth().fast(1/8)).mult(o0,[0,1].smooth().fast(1/4)).diff(o0,[0,1].smooth().fast(1/2)).mult(osc(10,0.5,300).diff(gradient(1)).diff(solid([0,1].smooth().fast(1/8),[0,1].smooth().fast(1/4),[0,1].smooth().fast(1/2),[0,1].smooth())).invert([0,1].smooth()).hue(()=>Math.sin(time),()=>Math.cos(time),()=>Math.tan(time)).saturate([0,5].smooth()).brightness([0,1].smooth()).contrast([1,2].smooth())).scale([0,1].smooth()).add(o0,[-1,1].ease('sin')).brightness(-0.25).out(o0)
osc(10,1).kaleid([3,7].smooth()).modulateRotate(shape([3,7].smooth(),[0,1].smooth(),[0,1].reverse().smooth()),()=>Math.tan(time)).modulateScale(o0,()=>Math.tan(time)).blend(o1,0.99).out(o1)
      }

function colorandactivefluidassignment() {
voronoi([0,1].smooth(),1,[0,1].ease('sin')).modulateScale(shape(360,[0,1].smooth(),[0,1].reverse().smooth()).add(noise(1).thresh()).rotate(1,1),()=>Math.tan(time/10)).modulateScrollY(osc(1).scroll(()=>Math.sin(time),()=>Math.cos(time))).modulateScrollY(osc(2).scroll(()=>Math.cos(time/2),()=>Math.sin(time/2))).modulateScale(osc(()=>Math.PI)).scale(1/2).mult(osc(10,0.5,300).posterize(5).diff(gradient(1).colorama(1).luma(1/2)).diff(solid([0,1].smooth().fast(1/8),[0,1].smooth().fast(1/4),[0,1].smooth().fast(1/2),[0,1].smooth()).shift([0,1].reverse().ease('sin'),[0,1].reverse().ease('sin').fast(1/2),[0,1].reverse().ease('sin').fast(1/4),[0,1].reverse().ease('sin').fast(1/8))).color(()=>Math.cos(time),()=>Math.tan(time),()=>Math.sin(time)).invert([0,1].smooth()).hue(()=>Math.sin(time),()=>Math.cos(time),()=>Math.tan(time)).saturate([0,10].smooth()).brightness([0,1].smooth()).contrast([1,2].smooth())).out()
      }
function fireandsmokestainedinspectralcolors() {
setResolution(400,400);
shape(360,[0,1].smooth(),[0,1].reverse().smooth()).scale(()=>Math.tan(time)).mult(osc(10,0.5,300).diff(gradient(1)).diff(solid([0,1].smooth().fast(1/8),[0,1].smooth().fast(1/4),[0,1].smooth().fast(1/2),[0,1].smooth())).hue(()=>Math.sin(time),()=>Math.cos(time),()=>Math.tan(time)).saturate([0,10].smooth()).brightness([0,1].smooth()).contrast([1,2].smooth())).add(o0,[0,2].smooth()).mult(o0,[1,2,0].smooth()).diff(o0,[0,2].reverse().smooth()).blend(o0,[0,2].smooth()).modulate([0,1].smooth()).out();
      }

function rhombusswirl() {
setResolution(400,400);
osc(10,1).mult(osc(10,1).rotate(1.57)).modulateKaleid(o1).mult(osc(10,0.5,300).diff(gradient(1)).diff(solid([0,1].smooth().fast(1/8),[0,1].smooth().fast(1/4),[0,1].smooth().fast(1/2),[0,1].smooth())).hue(()=>Math.sin(time),()=>Math.cos(time),()=>Math.tan(time)).saturate([0,10].smooth()).brightness([0,1].smooth()).contrast([1,2].smooth()).scale([0,1].smooth())).out(o0);
shape(4,[0,1].smooth(),[0,1].reverse().smooth()).rotate(1,1).modulateKaleid(shape(4,[0,1].smooth(),[0,1].reverse().smooth()),4).kaleid(4).rotate(()=>Math.tan(time)).modulateRotate(shape(4,[0,1].smooth(),[0,1].reverse().smooth()),()=>Math.tan(time*-1)).rotate(-1,-1).out(o1);
      }

function unusuallyshapedtreetrunkforestandcolorfulzebra() {
setResolution(400,400);
src(o1).modulateScrollY(osc(1).scroll(()=>Math.sin(time),()=>Math.cos(time))).repeat(1,2).modulateScrollY(osc(2).scroll(()=>Math.cos(time/2),()=>Math.sin(time/2))).repeat(2,1).mult(osc(10,0.5,300).diff(gradient(1)).diff(solid([0,1].smooth().fast(1/8),[0,1].smooth().fast(1/4),[0,1].smooth().fast(1/2),[0,1].smooth())).hue(()=>Math.sin(time),()=>Math.cos(time),()=>Math.tan(time)).saturate([0,10].smooth()).brightness([0,1].smooth()).contrast([1,2].smooth()).color(()=>Math.cos(time),()=>Math.tan(time),()=>Math.sin(time)).shift([0,1].smooth(),[0,1].smooth().fast(1/2),[0,1].smooth().fast(1/4),[0,1].smooth().fast(1/8)).luma([0,1].smooth()).colorama([0,3].smooth())).blend(o0,[0,3/4].smooth()).out(o0);
osc(10,1/4).layer(shape([3,7].smooth(),[0,1].smooth(),[0,1].reverse().smooth()).mask(noise(1).thresh())).invert([0,1].ease('sin')).modulate(voronoi(1)).modulate(voronoi(2)).posterize(1.5).scale([0,1].smooth().fast(1/4)).add(o1,[0,1].smooth()).blend(o1,[0,3/4].smooth()).out(o1);
      }

function waveandlaser() {
shape(4,[0,1].smooth(),[0,1].reverse().smooth()).scale(1).repeat([1,4].smooth().fast(1/4),[1,4].smooth()).modulateScrollY(osc(1).scroll(()=>Math.sin(time/-2),()=>Math.cos(time/-2))).modulateScrollY(osc(2).scroll(()=>Math.cos(time/-1),()=>Math.sin(time/-1))).modulateScrollY(osc(3).scroll(()=>Math.sin(time),()=>Math.cos(time))).modulateScrollY(osc(2).scroll(()=>Math.cos(time*2),()=>Math.sin(time*2))).scale([1/8,1/2].smooth()).scale(()=>(time/10)).scroll(()=>Math.sin(time/2),()=>Math.cos(time/2)).diff(osc(10,1/4)).diff(osc(10,1/4).rotate(1.57)).mult(osc(10,1/8,300).diff(gradient(1)).diff(solid([0,1].smooth().fast(1/8),[0,1].smooth().fast(1/4),[0,1].smooth().fast(1/2),[0,1].smooth())).hue(()=>Math.sin(time),()=>Math.cos(time),()=>Math.tan(time)).saturate([0,10].smooth()).brightness([0,1].smooth()).contrast([1,2].smooth()).scale(0.1).scale(1.5)).invert().out();
      }
