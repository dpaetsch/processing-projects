float t;
float W;
float H;

void setup() {
  size(800, 800);
  background(0, 0, 0);

  W = width;
  H = height;
  t = 0;
}

void draw() {

  stroke(255);
  strokeWeight(5);

  translate(W/2, H/2);

  line(x1(t), y1(t), x2(t), y2(t));
  
  if(t % 10 == 0) background(0,0,0);

  t++;
}

float x1(float t) {
  return sin(t/10) * 100 + sin(t/5)*20;
}
float y1(float t) {
  return cos(t/11)*10;
}

float x2(float t) {
  return sin(t/11) * 100 + sin(t/21)*95;
}
float y2(float t) {
  return cos(t/10)*200+sin(t/17);
}
