

// 3D array of availability of location. 0=free, 1=player1, 2=player2
float[][][] free;

//Button Array
ArrayList<button> But;

// sphere points x, y, z
float[] Cx, Cy, Cz;

//pillars
Cylinder cyl; // pillars

// Buttons
Sbutton Start; // Start Game
Sbutton choose; // chooseMode to play turn
Sbutton View; // View from above
Sbutton Again; // Play again

// Turn Buttons
int buttonX, buttonY;

// Button Cooldown
int cooldown;
int clicked;

int turn; // turns, 0=menu,1-2 = players
int chooseMode; // viewing mode (either rotating or above)
int win; // 0=active game, 1=player1 wins, 2= player2 wins, 3=tie
int score1; 
int score2;
int stage; // game stage, 0=menu, 1=activegame, 2=End

int j,k,l; // needed to determine ball layer 
float rot; // rotation of board

//Colors;
color woodColor = color(225, 198, 153);
color background = color(0);
color boardColor = color(200);

// Menu Sphere Colors
int[][][] sphereColors; // 0 = black, 1 = white

// Menu Board Formatting
int zMenu;



void setup() {
  size(800, 800, P3D);
  frameRate(60);

  rot = 1;
  turn = 0;
  chooseMode = 0;
  win = 0;
  score1 = 0;
  score2 = 0;

  stage = 0;

  zMenu = 800;

  cooldown = 200;

  Cx = new float[4];
  Cy = new float[4];
  Cz = new float[4];

  free = new float[4][4][4];
  sphereColors = new int[4][4][4];
  But = new ArrayList<button>();

  cyl = new Cylinder(10, 10, 700, 10);

  Start = new Sbutton(width/2, height - 100, 200, 80, "Play", 30, 6, 20);
  choose = new Sbutton(width/2, height - 100, 200, 60, "Play Turn", 20, 6, 8);
  View = new Sbutton(width/2, 140, 200, 60, "View Again", 20, 6, 15);
  Again = new Sbutton(width/2, 140, 200, 60, "Play Again", 20, 6, 15);

  //setup sphere points (possible locations of spheres)
  for (int i = 0; i<4; i++) {
    Cx[i] = (width/5)*(i-1.5);
    Cy[i] = (width/5)*(i-1.5);
    Cz[i] = (width/5)*(i-1.5);
  }

  for (int i = 0; i<4; i++) {
    for (int j= 0; j<4; j++) {
      for (int k= 0; k<4; k++) {
        free[i][j][k] = 0; // Setup free
        // Setup Menu Sphere Colors
        if (random(1) > 0.5) sphereColors[i][j][k] = 1;
        else sphereColors[i][j][k] = 0;
      }
    }
  }


  // SETUP BUTTON
  int buttonMargin = 200;
  for (int i= 0; i < 4; i++) {
    for (int j = 0; j < 4; j++) {
      buttonX = buttonMargin + i*(width-2*buttonMargin)/3;
      buttonY = buttonMargin + j*(width-2*buttonMargin)/3;
      But.add(new button(buttonX, buttonY, 20));
    }
  }
}



void draw() {
  background(background);

  // Menu Stage
  if (stage == 0) {
    displayMenu();
  }

  // Game Stage
  if (stage == 1) {
    gameStage();
  }


  // End Stage
  if (stage == 2) {
    playAgainStage();
  }
}


// Before Game, menu with display
void displayMenu() {
  fill(255);
  textAlign(CENTER);
  textSize(50);
  text("Line 4", width/2, 70);
  stroke(255);
  strokeWeight(2);
  line(width/2 - 100, 80, width/2 + 100, 80);

  Start.display();
  if (Start.pressed()) {
    clicked = int(millis());
    stage = 1;
    turn = 1;
    return;
  }
  // 3D Board rotating
  stroke(0);

  pushMatrix();
  translate(width/2, height/2 - 100, -zMenu);
  rotateY(rot);
  translate(0, width/2, 0);
  strokeWeight(1);
  fill(boardColor);
  box(width, 50, width);
  translate(0, -width/2, 0);
  for (int i = 0; i<4; i++) {
    for (int j = 0; j<4; j++) {

      // Spheres
      for (int k = 0; k<4; k++) {
        pushMatrix();
        translate(Cx[i], Cy[k], -Cz[j]);
        rotateY(rot);
        if (sphereColors[i][j][k] == 0) {
          fill(0);
          stroke(255);
        } else {
          fill(255);
          stroke(0);
        }
        sphereDetail(18);
        strokeWeight(2);
        sphere(40);
        popMatrix();
      }

      // Columns:
      pushMatrix();
      translate(Cx[i]-100, Cy[3] -520, Cz[j]+100);
      cyl.display();
      popMatrix();
    }
  }
  rot = rot + 0.01;
  popMatrix();
}


// Game is active.
void gameStage() {

  displayBoard();

  // VIEW MODE
  if (chooseMode == 0) {
    rot = rot + 0.01;
    if (win == 0) {
      choose.display();
      if (choose.pressed()) {
        clicked = int(millis());
        chooseMode = 1;
      }
    }
  }

  //CHOOSING MODE
  if (chooseMode == 1 && win == 0) {
    pushMatrix();
    translate(0, 0, 160);
    View.display();
    if (View.pressed()) {
      chooseMode = 0;
    }
    popMatrix();
    for (int i = 0; i<16; i++) {
      But.get(i).display();
      //BALL POSITION
      if (But.get(i).pressed()) {

        // Determine which layer to put ball on
        determineBallLayer(i);

        // Put ball where we want and change turn
        if (turn == 1 && chooseMode == 1) {
          free[j][l][k] = 1;
          chooseMode = 0;
          turn = 2;
        } else if (turn == 2 && chooseMode == 1) {
          free[j][l][k] = 2;
          turn = 1;
          chooseMode = 0;
        }
      }
    }
  }

  displayTurn();
  checkWinner();
}

// Display either rotating board or view from above depending on mode
void displayBoard() {
  stroke(0);
  pushMatrix();
  translate(width/2, width/2, -width/2);

  if (chooseMode == 0) rotateY(rot); // Rotating
  if (chooseMode == 1) rotateX(-PI/2); // View from above
  translate(0, width/2, 0);
  strokeWeight(1);
  fill(255, 0, 0);
  translate(0, -20, width/2);
  box(30, 30, 30);
  translate(0, 20, -width/2);
  strokeWeight(1);
  fill(boardColor);
  box(width, 50, width);

  translate(0, -width/2, 0);
  for (int i = 0; i<4; i++) {
    for (int j = 0; j<4; j++) {
      pushMatrix();
      translate(Cx[i]-100, Cy[3]-520, Cz[j]+100);
      cyl.display();
      popMatrix();
      for (int k= 0; k<4; k++) {
        //PLAYER 1 DISPLAY
        if (free[i][j][k] == 1) {
          pushMatrix();
          translate(Cx[i], Cy[j], Cz[k]);
          fill(255);
          sphere(30);
          noFill();
          popMatrix();
        }
        //PLAYER 2 DISPLAY
        if (free[i][j][k] == 2) {
          pushMatrix();
          translate(Cx[i], Cy[j], Cz[k]);
          stroke(255);
          fill(0);
          sphere(30);
          noFill();
          popMatrix();
          stroke(0);
        }
      }
    }
  }

  popMatrix();
}


// Determine if one of three outcomes: player 1 or 2 wins, or tie
void checkWinner() {
  // WIN, 4IN A ROW
  if (win == 0) {
    // PLAYER 1, WIN (3)
    for (int i = 0; i <4; i++) {
      for (int j = 0; j< 4; j++) {
        if ((free[i][j][0] == 1 && free[i][j][1] == 1 && free[i][j][2] == 1 && free[i][j][3] == 1) || (free[i][0][j] == 1 && free[i][1][j] == 1 && free[i][2][j] == 1 && free[i][3][j] == 1) || (free[0][j][i] == 1 && free[1][j][i] == 1 && free[2][j][i] == 1 && free[3][j][i] == 1) ||
          (free[0][0][i] == 1 && free[1][1][i] == 1 && free[2][2][i] == 1 && free[3][3][i] == 1) || (free[0][3][i] == 1 && free[1][2][i] == 1 && free[2][1][i] == 1 && free[3][0][i] == 1) || (free[i][0][0] == 1 && free[i][1][1] == 1 && free[i][2][2] == 1 && free[i][3][3] == 1) || (free[i][0][3] == 1 && free[i][1][2] == 1 && free[i][2][1] == 1 && free[i][3][0] == 1) ||
          (free[0][i][0] == 1 && free[1][i][1] == 1 && free[2][i][2] == 1 && free[3][i][3] == 1) || (free[0][i][3] == 1 && free[1][i][2] == 1 && free[2][i][1] == 1 && free[3][i][0] == 1) ||
          (free[0][0][0] == 1 && free[1][1][1] == 1 && free[2][2][2] == 1 && free[3][3][3] == 1) || (free[0][0][3] == 1 && free[1][1][2] == 1 && free[2][2][1] == 1 && free[3][3][0] == 1) || (free[0][3][0] == 1 && free[1][2][1] == 1 && free[2][1][2] == 1 && free[3][0][3] == 1) || (free[3][0][0] == 1 && free[2][1][1] == 1 && free[1][2][2] == 1 && free[0][3][3] == 1) ) {

          win = 1;
          stage = 2;
          chooseMode = 0;
        }
      }
    }

    // PLAYER 2, WIN (2)
    for (int i = 0; i <4; i++) {
      for (int j = 0; j< 4; j++) {
        if ((free[i][j][0] == 2 && free[i][j][1] == 2 && free[i][j][2] == 2 && free[i][j][3] == 2) || (free[i][0][j] == 2 && free[i][1][j] == 2 && free[i][2][j] == 2 && free[i][3][j] == 2) || (free[0][j][i] == 2 && free[1][j][i] == 2 && free[2][j][i] == 2 && free[3][j][i] == 2) ||
          (free[0][0][i] == 2 && free[1][1][i] == 2 && free[2][2][i] == 2 && free[3][3][i] == 2) || (free[0][3][i] == 2 && free[1][2][i] == 2 && free[2][1][i] == 2 && free[3][0][i] == 2) || (free[i][0][0] == 2 && free[i][1][1] == 2 && free[i][2][2] == 2 && free[i][3][3] == 2) || (free[i][0][3] == 2 && free[i][1][2] == 2 && free[i][2][1] == 2 && free[i][3][0] == 2) ||
          (free[0][i][0] == 2 && free[1][i][1] == 2 && free[2][i][2] == 2 && free[3][i][3] == 2) || (free[0][i][3] == 2 && free[1][i][2] == 2 && free[2][i][1] == 2 && free[3][i][0] == 2) ||
          (free[0][0][0] == 2 && free[1][1][1] == 2 && free[2][2][2] == 2 && free[3][3][3] == 2) || (free[0][0][3] == 2 && free[1][1][2] == 2 && free[2][2][1] == 2 && free[3][3][0] == 2) || (free[0][3][0] == 2 && free[1][2][1] == 2 && free[2][1][2] == 2 && free[3][0][3] == 2) || (free[3][0][0] == 2 && free[2][1][1] == 2 && free[1][2][2] == 2 && free[0][3][3] == 2)) {

          win = 2;
          stage = 2;
          chooseMode = 0;
        }
      }
    }

    // TIE, NOBODY WINS (3), ALL 4TH LAYER FULL
    if ((free[0][0][0] != 0) && (free[1][0][0] != 0) && (free[2][0][0] != 0) &&
      (free[3][0][0] != 0) && (free[0][0][1] != 0) && (free[1][0][1] != 0) &&
      (free[2][0][1] != 0) && (free[3][0][1] != 0) && (free[0][0][2] != 0) &&
      (free[1][0][2] != 0) && (free[2][0][2] != 0) && (free[3][0][2] != 0) &&
      (free[0][0][3] != 0) && (free[1][0][3] != 0) && (free[2][0][3] != 0) &&
      (free[3][0][3] != 0) && (win !=1) && (win !=2) && (win !=4) && (win !=5)) {
      win = 3;
      stage = 2;
      chooseMode = 0;
    }
  }
}

// Game is over, display winner and ask to play again
void playAgainStage() {
  rot = rot + 0.01;
  displayBoard();

  //PLAYER IS WINNER
  if (win == 1) {
    fill(255, 0, 0);
    textSize(40);
    text("PLAYER 1 WINS", width/2, 70);
    stroke(255);
    fill(255);
    line(width/2-140, 80, width/2+140, 80);
  }
  //PLAYER IS WINNER
  else if (win == 2) {
    fill(255, 0, 0);
    textSize(40);
    text("PLAYER 2 WINS", width/2, 70);
    stroke(255);
    fill(255);
    line(width/2-140, 80, width/2+140, 80);
  }
  // IT'S A TIE
  else if (win == 3) {
    fill(255, 0, 0);
    textSize(40);
    text("IT'S A TIE!", width/2, 70);
    stroke(255);
    fill(255);
    line(width/2-140, 80, width/2+140, 80);
  }


  //PLAY AGAIN AFTER WIN (1,2,3)
  Again.display();
  if (Again.pressed()) {
    win = 0;
    turn = 1;
    stage = 0;
    for (int i = 0; i<4; i++) {
      for (int j = 0; j<4; j++) {
        for (int k = 0; k<4; k++) {
          free[i][j][k] = 0;
        }
      }
    }
  }
}


// determines where the ball should go next 
void determineBallLayer(int i) {
  if (i<=3)
    j = 0;
  if (i>=4 && i<=7)
    j = 1;
  if (i>=8 && i<=11)
    j = 2;
  if (i>=12 && i<=15)
    j = 3;

  if (i == 0 || i == 4 || i == 8 || i == 12)
    k = 0;
  if (i == 1 || i == 5 || i == 9 || i == 13)
    k = 1;
  if (i == 2 || i == 6 || i == 10 || i == 14)
    k = 2;
  if (i == 3 || i == 7 || i == 11 || i == 15)
    k = 3;

  // 4th later free
  if (free[j][0][k] == 0) {
    // 3rd layer free
    if (free[j][1][k] == 0) {
      // 2nd layer free
      if (free[j][2][k] == 0) {
        // 1st layer free
        if (free[j][3][k] == 0) {
          l = 3;
          // if first layer free put on first layer
        } else {
          l = 2;
          //if 2nd layer free put on 2nd layer
        }
      } else {
        l = 1;
      }
    } else {
      l = 0;
    }
  } else {
    chooseMode = 0;
    println(" not free, Player " + turn + "!");
  }
}

// Display turn text
void displayTurn() {
  // TURNS TEXT (WIN = 0)
  if (turn == 1 && win == 0) {
    textSize(30);
    fill(255);
    text("Player 1's Turn", width/2, 130);
  }
  if (turn == 2 && win == 0 ) {
    textSize(30);
    fill(255);
    text("Player 2's Turn", width/2, 130);
  }
}
