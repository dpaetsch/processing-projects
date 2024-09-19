ArrayList <Semi> semis;

int numSemis;

float delta;
float space = 3;

float Xc;
float Yc;
float a = 0;
float speed;

Semi semi1;
//center x,y, radius,Radius, rotation, num

void setup() {
  size(800, 800);
  frameRate(120);

  semis = new ArrayList<Semi>();
  numSemis = 15;
  delta = (width/2-70)/numSemis;

  Xc = width/2;
  Yc = height/2-70;
  
  semi1 = new Semi(width/2, height/2-70, 80, 100, 180, 100);

  for (int i = 0; i < numSemis; i++) {
    semis.add(new Semi(0, 0, i*space + i*delta, i*space+i*delta+delta, 180, 100));
  }
}

void draw() {
  background(255);
  //semi1.display();
  for (int i = 1; i <= numSemis; i++) {


    semis.get(i-1).display();
  }
}
