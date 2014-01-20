/*===================================================
  Tree object
  =================================================== */

class Treelimb {
	// a limb spawns branches

	// branch generation
	int nBranches = 6;
	float branchAngleOffset = 0; //deg
	float branchAngleSpacing = 60; //deg
	float branchSizeRatio = .3;

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
	}

	void generateBranches() {
		float len = limbLength * branchSizeRatio;
		float branchX = getBranchOffsetX(limbLength);
		float branchY = getBranchOffsetY(limbLength);

		for(int i = 0; i < nBranches; i++) {
		 	float angle = limbAngle + branchAngleOffset + i*branchAngleSpacing;

		 	branches[i] = new Treelimb(len, angle, branchX, branchY );
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
		return rootY + len * sin( radians(limbAngle) );		
	} 

	Treelimb[] getBranches() {
		return branches;
	}


}