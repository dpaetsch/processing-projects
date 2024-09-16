ArrayList <Ant> ants;
int numAnts;
PImage bg;

void setup() {
   size(800, 800);
   frameRate(60);
   bg = loadImage("background.png");
   numAnts = 50;
   ants = new ArrayList<Ant>();
   
   for(int i = 0; i < numAnts; i++) {     
      ants.add(new Ant());
   }   
}

void draw() {
   background(255);
   //image(bg,0,0);
   //image(bg,600,0);
   
   
   
   for(int i = 0; i < numAnts; i++) {
      ants.get(i).drawAnt(); //(ant object).drawAnt();
      // or Ant temp = ant.get(i); temp.drawAnt();


      
   }

//println(ants.length);
}
