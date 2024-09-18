float i;
void setup() {
  size(800, 800, P3D);
  i = 1;
}


void draw() {
  background(0, 0, 255);
  
  i++;
  pushMatrix();
  translate(width/2, height/2);
  rotateX(mouseY*0.01);
  rotateY(mouseX*0.01);
  box(150);
  popMatrix();
}
