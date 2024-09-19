float t;
float W;
float H;
int Num = 20;
int Many = 10;



ArrayList<Coordinates> coord = new ArrayList();

Coordinates A = new Coordinates(Num);
Coordinates B = new Coordinates(Num);

void setup() {
   size(800,800);
   
   W = width;
   H = height;
   
   for(int i=0;i<Many;i++){
      coord.add(new Coordinates(Num));
      
      
   }
}

void draw() {
   frameRate(60);
   background(0);
   stroke(255);
   strokeWeight(5);
   
   translate(W/2,H/2);
   
   //A.display();
   //B.display();
   
   for(int i=0;i<Many;i++){
      
      coord.get(i).display();
      
      
   }
}
