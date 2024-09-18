float W, H;
float s;
color ran;

//float[] w;
//loat[] h;
void setup() {
  size(800, 800);

  W = width;
  H = height;

  s = H/43;

  background(0, 0, 255);
}

void draw() {

  

  for (int i=0; i<100; i++) {
    for (int j=0; j<100; j++) {
      ran = color(random(255), random(255), random(255));
      fill(ran);
      rect(j*s, i*s, (1+j)*s, (i+1)*s);
    }
  }
}
