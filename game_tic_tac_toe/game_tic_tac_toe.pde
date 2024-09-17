//Game Lines
float[] xl;
float[] yl;

//Game Space Positions
float[] xc;
float[] yc;

//available Spaces: 0=empty,1=cross,2=circle
float[] available;

//Button Array, for placements
ArrayList<button> But;

//Menu Start Button
Sbutton Start;

//PLAY AGAIN BUTTON
Sbutton Again;



// Which turn
int turn;

// Who wins
int win;
boolean someoneWon;
boolean gameIsTied;

// Radius
float R;

// Scores of players
int score1, score2;

int k;
int j;

// Text Locations
int player1Text, player2Text;


// Board Data




void setup() {
  size(800, 800);

  // Initialize:
  turn = 0;
  win = 0;
  R = 30;
  score1 = 0;
  score2 = 0;

  someoneWon = false;
  gameIsTied = false;



  available = new float[9];

  xl = new float[4];
  yl = new float[4];

  xc = new float[3];
  yc = new float[3];

  // Initialize buttons
  But = new ArrayList<button>();

  // Initialize buttons
  Start = new Sbutton(width/2, (height/2)+130, 250, 90, "Play", 30, 6, 5);
  Again = new Sbutton(width/2, (height/2)+130, 250, 90, "Play Again", 30, 50, 10);

  //SETUP LINES
  for (int i = 0; i<4; i++) {
    xl[i] = i*(width)/(4) + width/8;
    yl[i] = i*(width)/(4) + width/8;
  }
  //SETUP SPACE POSITIONS
  for (int i = 0; i<3; i++) {
    xc[i] = (width/8)*(2*i+2);
    yc[i] = (width/8)*(2*i+2);
  }
  // SETUP available
  for (int i = 0; i<9; i++) available[i]= 0; // Initially, all cells are empty

  // SETUP BUTTON
  for (int k = 0; k < 3; k++) {
    for (int j = 0; j<3; j++) {
      But.add(new button(xc[k], yc[j], 40)); // add buttons for playability
    }
  }
}

void draw() {
  background(255);

  //MENU (TURN = 0)
  if (turn == 0) displayMenu();

  // GAME ( TURN 1 OR 2)
  if (turn != 0) {

    displayBoard(); // Displayer Board of Game
    displayScore(); // Displays scoreboard, players, and turns
    displayCrossesAndCircles(); // displays Xs and Os once played.
    checkButtonPresses(); // Checks if someone presses a button, activates cell, changes turn
    
    
    // If someone has no won yet, did someone win?
    if (win == 0) {
      if (checkIfWin(1)) {
        win = 1; // Player 1 won
        score1++;
        someoneWon = true;
      }
      if (checkIfWin(2)) {
        win = 2; // Player 2 won
        score2++;
        someoneWon = true;
      }
    }

    // When a player has won, display who wins, winning line:
    if (someoneWon) {
      // Display text above
      displayWinner(win);

      // Display Winning Line depending on who wins (3 in a row)
      if (win == 1) displayWinningLine(1);
      if (win == 2) displayWinningLine(2);
    }


    if (checkIfTied()) {
      gameIsTied = true;
      displayTie();
    }

    // If Game has ended, Ask to play again:
    if (someoneWon || gameIsTied) {
      playAgain();
    }
  }
}



// Displays initial menu
void displayMenu() {
  fill(0);

  // Tic Tac Toe
  stroke(2);
  textAlign(CENTER);
  textSize(50);
  text("Tic Tac Toe", width/2, 50);

  // Underline
  stroke(1);
  line(width/2-110, 60, width/2+110, 60);

  // Menu
  stroke(2);
  textAlign(CENTER);
  textSize(40);
  text("Menu", width/2, 150);

  // Button
  Start.display();
  if (Start.pressed()) turn = 1; // Start game if pressed

  //XO MENU
  // Display X
  int Xlength = 110; // length of one of the X lines
  int Xwidth = 20; // width of one of the x lines
  fill(0);
  noStroke();
  pushMatrix();
  translate(width*3/8, height*3/8);
  //ellipse(0, 0, 20, 20);
  rectMode(CENTER);
  rotate(45*PI/180);
  rect(0, 0, Xwidth, Xlength);
  rotate(90*PI/180);
  rect(0, 0, Xwidth, Xlength);
  popMatrix();

  // Display O
  int outerCircleRadius = 100;
  int circleWidth = 30;
  int innerCircleRadius = outerCircleRadius - circleWidth;
  fill(0);
  noStroke();
  pushMatrix();
  translate(width*5/8, height*3/8);
  ellipse(0, 0, outerCircleRadius, outerCircleRadius);
  fill(255);
  ellipse(0, 0, innerCircleRadius, innerCircleRadius);
  popMatrix();
}

// Display Score, Player, Player Turns
void displayScore() {
  int playerHeight = height-75;
  int scoreHeight = height - 50;
  int scoreDistance = 100;
  int mid = width/2;

  //Player Text
  textSize(20);
  fill(0, 100);
  text("Player One", 100, playerHeight);
  text("Player Two", width-100, playerHeight);

  // Player turn (slightly darker) (w == 0 since nobody has won)
  if (turn == 1 && win == 0) {
    textSize(20);
    fill(0);
    text("Player One", 100, playerHeight);
  }
  if (turn == 2 && win == 0) {
    textSize(20);
    fill(0);
    text("Player Two", width-100, playerHeight);
  }

  // Score Text with Scores
  fill(0);
  textSize(30);
  text("Score: ", mid, scoreHeight);
  text(score1, mid - scoreDistance, scoreHeight);
  text(score2, mid + scoreDistance, scoreHeight);
}


void displayWinner(int p) {
  int textHeight = 50;
  int lineHeight = 60;
  int lineStart = width/2 - 140;
  int lineEnd = width/2 + 140;

  textSize(30);

  if (p == 1) {
    fill(255, 0, 0);
    text("PLAYER ONE WINS", width/2, textHeight);
    stroke(0);
    fill(0);
    line(lineStart, lineHeight, lineEnd, lineHeight);
  } else if (p == 2) {
    fill(255, 0, 0);
    text("PLAYER TWO WINS", width/2, textHeight);
    stroke(0);
    fill(0);
    line(lineStart, lineHeight, lineEnd, lineHeight);
  }
}


void displayTie() {
  int textHeight = 50;
  int lineHeight = 60;
  int lineStart = width/2 - 70;
  int lineEnd = width/2 + 70;
  
  fill(255, 0, 0);
  textSize(30);
  text("IT'S A TIE!", width/2, textHeight);
  stroke(0);
  fill(0);
  line(lineStart, lineHeight, lineEnd, lineHeight);
}

// Displays Board of the game
void displayBoard() {
  //SETUP & LINES
  pushMatrix();
  translate(0, 0);
  popMatrix();
  //ORRIZONTAL LINES
  fill(0);
  stroke(0);
  line(xl[0], yl[1], xl[3], yl[1]);
  line(xl[0], yl[2], xl[3], yl[2]);
  //VERTICAL LINES
  line(xl[1], yl[0], xl[1], yl[3]);
  line(xl[2], yl[0], xl[2], yl[3]);
}

void playAgain() {
  Again.display();
  if (Again.pressed()) {
    win = 0;
    someoneWon = false;
    gameIsTied = false;

    for (int i = 0; i < 9; i++) {
      available[i]= 0;
    }
  }
}


// Display Cross at location i
void displayCross(int i) {
  if (i<3) k = 0;
  if (i>2 && i<6) k = 1;
  if (i>5 && i<9) k = 2;
  if (i+1==1||i+1==4||i+1==7) j = 0;
  if (i+1==2||i+1==5||i+1==8) j = 1;
  if (i+1==3||i+1==6||i+1==9) j = 2;

  fill(0);
  noStroke();
  pushMatrix();
  translate(xc[k], yc[j]);
  ellipse(0, 0, 20, 20);
  rectMode(CENTER);
  rotate(45*PI/180);
  rect(0, 0, 15, 90);
  rotate(90*PI/180);
  rect(0, 0, 15, 90);
  popMatrix();
}

// Display Circle at location i
void displayCircle(int i) {
  if (i<3) k = 0;
  if (i>2 && i<6) k = 1;
  if (i>5 && i<9) k = 2;
  if (i+1==1||i+1==4||i+1==7) j = 0;
  if (i+1==2||i+1==5||i+1==8) j = 1;
  if (i+1==3||i+1==6||i+1==9) j = 2;

  fill(0);
  noStroke();
  pushMatrix();
  translate(xc[k], yc[j]);
  ellipse(0, 0, 80, 80);
  fill(255);
  ellipse(0, 0, 60, 60);
  popMatrix();
}


void displayCrossesAndCircles() {
  // AVALABILITY (0) // SET CROSS (1) OR CIRCLE (2)
  for (int i = 0; i < 9; i++) {
    // if cross (1) in location i , display cross
    if (available[i] == 1) displayCross(i);

    // if circle (2) in location i, display circle
    if (available[i] == 2) displayCircle(i);
  }
}



void checkButtonPresses() {
  // PRESS BUTTON TURNS
  for (int i = 0; i < 9; i++) {
    But.get(i).display();
    if (But.get(i).pressed() && available[i] == 0 && turn == 1 && win == 0) {
      available[i] = 1;
      turn = 2;
    }
    if (But.get(i).pressed() && available[i] == 0 && turn == 2 && win == 0) {
      available[i] = 2;
      turn = 1;
    }
  }
}



// Check if player p has 3 in a row
boolean checkIfWin(int p) {
  // 8 possible combinations to check
  if ((available[0]==p && available[1]==p && available[2]==p) ||
    (available[3]==p && available[4]==p && available[5]==p) ||
    (available[6]==p && available[7]==p && available[8]==p) ||
    (available[0]==p && available[3]==p && available[6]==p) ||
    (available[1]==p && available[4]==p && available[7]==p) ||
    (available[2]==p && available[5]==p && available[8]==p) ||
    (available[0]==p && available[4]==p && available[8]==p) ||
    (available[6]==p && available[4]==p && available[2]==p)) {
    return true;
  }
  return false;
}

// Check if the game is tied
boolean checkIfTied() {
  if ((available[0] != 0) && (available[1] != 0) &&
    (available[2] != 0) && (available[3] != 0) &&
    (available[4] != 0) && (available[5] != 0) &&
    (available[6] != 0) && (available[7] != 0) &&
    (available[8] != 0) && !someoneWon) {
    return true;
  }
  return false;
}


// Display Winning Line, for player (p)
void displayWinningLine(int p) {

  //3 in a row Line
  rectMode(CENTER);
  fill(0, 100);
  noStroke();

  //ORIZONTAL LINE
  if ((available[0]==p) && (available[3]==p) && (available[6]==p)) {
    rect(xc[1], yc[0], xl[3]-xl[0], R);
  }
  if (available[1]==p && available[4]==p && available[7]==p) {
    rect(xc[1], yc[1], xl[3]-xl[0], R);
  }
  if (available[2]==p && available[5]==p && available[8]==p) {
    rect(xc[1], yc[2], xl[3]-xl[0], R);
  }


  //VERTICAL LINE
  if ((available[0]==p) && (available[1]==p) && (available[2]==p)) {
    rect(xc[0], yc[1], R, yl[3]-yl[0]);
  }
  if (available[3]==p && available[4]==p && available[5]==p) {
    rect(xc[1], yc[1], R, yl[3]-yl[0]);
  }
  if (available[6]==p && available[7]==p && available[8]==p) {
    rect(xc[2], yc[1], R, yl[3]-yl[0]);
  }

  //DIAGONAL LINE
  if (available[0]==p && available[4]==p && available[8]==p) {
    pushMatrix();
    translate(xc[1], yc[1]);
    rotate(-45*PI/180);
    rect(0, 0, R, (yl[3]-yl[0])* sqrt(2)-20);
    popMatrix();
  }
  if (available[2]==p && available[4]==p && available[6]==p) {
    pushMatrix();
    translate(xc[1], yc[1]);
    rotate(45*PI/180);
    rect(0, 0, R, (yl[3]-yl[0])* sqrt(2)-20);
    popMatrix();
  }
}
