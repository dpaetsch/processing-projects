class Cylinder {
  float bottom; // bottom (top) length
  float top;  // top (bottom) length
  float h; // Height
  int sides; // 

  Cylinder(float tempbottom, float temptop, float temph, int tempsides) {

    bottom = tempbottom;
    top = temptop;
    h = temph;
    sides = tempsides;
  }

  void display() {
    pushMatrix();
    fill(woodColor);
    
    translate(100, h/2, -100);
    
    float angle;
    float[] x = new float[sides+1];
    float[] z = new float[sides+1];

    float[] x2 = new float[sides+1];
    float[] z2 = new float[sides+1];

    //get the x and z position on a circle for all the sides
    for (int i=0; i < x.length; i++) {
      angle = TWO_PI / (sides) * i;
      x[i] = sin(angle) * bottom;
      z[i] = cos(angle) * bottom;
    }

    for (int i=0; i < x.length; i++) {
      angle = TWO_PI / (sides) * i;
      x2[i] = sin(angle) * top;
      z2[i] = cos(angle) * top;
    }

    //draw the bottom of the cylinder
    stroke(0);
    
    beginShape(TRIANGLE_FAN);
    vertex(0, -h/2, 0);
    for (int i=0; i < x.length; i++) {
      vertex(x[i], -h/2, z[i]);
    }
    endShape();

    //draw the center of the cylinder
    beginShape(QUAD_STRIP);
    for (int i=0; i < x.length; i++) {
      vertex(x[i], -h/2, z[i]);
      vertex(x2[i], h/2, z2[i]);
    }
    endShape();

    //draw the top of the cylinder
    beginShape(TRIANGLE_FAN);
    vertex(0, h/2, 0);
    for (int i=0; i < x.length; i++) {
      vertex(x2[i], h/2, z2[i]);
    }
    endShape();
    popMatrix();
  }
}
