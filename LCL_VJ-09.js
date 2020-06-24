animationStyle motionBlur
simpleGradient(random(pink,magenta,red),random(orange,yellow,yellowgreen,green),random(cyan,blue,purple))
2500.times
	noStroke rotate white box 0.1,0.1,0.1
	noStroke move black ball 0.1,0.1,0.1
	noStroke scale gray peg 0.01
	rotate 0.1
	move

animationStyle motionBlur
simpleGradient(random(white,silver,grey,gold,black)%15,random(white,silver,grey,gold,black)%9,random(white,silver,grey,gold,black)%6)
move
noStroke
10.times
	rotate time/1000,frame/50
	if frame % 5 == 1
		red box
	if frame % 5 == 2
		blue ball
	if frame % 5 == 3
		yellow peg
	if frame % 5 == 4
		green line
	if frame % 5 == 5
		rect color