float t;
float W;
float H;
int Num = 10;

void setup() {
  size(800, 800);
  W = width;
  H = height;
}

void draw() {
  background(0);
  stroke(1);
  strokeWeight(5);

  translate(W/2, H/2);

  for (int i = 0; i <Num; i++) {
    noFill();
    stroke(0, 200, 0);
    line(x1(t+i), y1(t+i), x2(t+i), y2(t+i));

    stroke(200, 0, 0);
    line(x3(t+i), y3(t+i), x4(t+i), y4(t+i));

    stroke(0, 0, 200);
    line(x5(t+i), y5(t+i), x6(t+i), y6(t+i));
  }

  t++;
}

float x1(float t) {
  return sin(t/10) * 100 + sin(t/50)*90+sin(t/100)*20;
}
float y1(float t) {
  return cos(t/10)*10+sin(t/15)*40;
}

float x2(float t) {
  return sin(t/10) * 100 + sin(t/21)*95+cos(t/40)*70;
}
float y2(float t) {
  return cos(t/10)*200+sin(t/15)+sin(t/10)*50;
}

float x3(float t) {
  return cos(t/10) * 100 + cos(t/50)*89+sin(t/100)*20;
}
float y3(float t) {
  return sin(t/30)*10+cos(t/30)*80;
}

float x4(float t) {
  return sin(t/10) * 100 + sin(t/21)*95+cos(t/40)*70;
}
float y4(float t) {
  return sin(t/10)*200+cos(t/15)+sin(t/10)*50;
}


float x5(float t) {
  return sin(t/20) * 100 + sin(t/30)*89+sin(t/10)*20;
}
float y5(float t) {

  return cos(t/10) * 100 + sin(t/21)*95+cos(t/40)*70+sin(t/40)*50;
}

float x6(float t) {
  return cos(t/30)*100+cos(t/30)*80+cos(t/40)*80+cos(t/70)*70;
}
float y6(float t) {
  return sin(t/20)*200+sin(t/15)+sin(t/10)*50+cos(t/10)*30;
}
