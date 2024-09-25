class button {
  float BX;
  float BY;
  float Br;
  float opac1 = 50;
  float opac2 = opac1+50;
  color Bcol = color(220);
  color Bcolreal;

  button(float tempBX, float tempBY, float tempBr) {

    BX = tempBX;
    BY = tempBY;
    Br = tempBr;
  }

  boolean pressed() {
    if (mousePressed && dist(BX, BY, mouseX, mouseY)<Br) {
      return true;
    }
    return false;
  }
  
  void display() {
    
    stroke(255);
    fill(100);
    ellipse(BX, BY, Br*2, Br*2);
  }
}
