ArrayList<Ball> balls = new ArrayList<Ball>();
PVector gravity = new PVector(0, 0.5);

class Ball {
  PVector pos = new PVector(0, 0);
  PVector deltaPos = new PVector(0, 0);
  float minDeltaPos = 0.2;
  int collision = 0;
  boolean proximate = false;
  float diameter = 20;
  float elasticCoefficient = 0.8;
  float wallFriction = 0.1;
  float floorFriction = 0.2;
  float overlapCorrection = 1.2;
  color ballFill = color(100, 0, 100);


  Ball(PVector pos, PVector deltaPos) {
    this.pos = pos;
  }


  void applyForce(PVector force) {
    this.deltaPos.add(force);
  }
  void immobilise() {
    this.deltaPos = new PVector(0, 0);
  }
  void checkWallCollision() {

    // floor + ceiling
    if (this.pos.y >= height-(diameter/2) || this.pos.y <= diameter/2) {  
      deltaPos.y *= -elasticCoefficient;
      deltaPos.x *= 1-floorFriction;
    }
    // walls
    if (this.pos.x >= width-(diameter/2) || this.pos.x <= diameter/2) {
      deltaPos.x *= -elasticCoefficient;
      deltaPos.y *= 1-wallFriction;
    }
  }
  void checkResting() {
    if (abs(this.deltaPos.x) < minDeltaPos) {
      this.deltaPos.x = 0;
    }
    if (abs(this.deltaPos.y) < minDeltaPos) {
      this.deltaPos.y = 0;
    }
  }

  void checkBallCollision(Ball otherBall) {
    float objectSpeed = this.deltaPos.mag();
    float subjectSpeed = otherBall.deltaPos.mag();

    PVector distance = PVector.sub(otherBall.pos, this.pos); 
    float distanceMag = distance.mag();
    float minDistance = (this.diameter/2)+(otherBall.diameter/2);

    if (distanceMag < minDistance) {
      this.proximate = true;
      otherBall.proximate = true;
      float theta = distance.heading();
      this.immobilise();
      otherBall.immobilise();
      this.deltaPos = PVector.fromAngle(theta+PI).mult(objectSpeed*(this.elasticCoefficient)*this.overlapCorrection);
      otherBall.deltaPos = PVector.fromAngle(theta).mult(subjectSpeed*(otherBall.elasticCoefficient)*otherBall.overlapCorrection);
      this.display();
      otherBall.display();
    } else {
      this.proximate = false;
      otherBall.proximate = false;
    }
  }



  void display() {
    this.pos.add(deltaPos);
    this.pos.x = constrain(this.pos.x, this.diameter/2, width-(this.diameter/2));
    this.pos.y = constrain(this.pos.y, this.diameter/2, height-(this.diameter/2));
    noStroke();
    fill(ballFill);
    ellipse(this.pos.x, this.pos.y, this.diameter, this.diameter);
  }
}