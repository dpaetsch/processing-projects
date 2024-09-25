class Cubes {
  float a; // angle of boxes;
  float rotspeed; // speed of rotation
  float t; // parameter for coords
  int[][] coords;
  float[][] rotation;
  int startX, startY;
  int numBoxes;
  int x, y; // temporary cords
  float rotX,rotY; // temporary rotation

  float[] vars;

  int size;

  color c;

  float jitter;


  Cubes(int tempNumBoxes) {
    numBoxes = tempNumBoxes;
    
    a = 0;
    t = 0;
    startX = W/2 + (int)(random(-200, 200));
    startY = H/2 + (int)(random(-200, 200));

    size = (int)(random(10, 60));
    coords = new int[numBoxes][2];
    rotation = new float[numBoxes][2];

    c = color(random(255), random(255), random(255));
    
    a = random(10);
    rotspeed = random(1);

    for (int i = 0; i < numBoxes; i++) {
      coords[i][0] = -100;
      coords[i][1] = -100;
      rotation[i][0] = a;
      rotation[i][1] = PI*a;
    }
    
  
    jitter = random(0.01);

    vars = new float[4];

    for (int i = 0; i < 4; i++) {
      vars[i] = random(11, 70);
    }
  }


  void display() {
    stroke(c);
    noFill();
    for (int i = 0; i< numBoxes; i++) {
      pushMatrix();
      ortho();
      translate(coords[i][0], coords[i][1], -100);
      rotateY(rotation[i][0]);
      rotateX(rotation[i][1]);
      box(size);
      popMatrix();
    }

    
    newCoords();
  }

  void newCoords() {
    
    // COORDINATES
    x = (int)(random(-jitter, jitter)*sin(t/vars[0])*vars[1]*1.5 + sin(t/vars[2])*vars[3]) + startX;
    y = (int)(random(-jitter, jitter)*cos(t/vars[1])*vars[2]*1.5-cos(t/vars[3])*vars[0]) + startY;
       
    for (int i = numBoxes-1; i > 0; i--) {
      coords[i][0] = coords[i-1][0];
      coords[i][1] = coords[i-1][1];
    }

    coords[0][0] = x;
    coords[0][1] = y;


    // ROTATION
    rotX = rotspeed*a;
    rotY = PI*rotspeed*a;
    
    for (int i = numBoxes-1; i > 0; i--) {
      rotation[i][0] = rotation[i-1][0];
      rotation[i][1] = rotation[i-1][1];
    }
    
    rotation[0][0] = rotX;
    rotation[0][1] = rotY;
    

    t += 1.5;
    a += 0.01;
  }
}
