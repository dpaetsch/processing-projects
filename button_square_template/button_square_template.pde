Sbutton S = new Sbutton(300, 600, 200, 50);

void setup() {
  size(800, 800);
}

void draw() {
  background(255, 255, 255);
  S.display();
  if (S.pressed()) {
    fill(255,0,0);
    rect(250,150,300,300);
  }
}
