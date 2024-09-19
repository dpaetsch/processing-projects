float t;
float W;
float H;

void setup() {
  size(800, 800);
  frameRate(120);
  background(0);

  W = width;
  H = height;
}

void draw() {


  stroke(255);
  strokeWeight(10);

  translate(W/2, H/2);

  function1(t);
  function2(t);
  function3(t);
  
  t += 0.45;
}


void function1(float t){
  float x = sin(t/10)*cos(t/3) * 100 + sin(t)*10;
  float y = cos(t/10)*100;
  stroke(255);
  point(x,y);
}



void function2(float t){
  float x = sin(t/15)*120;
  float y = cos(t/7)*200;
  stroke(200,0,0);
  point(x,y);
}

void function3(float t){
  float x = cos(t/7)*200;
  float y = sin(t/15)*120;
  stroke(0,0,200);
  point(x,y);
}
