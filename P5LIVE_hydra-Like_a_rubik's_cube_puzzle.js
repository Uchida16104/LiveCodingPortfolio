let libs = ['https://unpkg.com/hydra-synth', 'includes/libs/hydra-synth.js']

let hc = document.createElement('canvas')
hc.width = 640
hc.height = 360
let hydra = new Hydra({detectAudio: false,canvas: hc})

let pg

src(o1).diff(src(o1).scale(.99)).add(src(o1).scale(1.01).sub(src(o1).scale(.99))).diff(src(o0).rotate(Math.PI/2)).modulate(src(o1).scale(1.01).thresh(),[0,1].smooth().fast(1/2)).out()
osc(10,1/8,300).modulateScale(osc(10,1/8,300).thresh()).modulateScale(osc(10,1/8,300).luma()).out(o1)

function setup() {
	createCanvas(windowWidth, windowHeight, WEBGL)
	background(0)
	pg = createGraphics(hc.width, hc.height)
	noStroke()
}

function draw() {
	pg.clear()
	pg.drawingContext.drawImage(hc, 0, 0, pg.width, pg.height)
	texture(pg)

	plane(width, height)

	rotateX(radians(frameCount / 8))
	rotateY(radians(frameCount / 4))
	rotateZ(radians(frameCount / 2))
	box(width/16*4,height/9*4)
}
