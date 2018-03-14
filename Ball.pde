ArrayList<Ball> balls = new ArrayList<Ball>();
PVector gravity = new PVector(0, 1);

class Ball {
  PVector pos = new PVector(0, 0);
  PVector deltapos = new PVector(0, 0);
  int collision = 0;
  // wrap allows balls to pass off side of screen, wrap being false makes balls bounce.
  boolean wrap = true;  
  float diameter = 20;
  float elasticCoefficient = 0.79;
  float wallFriction = 0.1;
  float floorFriction = 0.2;
  color ballFill = color(100, 0, 100);


  Ball(PVector pos, PVector deltapos) {
    this.pos = pos;
  }


  void applyForce(PVector force) {
    this.deltapos.add(force);
  }

  void checkWallCollision() {

    // floor + ceiling
    if (this.pos.y >= height-(diameter/2) || this.pos.y <= diameter/2) {  
      deltapos.y *= -elasticCoefficient;
      deltapos.x *= 1-floorFriction;
    }
    // walls
    if (this.pos.x >= width-(diameter/2) || this.pos.x <= diameter/2) {
      deltapos.x *= -elasticCoefficient;
      deltapos.y *= 1-wallFriction;
    }
  }
  void display() {
    this.pos.add(deltapos);
    this.pos.x = constrain(this.pos.x, this.diameter/2, width-(this.diameter/2));
    this.pos.y = constrain(this.pos.y, this.diameter/2, height-(this.diameter/2));
    noStroke();
    fill(ballFill);
    ellipse(this.pos.x, this.pos.y, this.diameter, this.diameter);
  }
}