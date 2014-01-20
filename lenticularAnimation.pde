
/* Spencer Barton
 * Interactive Art & Computational Design, Spring 2014
 * 1.1 Lenticular Animation
 * 
 * Boxes
 * Starter code from http://golancourses.net/2014/assignments/project-1/lenticular-animation/
 */

 
/*===================================================
  Global variables. 
  =================================================== */

int frameSize = 500; 
int     nFramesInLoop = 50; // for lenticular export, change this to 10!
int     nElapsedFrames;
boolean bRecording; 

String imgName = "boxes";

Box[] boxes;
  
/*===================================================
  Setup
  =================================================== */

void setup() {
  size (frameSize, frameSize); 
  bRecording = false;
  nElapsedFrames = 0;
  frameRate (nFramesInLoop);

  boxes = new Box[1];
  boxes[0] = new Box(10, 10, 100, 100, 30, 50);
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
    percentCompleteFraction = (float) nElapsedFrames / (float)nFramesInLoop;
  } else {
    float modFrame = (float) (frameCount % nFramesInLoop);
    percentCompleteFraction = modFrame / (float)nFramesInLoop;
  }
 
  // Render the design, based on that percentage. 
  renderMyDesign (percentCompleteFraction);
 
  // If we're recording the output, save the frame to a file. 
  if (bRecording) {
    saveFrame("output/"+ imgName + "-loop-" + nf(nElapsedFrames, 4) + ".png");
    nElapsedFrames++; 
    if (nElapsedFrames == nFramesInLoop) {
      bRecording = false;
    }
  }
}
 
/*===================================================
  Draw
  =================================================== */

void renderMyDesign (float percent) {
 
  //----------------------
  // here, I set the background and some other graphical properties
  background(0);
  smooth(); 
  stroke (255); 
  strokeWeight (3);

  for( Box box : boxes ) {
    box.drawBox(percent);
  }

}