
/* Spencer Barton
 * Interactive Art & Computational Design, Spring 2014
 * 1.1 Lenticular Animation
 * 
 * Trees
 * Starter code from http://golancourses.net/2014/assignments/project-1/lenticular-animation/
 */

 
/*===================================================
  Global variables. 
  =================================================== */
 
int     nFramesInLoop = 50; // for lenticular export, change this to 10!
int     nElapsedFrames;
boolean bRecording; 

String imgName = "trees";

int frameSize = 500;

Treelimb trunk;
  
/*===================================================
  Setup
  =================================================== */

void setup() {
  size (frameSize, frameSize); 
  bRecording = false;
  nElapsedFrames = 0;
  frameRate (nFramesInLoop); 
  trunk = new Treelimb( 300.0, 90.0, 0, 10);
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
  
  translate(frameSize/2, frameSize);
  rotate(radians(180)); // calculate tree from regular cartesian
  scale(-1.0, 1.0); // flip X

  int depth = 3;

  drawBranches(trunk, depth, percent);


}

void drawBranches(Treelimb trunk, int depth, float percent) {
    if( depth == 0) { return; }

    depth--;
    trunk.drawLimbPercent(percent);
    trunk.generateBranches();

    for(Treelimb limb: trunk.getBranches()) {
        drawBranches(limb, depth, percent);
    }
    
}