p1 = new P5()
p2 = new P5()
var data = [1,2,3,4,5,6,7,8,9,10]
var getData = choose_at_random(data, 1);
console.log(getData);

function choose_at_random(arrayData, count) {
  var count = count || 1;
  var arrayData = arrayData;
  var result = [];
  for (var i = 0; i < count; i++) {
    var arrayIndex = Math.floor(Math.random() * arrayData.length);
    result[i] = arrayData[arrayIndex];
    arrayData.splice(arrayIndex, 1);
  }
  return result
}

p1.arc(0, 0, Math.PI*100, Math.PI*100, 0, Math.PI*(getData/10))
p2.quad(0, 0, getData*10, getData*20, getData*20, getData*40, getData*40, getData*10)
s0.init({src: p1.canvas})
s1.init({src: p2.canvas})
s2.initCam()
src(s0).scale([0.1,1].smooth()).add(src(s1).scale([0.1,1].smooth())).rotate(1,1).diff(osc(10,1).diff(gradient(1))).scrollX(0.1,0.1).repeat(2,2).modulate(noise(1)).modulate(voronoi(3)).colorama([0.01,1].smooth().fast(0.5)).blend(o0,[0.1,1].ease().fast(0.125)).modulate(o0,[0.1,1].fit().fast(0.125)).scale(()=>(a.fft[0]*1+1)).mult(src(s2).pixelate([12,25].smooth(),[12,25].smooth())).out()
