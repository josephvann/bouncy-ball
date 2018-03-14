
void setup() {
  size(640, 480);
  colorMode(HSB, 100);
  background(0, 0, 0);
  balls = new ArrayList<Ball>();
}

void draw() {
  clear();  
  for (int i = 0; i < balls.size(); i = i + 1)
  {
    fill(0, 0, 100);
    Ball currentBall = balls.get(i);
    currentBall.checkWallCollision();
    if (currentBall.pos.y < height) {
      currentBall.applyForce(gravity);
    }
    currentBall.display();
  }
}

void mouseClicked() {
  balls.add(newMouseBall());
  println(balls.size());  
}

PVector newRandomVelocity() {  
  PVector randomVelocity = new PVector(0, 0);
  randomVelocity.x = random(-10, 10);
  randomVelocity.y = random(-10, 10);
  return randomVelocity;
}

Ball newMouseBall() {

  Ball newBall = new Ball(null, null);
  PVector newBallPos = new PVector(0, 0);
  newBallPos.x = mouseX;
  newBallPos.y = mouseY;
  newBall.pos = newBallPos;
  newBall.diameter = random(10, 30);
  newBall.applyForce(newRandomVelocity());
  //newBall.elasticCoefficient = random(0, 1);
  newBall.ballFill = color(random(100), 100, 100);
  return newBall;
}