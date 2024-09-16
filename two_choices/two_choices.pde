int set;
float n;

String Opt1;
String Opt2;

Sbutton Start;
Sbutton Starting;
Sbutton Again;

void setup() {
   size(800,800);
   set = 0;
   
   // SELECT YOUR OPTIONS
   Opt1 = "Dont Skip";
   Opt2 = "Skip";
   
   // Square Buttons:
   Start = new Sbutton(width/2,height/2+100,200,80,"Start",30,10,10);
   Starting = new Sbutton(width/2,height/2+100,200,80,"Starting...",30,10,10);
   Again = new Sbutton(width/2,height/2+100,200,80,"Start Again",30,10,10);
   
}

void draw() {
   background(255);
   
   //BEFORE START 
   if(set == 0){
      Start.display();
      textSize(30);
      textAlign(CENTER);
      text(Opt1, width/2,100);
      text(Opt2, width/2,200);
      
      if(Start.pressed())
      set = 1;
   }
   
   //DURING START
   if(set == 1){
      textSize(30);
      textAlign(CENTER);
      text(Opt1, width/2,100);
      text(Opt2, width/2,200);
      n = random(1);
   }
   
   //AFTER START
   if(set == 2){
      textSize(30);
      if(n<0.5){
         fill(200);
         stroke(0);
         
         textAlign(CENTER);
         rectMode(CENTER);
         rect(width/2,100-12,200,50);
         fill(0);
         text(Opt1,width/2,100);
         text(n,width-50,100);
         fill(100);
         text(Opt2, width/2,200);
         
      }
      if(n>0.5){
         fill(100);
         textAlign(CENTER);
         text(Opt1, width/2,100);
         fill(200);
         rectMode(CENTER);
         rect(width/2,200-12,200,50);
         fill(0);
         text(Opt2,width/2,200);
         text(n,width-50,200);
      }
      
      Again.display();
      if(Again.pressed()){
         set = 1;
      }
   }
}

void mouseReleased(){
   if(set == 1){
      set = 2;
   }
}
