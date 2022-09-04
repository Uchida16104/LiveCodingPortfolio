let i=[1,1/2,1/4,1/8]
let j=[30,30/2,30/4,30/8]
let k=[1/5,2/5,3/5,4/5]
  let count = 0;
  const countUp = () =>{
    count++;
  }
  const intervalId = setInterval(() =>{
    countUp();
    if(count%i.length==0 ){　
      speed=i[0];
      fps=j[0];
      k=k[0];
    }else if(count%i.length==1){
      speed=i[1];
      fps=j[1];
      k=k[1];
    }else if(count%i.length==2){
      speed=i[2];
      fps=j[2];
      k=k[2];
    }else if(count%i.length==3){
      speed=i[3];
      fps=j[3];
      k=k[3];
  }}, 1000);
shape(4,0,1).mult(osc(15,1/16,300).diff(gradient(1)).kaleid().rotate(Math.PI/4)).modulatePixelate(osc(5).colorama([0,3].ease('easeInOutCubic').fast(1/3)).posterize([0,5].ease('easeInOutQuint').fast(1/5),[0,5].ease('easeInOutQuint').fast(1/5)).hue(()=>Math.sin(time/100),()=>Math.cos(time/100),()=>Math.tan(time/100)).saturate([0,10].smooth().fast(1/10)).brightness([-1,1].ease('easeInOutQuart').fast(1/4))).modulateScale(osc(5)).blend(o0,k).out()
