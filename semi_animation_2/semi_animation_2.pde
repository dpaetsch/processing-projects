ArrayList <Semi> semis;

int numSemis;

float delta;
float space;

float Xc;
float Yc;
float a;
float speed;

Semi semi1;
//center x,y, radius,Radius, rotation, num

void setup() {
  size(800, 800);
  frameRate(120);
  
  semis = new ArrayList<Semi>();
  numSemis = 15;
  delta = (width/2)/numSemis;
  space = 3;
  Xc = width/2;
  Yc = height/2;;
  a = 0;
  semi1 = new Semi(width/2, height/2, 80, 100, 180, 100);
  
  
  for (int i = 0; i < numSemis; i++) {
    semis.add(new Semi(0, 0, i*space + i*delta, i*space+i*delta+delta, 180, 100));
  }
}

void draw() {
  background(255);
  speed = map(mouseX, 0, width, 0.5, 1);
  //semi1.display();
  for (int i = 1; i <= numSemis; i++) {
    pushMatrix();
    translate(Xc, Yc);
    rotate(sin(i+(a*i)/200));
    semis.get(i-1).display();
    popMatrix();
  }
  a++;
}
