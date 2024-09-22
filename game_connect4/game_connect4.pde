//Avalable Spaces:
//0=empty,1=red,2=blue
float[][] avalable = new float[7][6];
//if column is full or not
boolean[] isFull = new boolean[7];

//Game Lines
float[] xl = new float[8];
float[] yl = new float[7];

//Game Space Positions
float[] xc = new float[7];
float[] yc = new float[6];

//Button Array
ArrayList <button> But = new ArrayList<button>();

//Coin Array
ArrayList <Coin> coins = new ArrayList<Coin>();

//Screen Dimensions
int w = 375;
int h = 812;

//Menu Start Button
Sbutton Start;
//PLAY AGAIN BUTTON
Sbutton Again;


int turn = 0;
int menuTurn = 1;
int win = 0;
int r = 30;
int score1 = 0; //red's score
int score2 = 0; //blue's score
boolean ready = true;
int timer;


//menu games
boolean menuReady = true;
int menuTimer = 0;
int yoff = 150; //for Menu board y
int random = 3;
int speed = 499;

// margin in menu (reformat for 800x800)
int marginX = 200;

void setup() {
  size(800, 800);
  // old size: 375,812
  
  
  Start = new Sbutton(w/2 + marginX, (h/2)+130, 250, 90, "Play", 30, 6, 5);
  Again = new Sbutton(w/2 + marginX, (h-130)/2+170, 250, 90, "Play Again", 30, 50, 10);
  
  

  //SETUP LINES
  for (int i = 0; i<8; i++) {
    xl[i] = i*(w)/(8) + w/16 + marginX;
  }
  for (int i = 0; i<7; i++) {
    yl[i] = i*(w)/(8) + w/8;
  }
  
  //SETUP CENTER POSITIONS
  for (int i = 0; i<7; i++) {
    xc[i] = i*(w)/(8)+w/8 + marginX;
  }
  for (int i = 0; i<6; i++) {
    yc[i] = i*(w)/(8)+w/8+25;
  }
  // SETUP AVALABLE
  for (int i = 0; i<7; i++) {
    for (int j=0; j<6; j++) {
      avalable[i][j] = 0;
    }
  }
  for (boolean p : isFull) {
    p = false;
  }

  // SETUP BUTTON
  for (int k = 0; k<7; k++) {
    But.add(new button(xc[k], 400, 20));
  }
}

void draw() {
  background(255);

  if (turn == 0) {
    pushMatrix();
    translate(0, yoff);
  }
  for (Coin p : coins) {
    p.display();
  }

  if (turn == 0) {
    popMatrix();
  }
  for (int i=coins.size()-1; i>=0; i--) {
    if (coins.get(i).y > h+50) {
      coins.remove(i);
    }
  }
  noStroke();
  fill(255);
  rect(w/2, h-100, w, 300);

  //MENU (TURN = 0)
  if (turn == 0) {
    stroke(0);
    fill(0);
    textAlign(CENTER);
    textSize(30);
    text("Menu", w/2 + marginX, 150);
    textSize(40);
    text("Connect 4!", w/2 + marginX, 50);
    line(w/2-110 + marginX, 60, w/2+110+marginX, 60);
    Start.display();

    if (menuTimer + speed < millis()) {
      if(checkWinner(1)) {
        boardReset();
      }
      if(checkWinner(2)) {
        boardReset();
      }

      random = ran(random);

      boolean goodEnough = false;

      while (!goodEnough) {
        {
          if (isFull[random]) {
            random = ran(random);
          } else {
            goodEnough = true;
          }
        }
      }


      PlaceToken(random, menuTurn);
      menuTimer = millis();
      menuReady = true;

      if (menuReady && menuTurn == 1) {
        menuTurn = 2;
        menuReady = false;
      }
      if (menuReady && menuTurn == 2) {
        menuTurn = 1;
        menuReady = false;
      }
    }

    if (Start.pressed()) {
      turn = 1;
      for (int i=coins.size()-1; i>=0; i--) {
        coins.remove(i);
      }
      boardReset();
    }


    for (int i = 0; i<7; i++) {
      line(xl[0], yl[i]+yoff, xl[7], yl[i]+yoff);
    }
    //VERTICAL LINES
    for (int i = 0; i<8; i++) {
      line(xl[i], yl[0]+yoff, xl[i], yl[6]+yoff);
    }


    //END MENU
  }


  // GAME (TURN == 1 OR 2)
  if (turn != 0 ) {
    if (!ready) {
      if (millis() > timer + 600) {
        ready = true;
      }
    }
    //SETUP & LINES
    fill(0);
    stroke(0);
    //ORRIZONTAL LINES
    for (int i = 0; i<7; i++) {
      line(xl[0], yl[i], xl[7], yl[i]);
    }
    //VERTICAL LINES
    for (int i = 0; i<8; i++) {
      line(xl[i], yl[0], xl[i], yl[6]);
    }

    //PLAYER ONE PLAYER TWO
    //PLAYER ONE TEXT
    textSize(20);
    fill(0, 100);
    text("Red Player", 100 + marginX, h-200);

    //PLAYER TWO TEXT
    textSize(20);
    fill(0, 100);
    text("Blue Player", w-100 + marginX, h-200);

    // PRESS BUTTON TURNS
    for (int i = 0; i<7; i++) {
      if (!isFull[i]) {
        But.get(i).display();
      }
      if (But.get(i).pressed() && !isFull[i] && turn == 1 && win == 0 && ready) {
        PlaceToken(i, 1);
        turn = 2;
        ready = false;
        timer = millis();
        break;
      }
      if (But.get(i).pressed() && !isFull[i] && turn == 2 && win == 0 && ready) {
        PlaceToken(i, 2);
        turn = 1;
        ready = false;
        timer = millis();
        break;
      }
    }

    // TURNS TEXT (WIN = 0)
    if (turn == 1 && win == 0 && ready) {
      textSize(20);
      fill(0);
      text("Red Player", 100 + marginX, h-200);
    }
    if (turn == 2 && win == 0 && ready) {
      textSize(20);
      fill(0);
      text("Blue Player", w-100 + marginX, h-200);
    }

    // WIN, 4 IN A ROW
    if (win == 0) {
      if (checkWinner(1)) {
        win = 1;
      }
      if (checkWinner(2)) {
        win = 2;
      }
    }

    //WHEN A PLAYER WINS
    //WHEN PLAYER 1 WINS
    if (win == 1) {
      score1++;
      win = 4;
    }
    if (win == 4) {
      fill(255, 0, 0);
      textSize(30);
      text("RED PLAYER WINS", w/2 + marginX, 35);
      stroke(0);
      fill(0);
      line(w/2-140 + marginX, 40, w/2+140 + marginX, 40);
    }
    //WHEN PLAYER TWO WINS
    if (win == 2) {
      score2++;
      win = 5;
    }
    if (win == 5) {
      fill(0, 0, 255);
      textSize(30);
      text("BLUE PLAYER WINS", w/2 + marginX, 35);
      stroke(0);
      fill(0);
      line(w/2-140 + marginX, 40, w/2+140 + marginX, 40);
    }


    // TIE, NOBODY WINS (3)
    if (isFull[0] && isFull[1] && isFull[2] && isFull[3] && isFull[4] && isFull[5] && isFull[6]
      && (win !=1) && (win !=2) && (win != 4) && (win != 5)) {
      win = 3;
    }
    if (win == 3) {
      fill(150, 0, 150);
      textSize(30);
      text("IT'S A TIE!", w/2 + marginX, 35);
      stroke(0);
      fill(0);
      line(w/2-73 + marginX, 40, w/2+70 + marginX, 40);
      win = 6;
    }


    //PLAY AGAIN AFTER WIN (1,2,3)
    if (win ==4 || win == 5 || win == 6) {
      Again.display();
      if (Again.pressed()) {
        win = 0;
        boardReset();
      }
    }

    //SCORE WINS Display
    fill(0);
    textSize(30);
    text("Score: ", (w/2) + marginX, h-150);
    text(score1, w/2-100 + marginX, h-150);
    text(score2, w/2+100 + marginX, h-150);
  }
}

void PlaceToken(int row, int turn) {
  for (int j=5; j>=0; j--) {
    if (avalable[row][j] ==0) {
      avalable[row][j] = turn;
      if (j==0) isFull[row] = true;
      coins.add(new Coin(row, j, turn, r));
      return;
    }
  }
}

boolean checkWinner(int turn) {
  //CHECK 4 VERTICAL
  for (int i = 0; i<7; i++) {
    for (int j=0; j<3; j++) {
      if (avalable[i][j]== turn && avalable[i][j+1]== turn && avalable[i][j+2]== turn && avalable[i][j+3]==turn) {
        return true;
      }
    }
  }
  //CHECK 4 DIAGONAL UP-RIGHT
  for (int i = 0; i<4; i++) {
    for (int j = 0; j<3; j++) {
      if (avalable[i][j] == turn && avalable[i+1][j+1]==turn && avalable[i+2][j+2]==turn && avalable[i+3][j+3]==turn) {
        return true;
      }
    }
  }
  //CHECK 4 DIAGONAL DOWN-RIGHT
  for (int i = 0; i<4; i++) {
    for (int j = 3; j<6; j++) {
      if (avalable[i][j] == turn && avalable[i+1][j-1]==turn && avalable[i+2][j-2]==turn && avalable[i+3][j-3]==turn) {
        return true;
      }
    }
  }
  //CHECK 4 HORIZONTAL
  for (int i = 0; i<4; i++) {
    for (int j = 0; j<6; j++) {
      if (avalable[i][j] == turn && avalable[i+1][j]== turn && avalable[i+2][j]==turn && avalable[i+3][j]==turn) {
        return true;
      }
    }
  }
  return false;
}


void boardReset() {
  for (int i = 0; i<7; i++) {
    for (int j = 0; j<6; j++) {
      avalable[i][j] = 0;
    }
    isFull[i] = false;
  }
  for (Coin p : coins) {
    p.Finished = true;
  }
}

int ran(int input) {

  return ((input*input*millis()+4)*3)%7;
}
