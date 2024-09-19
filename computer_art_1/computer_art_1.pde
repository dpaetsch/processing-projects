float t;
float W;
float H;
int Num = 200;

Coordinates A = new Coordinates(Num);

void setup() {
   size(800, 800);
   
   W = width;
   H = height;
  
}

void draw() {
frameRate(120);
   background(0);
   stroke(255);
   strokeWeight(5);
   
   translate(W/2,H/2);
   
   A.display();
}
