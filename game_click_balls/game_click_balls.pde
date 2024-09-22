int Balls;
int BallRadius;
int HalfBall;
int maxBallSpeed;

int points;
int speedBonus;
int timeBonus;

int startTime; // time when game starts
int endTime; // time when game ended

float[] x,y,xDelta,yDelta;

// HIGHSCORE //
int highscore = 657;

int BallsRe; //balls remaining

color TextColor = color(255);

int stage; // 0 = menu, 1 = game, 2 = again

// Formatting
int wh, hh;
int lineSize;
int growthLine; // 0 = shrinking, 1 = growing


// Buttons
Sbutton Menu;
Sbutton Again;

void setup() {
  size(800, 800);
  frameRate(60);
  wh = width/2;
  hh = height/2;

  // Ball Settings
  Balls = 10;
  BallRadius = 100;
  HalfBall = BallRadius/2;
  maxBallSpeed = 6;

  // Scores
  points = 0;
  
  // Times:

  // Stages
  stage = 0;
  BallsRe = Balls;

  // Menu:
  lineSize = 1;
  growthLine = 1;

  // Buttons
  Menu = new Sbutton(wh, hh+130, 250, 90, "Play", 40, 6, 12);
  Again = new Sbutton(wh, hh+130, 300, 90, "Play Again", 30, 6, 5);

  x = new float[Balls];
  y = new float[Balls];
  xDelta = new float[Balls];
  yDelta = new float[Balls];

  // Ball Initialization
  for (int i=0; i<Balls; i=i+1) {
    x[i] = random(HalfBall, width-HalfBall);
    y[i] = random(HalfBall, height-HalfBall);

    xDelta[i] = random(-maxBallSpeed, maxBallSpeed);
    yDelta[i] = random(-maxBallSpeed, maxBallSpeed);
  }
}

void draw() {
  background(0);

  if (stage == 0) {
    displayMenu();
  }

  if (stage == 1) {
    displayGame();
    if (BallsRe == 0) {
      stage = 2;
      endTime = int(millis())/1000;
    }
  }

  if (stage == 2) {
    displayAgain();
  }
}


void mousePressed() {
  for (int i=Balls-1; i>=0; i=i-1) {
    float dist = sqrt((x[i]- mouseX)*(x[i]- mouseX)+(y[i]- mouseY)*(y[i]- mouseY));
    if (dist <= BallRadius/2) {
      x[i] = -100;
      y[i] = -100;
      speedBonus = abs(int(xDelta[i]+yDelta[i]));
      timeBonus = int((10000.0/millis())*10);
      points = points + 10 + speedBonus + timeBonus;
      BallsRe--;
      break;
    }
  }
}


void doBallStuff() {
  for (int i=0; i<Balls; i=i+1) {
    fill(200);
    ellipse(x[i], y[i], BallRadius, BallRadius);

    x[i] = x[i] + xDelta[i];
    y[i] = y[i] + yDelta[i];

    if (x[i]>width-BallRadius/2) {
      xDelta[i] = -xDelta[i];
    }
    if (x[i]<BallRadius/2) {
      xDelta[i] = -xDelta[i];
    }
    if (y[i]>height-BallRadius/2) {
      yDelta[i] = -yDelta[i];
    }
    if (y[i]<BallRadius/2) {
      yDelta[i] = -yDelta[i];
    }
  }
}

void displayMenu() {
  Menu.display();
  if (Menu.pressed()) {
    startTime = int(millis())/1000;
    stage = 1;
    return;
  }
  fill(255);
  textSize(50);
  // Title
  text("CLICK BALLS!", wh, hh-100);
  line(wh - lineSize, hh - 90, wh + lineSize, hh - 90);
  if (growthLine == 1) lineSize++;
  if (growthLine == 0) lineSize--;
  if (lineSize == 0) {
    lineSize = 1;
    growthLine = 1;
  }
  if (lineSize == 170) {
    lineSize = 169;
    growthLine = 0;
  }
  // Subtitle
  fill(200);
  textSize(30);
  text("Click all the balls as fast as you can!", wh, hh);
}

void displayGame() {
  // Display Balls and perform Logic:
  doBallStuff();

  // Display Game Stats:
  fill(TextColor);
  textSize(20);
  // POINTS
  text("Points: " + points, 44, 30);
  // TIME
  text("Time: " + (int(millis())/1000 - startTime), width-50, 30);
  // BALLS REMAINING
  text("Balls Remaining: " + BallsRe, 84, 50);
}

void displayAgain() {
  Again.display();
  if (Again.pressed()) {
    stage = 1;
    resetGame();
    return;
  }

  fill(TextColor);
  textSize(50);
  //TEXT GAME OVER
  text("Game Over!", wh, hh-100);
  textSize(30);
  //TEXT SCORE
  text("Score: " + points, wh, hh -50);
  // TIME:
  text("Time: " + (endTime - startTime) + " seconds", wh, hh);
  //TEXT HIGHSCORE
  textSize(15);
  text("Highscore: " + highscore, wh, hh + 40);
}






void resetGame() {
  startTime = int(millis())/1000;
  points = 0;
  BallsRe = Balls;
  for (int i=0; i<Balls; i=i+1) {
    x[i] = random(HalfBall, width-HalfBall);
    y[i] = random(HalfBall, height-HalfBall);

    xDelta[i] = random(-maxBallSpeed, maxBallSpeed);
    yDelta[i] = random(-maxBallSpeed, maxBallSpeed);
  }
}
