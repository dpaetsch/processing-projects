float W, H, s;
int Ncolums;
int Nrows;

ArrayList<cube> cubes;

void setup() {
  size(800, 800);

  W = width;
  H = height;
  s = W/25;

  Ncolums = 25;
  Nrows = 40;

  cubes = new ArrayList<cube>();

  for (int i=0; i<Nrows; i++) {
    for (int j=0; j<Ncolums; j++) {
      cubes.add(new cube(j, i));
    }
  }
}

void draw() {
  for (int i=0; i<cubes.size(); i++) {
    cubes.get(i).display();
  }
  noStroke();
  fill(255, 0, 0);
  ellipse(mouseX, mouseY, 30, 30);
  stroke(0);
}
