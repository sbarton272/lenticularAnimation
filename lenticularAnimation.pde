
/* Spencer Barton
 * Interactive Art & Computational Design, Spring 2014
 * 1.1 Lenticular Animation
 * 
 * Boxes
 * Starter code from http://golancourses.net/2014/assignments/project-1/lenticular-animation/
 */

 
/*===================================================
  Global variables & constants
  =================================================== */

int FRAME_SIZE = 500; 
int NUM_FRAMES_IN_LOOP = 50; // for lenticular export, change this to 10!
color STROKE_CLR = 255;
int STROKE_WEIGHT = 0;
String IMG_NAME = "boxes";
float GRID_LENGTH = 30;
float BOX_WIDTH = GRID_LENGTH;
float BOX_HEIGHT = 2*GRID_LENGTH;
int NUM_BOX_TYPES = 4;

int nElapsedFrames;
boolean bRecording; 
Box[] boxes;


/*===================================================
  Setup
  =================================================== */

void setup() {
  size (FRAME_SIZE, FRAME_SIZE); 
  bRecording = false;
  nElapsedFrames = 0;
  frameRate (NUM_FRAMES_IN_LOOP);

  generateBoxes();
}

void generateBoxes() {

  int nBoxesSide = (int)round(FRAME_SIZE / BOX_HEIGHT);
  nBoxesSide = nBoxesSide + nBoxesSide % 2 + 2; // round up to nearest power of 2 and add 2 for good measure
  int nOneTypeBoxPerSide = nBoxesSide / 2;

  boxes = new Box[nBoxesSide * nBoxesSide];

  // generate individual boxes
  float startX, startY, endX, endY, boxHoriz, boxVert, difference;
  int index = 0;
  for( int t = 0; t < NUM_BOX_TYPES; t++ ) {
    for( int i = 0; i < nOneTypeBoxPerSide; i++) {
      for( int j = 0; j < nOneTypeBoxPerSide; j++) {

        startX = j*2*BOX_HEIGHT;
        startY = i*2*BOX_HEIGHT;
        endX = startX;
        endY = startY;
        difference = BOX_HEIGHT - BOX_WIDTH;
        boxHoriz = BOX_HEIGHT;
        boxVert = BOX_WIDTH;
        color clr = color(255,0,0);

        switch (t) {
          case(0):
            // horiz, left
            endX = startX - difference;
            break;
          case(1):
            // horiz, right 
            startX += BOX_WIDTH;
            startY += BOX_HEIGHT;
            endX = startX + difference;
            endY = startY;
            clr = color(255,255,0);
            break;
          case(2):
            startX += BOX_HEIGHT;
            endX = startX;
            endY = startY - difference;
            boxHoriz = BOX_WIDTH;
            boxVert = BOX_HEIGHT;
            clr = color(0,255,0);
            break;
          case(3):
            startY += BOX_WIDTH;
            endY = startY +  difference;
            boxHoriz = BOX_WIDTH;
            boxVert = BOX_HEIGHT;
            clr = color(0,0,255);
            break;
        }


        boxes[index] = new Box(startX, startY, endX, endY, boxVert, boxHoriz, clr);
        index++;

      }
    }
  }
}

/*===================================================
  Keyboard Interupt
  =================================================== */

void keyPressed() { 
  // Press a key to export frames to the output folder
  println("Recording");
  bRecording = true;
  nElapsedFrames = 0;
}
 
/*===================================================
  Draw
  =================================================== */
void draw() {
 
  // Compute a percentage (0...1) representing where we are in the loop.
  float percentCompleteFraction = 0; 
  
  if (bRecording) {
    percentCompleteFraction = (float) nElapsedFrames / (float)NUM_FRAMES_IN_LOOP;
  } else {
    float modFrame = (float) (frameCount % NUM_FRAMES_IN_LOOP);
    percentCompleteFraction = modFrame / (float)NUM_FRAMES_IN_LOOP;
  }
 
  // Render the design, based on that percentage. 
  renderMyDesign ( percentCompleteFraction );
 
  // If we're recording the output, save the frame to a file. 
  if (bRecording) {
    saveFrame("output/"+ IMG_NAME + "-loop-" + nf(nElapsedFrames, 4) + ".png");
    nElapsedFrames++; 
    if (nElapsedFrames == NUM_FRAMES_IN_LOOP) {
      bRecording = false;
    }
  }
}
 
/*===================================================
  Draw
  =================================================== */

void renderMyDesign (float percent) {
 
  background(0);
  smooth(); 
  stroke (STROKE_CLR); 
  strokeWeight (STROKE_WEIGHT);

  float transX = -BOX_HEIGHT * percent;
  float transY = -BOX_HEIGHT * percent;
  translate(transX, transY);

  for( Box box : boxes ) {
    box.drawBox(percent);
  }

}

