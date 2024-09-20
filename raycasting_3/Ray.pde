class Ray {
  float x, y;
  PVector dir;
  float angle;
  int touch; // 1 = touch, 0 = no touch
  PVector pt;
  float mx, my;
  Ray(float tempangle) {
    angle = tempangle;

    dir = new PVector(sin(angle), -cos(angle));
    pt = new PVector();
  }

  void display(float tempmx, float tempmy) {

    stroke(255, 100);
    strokeWeight(1);

    mx = tempmx;
    my = tempmy;
    
    x = mouseX;
    y = mouseY;
    line(mx, my, mx+dir.x, my+dir.y);
  }

  void cast(Wall wall) {
    float x1 = wall.x1;
    float y1 = wall.y1;
    float x2 = wall.x2;
    float y2 = wall.y2;

    float x3 = mx; 
    float y3 = my;
    float x4 = mx + dir.x; 
    float y4 = my + dir.y;

    float den = (x1-x2)*(y3-y4) - (y1-y2)*(x3-x4);
    if (den == 0) {
      return;
    }
    float t = ((x1-x3)*(y3-y4)-(y1-y3)*(x3-x4))/den;
    float u = -((x1-x2)*(y1-y3)-(y1-y2)*(x1-x3))/den;
    if (t > 0 && t < 1 && u > 0) {
      pt.x = x1 + t*(x2-x1);
      pt.y = y1 + t*(y2-y1);
      touch = 1;
    } else {
      touch = 0;
    }
  }
}