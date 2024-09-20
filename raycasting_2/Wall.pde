class Wall {
  float x1, x2, y1, y2;

  Wall(float tempx1, float tempy1, float tempx2, float tempy2) {
    x1 = tempx1;
    x2 = tempx2;
    y1 = tempy1;
    y2 = tempy2;
  }

  void display() {
    stroke(255);
    strokeWeight(2);
    line(x1, y1, x2, y2);
  }
}
