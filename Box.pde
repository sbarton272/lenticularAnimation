// rectangles

class Box {
	
	float startX, startY, endX, endY, boxHeight, boxWidth, cornerRadius;
	color clr;

	Box(float startX, float startY, float endX, float endY, float boxHeight, float boxWidth, color clr) {

		this.startX = startX;
		this.startY = startY;
		this.endX = endX;
		this.endY = endY;
		this.boxHeight = boxHeight;
		this.boxWidth = boxWidth;
		
		this.clr = clr;
		this.cornerRadius = 2;
	}

	void drawBox(float percent) {
		float curX = map(percent, 0, 1, startX, endX);
		float curY = map(percent, 0, 1, startY, endY);

		fill(clr);
		rect(curX, curY, boxWidth, boxHeight, cornerRadius);
	}



}