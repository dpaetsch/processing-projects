class Coin {
  int x, y, yfinal, deltay;
  int c;
  boolean Finished;
  Coin(int row, int col, int turn, int r) {
    x = row *(w)/(8)+w/8 + marginX;
    yfinal = col*(w)/(8)+w/8+25;
    y = 0;
    deltay = 1;
    c = turn;
    Finished = false;
  }

  void display() {
    noStroke();
    if (c==1) {
      fill(255, 0, 0);
    }
    if (c == 2) {
      fill(0, 0, 255);
    }

    if (y<yfinal && !Finished) {
      y+=deltay;
      deltay+=1;
    }
    if (y>yfinal && !Finished) {
      y = yfinal;
      deltay = 0;
    }

    if (Finished) {
      y+=deltay;
      deltay+=1;
    }

    ellipse(x, y, r, r);
  }
}
