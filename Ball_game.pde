
void setup() {
  size(480, 480);
  //fullScreen(); 
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
    if (currentBall.pos.y < height && !currentBall.proximate) {
      currentBall.applyForce(gravity);
    }
    for (int j = balls.size()-1; j > 0; j = j - 1)
    {
      if (i != j)
      {    
        currentBall.checkBallCollision(balls.get(j));
      }
    }
    currentBall.checkResting();
    currentBall.display();  
  }
}

void mouseClicked() {
  balls.add(newMouseBall());
}

PVector newRandomVelocity() {  
  PVector randomVelocity = new PVector(0, 0);
  randomVelocity.x = random(-10, 10);
  randomVelocity.y = random(-25, 0);

  return randomVelocity;
}

Ball newMouseBall() {

  Ball newBall = new Ball(null, null);
  PVector newBallPos = new PVector(0, 0);
  newBallPos.x = mouseX;
  newBallPos.y = mouseY;
  newBall.pos = newBallPos;
  newBall.diameter = random(1, 50);
  newBall.applyForce(newRandomVelocity());
  //newBall.elasticCoefficient = random(0, 1);
  newBall.ballFill = color(random(100), 100, 100);
  return newBall;
}