class Blocks {


  float x, y;
  PVector speed;
  float W = width;
  int index;

  float[] d = {0,
    W/12, W/11*2, W/11*3, W/11*4, W/11*5, W/11*6, W/11*7, W/11*8, W/11*9, W/11*10};

  Blocks() {

    index = int(random(d.length));
    x = d[index];
    y = random(-1000, 0);

    speed = new PVector();

    speed.x = 0;
    speed.y = 7;
  }

  void drawBlock() {
    moveBlock();
    fill(0, 255, 0);
    rect(x, y, 33, 33);
  }

  void moveBlock() {
    x = x + speed.x;
    y = y + speed.y;


    if (isBlockOffScreen()) {
      index = int(random(d.length));
      x = d[index];
      y = -20;
    }
  }

  boolean isBlockOffScreen() {
    if (y >height) {
      return true;
    }
    return false;
  }
}
