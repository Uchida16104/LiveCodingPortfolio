var name = 'jiro'
var age = 65
var gender = 0
var country = 1
var fx = 'art'
var value = 1
var perform = 1
var stain = 'wish'
var amount = 1
setFunction({
	name: name,
	type: 'src',
	inputs: [{
			name: 'age',
			type: 'float',
			default: age
		},
		{
			name: 'gender',
			type: 'float',
			default: 0
		},
		{
			name: 'country',
			type: 'float',
			default: country
		}
	],
	glsl: `
      vec2 st = _st;
      float r = sin(st.x+cos(age))+cos(st.y-sin(gender))-tan(country);
      float g = acos(age+asin(st.y))-asin(gender-acos(st.x))+atan(country);
      float b = pow(tan(age)*st.x,atan(gender)*st.y)+country;
      return vec4(r,g,b,1.0);
      `
})
setFunction({
	name: fx,
	type: 'coord',
	inputs: [{
			name: 'kind',
			type: 'float',
			default: value
		},
		{
			name: 'act',
			type: 'float',
			default: perform
		}
	],
	glsl: `
   vec2 xy = _st - vec2(_st.x*_st.y);
   float fulfill = pow(sin(_st.x+kind),cos(_st.y+act));
   xy = mat2(sin(fulfill),cos(fulfill), tan(fulfill),pow(asin(fulfill*_st.x+xy-kind),acos(fulfill*_st.y-xy+kind)))*xy;
   xy += 0.5;
   return vec2(xy);
  `
})
setFunction({
	name: stain,
	type: 'color',
	inputs: [{
			name: 'vivid',
			type: 'float',
			default: 1
		},
		{
			name: 'charm',
			type: 'float',
			default: 1
		}
	],
	glsl: `
  vec4 c2 = sin(_c0+vivid*cos(_c0+charm));
  c2 += acos(c2)/asin(c2);
  c2 = floor(c2);
  c2 *= fract(sin(c2-vec4(charm))+cos(c2-vec4(vivid)));
  c2 -= asin(vec4(vivid))+acos(vec4(charm));
  c2 /= vec4(vivid*charm);
  c2 = sqrt(c2+vivid*charm);
  return vec4(c2.xyz,_c0.rgba);
  `
})

function modulator(name0, name1, a, b, c, d, e, f) {
	if (name0 === Math.atan2 || name0 === Math.hypot || name0 === Math.imul || name0 === Math.max || name0 === Math.min || name0 === Math.pow) {
		func0 = (a, f) => name0(time / a, time % f);
		func1 = (e) => name1(time % e);
		func2 = (a, b, c, d, e, f) => func0(a, f) ** b > c ? d : -func1(e);
		return func2(a, b, c, d, e, f);
	} else if (name1 === Math.atan2 || name1 === Math.hypot || name1 === Math.imul || name1 === Math.max || name1 === Math.min || name1 === Math.pow) {
		func0 = (a) => name0(time / a);
		func1 = (e, f) => name1(time % e, time / f);
		func2 = (a, b, c, d, e, f) => func0(a) ** b > c ? d : -func1(e, f);
		return func2(a, b, c, d, e, f);
	} else {
		func0 = (a) => name0(time / a);
		func1 = (e) => name1(time % e);
		func2 = (a, b, c, d, e) => func0(a) ** b > c ? d : -func1(e);
		return func2(a, b, c, d, e);
	}
};

function amp() {
	return "pow(sin(st.x),cos(st.y))";
}

function mix() {
	return "tan(st.y/st.x)";
}

function ishihara() {
	return "pow(sin(st.y),cos(st.x))/tan(acos(st.x)/asin(st.y))";
}
p5 = new P5({
	mode: 'WEBGL'
})
let i = 0;
let j = 50;
p5.hide()
s0.initCam()
s1.init({
	src: p5.canvas
})
p5.draw = () => {
	p5.background(0);
	p5.noStroke();
	p5.rotateX(time / 2);
	p5.rotateY(time / 3);
	p5.rotateZ(time / 5);
	p5.scale(p5.width / 3600);
	for (i = 0; i < j; i++) {
		p5.translate(i - j, i, i + j);
		p5.ellipsoid(30, 40, 40, 12, j);
	}
}
professor = () => src(o0)
	.mult(shape("pow(atan(st.x/st.y),tan(st.y/st.x))")
		.repeat("asin(st.y)", "acos(st.x)"))
	.pixelate("sin(st.x)", "cos(st.y)")
hsb = () => src(o0)
	.hue("sin(st.x)", "cos(st.y)", "tan(st.y/st.x)")
	.saturate("asin(st.y)")
	.brightness("acos(st.x)")
rgba = () => src(o0)
	.r("asin(st.y)")
	.g("acos(st.x)")
	.b("atan(st.x/st.y)")
	.a("tan(st.y/st.x)")
collaborate = () => src(s0)
jiro([amount, 10].smooth()
		.fast(amount / 10), [amount, 10].smooth()
		.fast(amount / 10), "pow(sin(st.x),cos(st.y))*tan(st.x/st.y)")
	.modulate(professor(), ishihara())
	.rotate("sin(st.x)", "cos(st.y)")
	.scale("st.y/st.x", amount / 10)
	.invert("st.x")
	.invert("st.y")
	.shift("cos(st.x)", "sin(st.y)", "asin(st.y)", "acos(st.x)")
	//.rotate(modulator(Math.sin,Math.tan,10,10,1,2,2))
	//.pixelate(amp(),mix())
	.diff(src(o0)
		.art("exp(st.y)/log(st.x)*pow(sin(st.x),cos(st.y))*atan(st.x,st.y)"))
	.diff(hsb())
	.diff(rgba())
	.scale(2, 3, amount)
	.wish(3 / 10, amount / 5)
	.invert()
	.blend(o0, amount - (amount / 20))
	//.layer(collaborate().sub(hsb().mask(rgba())))
	//.add(s1)
	.out()
//screencap()
