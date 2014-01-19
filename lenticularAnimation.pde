
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
 
int     nFramesInLoop = 30; // for lenticular export, change this to 10!
int     nElapsedFrames;
boolean bRecording; 

String imgName = "trees";

int frameSize = 500;

Treelimb trunk;
  
/*===================================================
  Setup
  =================================================== */

void setup() {
  size (500, 500); 
  bRecording = false;
  nElapsedFrames = 0;
  frameRate (nFramesInLoop); 
  trunk = new Treelimb( 100.0, 90.0, 250.0, 30.0);
}

/*===================================================
  Keyboard Interupt
  =================================================== */

void keyPressed() { 
  // Press a key to export frames to the output folder
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
  background (180);
  smooth(); 
  stroke (0, 0, 0); 
  strokeWeight (2); 
 
  trunk.drawLimbFull();
}

/*===================================================
  Tree object
  =================================================== */

class Treelimb {
	// a limb spawns branches

	// branch generation
	int nBranches = 2;
	float branchAngleOffset = -45; //deg
	float branchAngleSpacing = 90; //deg
	float branchSizeRatio = .5;

	// limb vars
	float limbLength;
	float limbAngle; // deg
	float rootX;
	float rootY;
	Treelimb[] branches;

	Treelimb( float limbLength, float limbAngle, float rootX, float rootY ) {
		this.limbLength = limbLength;
		this.limbAngle = limbAngle;
		this.rootX = rootX;
		this.rootY = rootY;
		this.branches = new Treelimb[nBranches];
		generateChildren();
	}

	void generateChildren() {
		float len = limbLength * branchSizeRatio;
		float branchX = getBranchOffsetX(limbLength);
		float branchY = getBranchOffsetY(limbLength);

		for(int i = 0; i < nBranches; i++) {
			float angle = limbAngle + branchAngleOffset + i*branchAngleSpacing;

			branches[i] = Treelimb(len, angle, branchX, branchY );
		}
	}

	void drawLimbPercent(float percentage) {
		float len = percentage * limbLength;
		line(rootX, rootY, getBranchOffsetX(len), getBranchOffsetY(len) );
	}

	void drawLimbFull() {
		drawLimbPercent(1);
	}

	float getBranchOffsetX(float len) {
		return rootX + len * cos( radians(limbAngle) );
	} 	

	float getBranchOffsetY(float len) {
		return rootX + len * sin( radians(limbAngle) );		
	} 

	Treelimb[] getBranches() {
		return branches;
	}


}