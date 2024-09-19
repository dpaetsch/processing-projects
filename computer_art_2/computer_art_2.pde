float t;
float W;
float H;

int inversionX = 0;

void setup() {
   size(800,800);
   W = width;
   H = height;
   
   
   background(0,0,0);
}

void draw() {

   stroke(255);
   strokeWeight(10);
   
   translate(W/2,H/2);
   
   function1(t);
   function2(t);
   function3(t);
   function4(t);
   function5(t);

   t += 0.45;
   
   
   
}

void function1(float t){
  
  float x = sin(4*t)*cos(t)*100;
  float y = sin(5*t)*cos(t)*100;
  
  fill(255);
  point(x,y);
}

void function2(float t){
  
  float x = sin(6*t)*cos(t)*200;
  float y = sin(7*t)*cos(t)*200;
  
  stroke(200,0,0);
  point(x,y);
}


void function3(float t){
  
  float x = sin(8*t)*cos(t)*400;
  float y = sin(7*t)*cos(t)*150;
  
  stroke(150,200,150);
  point(x,y);
}

void function4(float t){
  
  
  float x = sin(7*t)*cos(t)*150;
  float y = sin(8*t)*cos(t)*400;
  
  stroke(50,200,150);
  point(x,y);
}


void function5(float t){
  
  float x = sin(6*t)*cos(t)*400;
  float y = sin(7*t)*cos(t)*400;
  
  stroke(255,255,109);
  point(x,y);
}
