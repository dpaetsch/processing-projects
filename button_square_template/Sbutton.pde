class Sbutton {
  float BX;
  float BY;
  float Br1;
  float Br2;
  float opac1 = 50;
  float opac2 = opac1+50;
  color Bcol = color(220);
  color Bcolreal;

  Sbutton(float tempBX, float tempBY, float tempBr1, float tempBr2) {
    BX = tempBX;
    BY = tempBY;
    Br1 = tempBr1;
    Br2 = tempBr2;
  }

  boolean pressed() {
    return mousePressed && mouseX <BX+Br1 && mouseX>BX && mouseY<BY+Br2 && mouseY>BY;
  }


  void display() {
    Bcolreal = color(Bcol, opac1);
    if (pressed()) Bcolreal = color(Bcol, opac2);

    noStroke();
    fill(Bcolreal);
    rect(BX, BY, Br1, Br2);
    noFill();
  }
}
