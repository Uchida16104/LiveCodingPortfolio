let libs = ['https://unpkg.com/hydra-synth', 'includes/libs/hydra-synth.js']

let hc = document.createElement('canvas')
hc.width = 640
hc.height = 360
let hydra = new Hydra({
	detectAudio: false,
	canvas: hc,
	makeGlobal: false,
	autoLoop: false
})
let synth = hydra.synth

let pg


synth.gradient(1).colorama(0.05).invert()
.add(synth.shape(2).scale(1.1).scrollY([1/3,2/3,3,3].ease('easeInOutQuint').fast(4)).mult(synth.osc(30,1/8,300).r(3).invert()).scrollX([0,1].smooth().fast(1)),[0,1].reverse().smooth().fast(3))
.add(synth.shape(2).scale(1.1).scrollY([2/3,3/3,1/3].ease('easeInOutQuint').fast(4)).mult(synth.noise(5).thresh()).scrollX([0,1].smooth().fast(3)),[0,1].reverse().smooth().fast(6))
.add(synth.shape(2).scale(1.1).scrollY([3/3,1/3,2/3].ease('easeInOutQuint').fast(4)).mult(synth.voronoi(5,1,1).luma()).scrollX([0,1].smooth().fast(2)),[0,1].reverse().smooth().fast(2))
.out()

function setup() {
	createCanvas(windowWidth, windowHeight, WEBGL)
	background(0)
	pg = createGraphics(hc.width, hc.height)
	noStroke()
}

function draw() {
	hydra.tick(1.5)

	pg.clear()
	pg.drawingContext.drawImage(hc, 0, 0, pg.width, pg.height)
	texture(pg)

	//plane(width, height)

	rotateX(radians(frameCount / 8))
	rotateZ(radians(-frameCount / 6))
	box(height/3)
}
