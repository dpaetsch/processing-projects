class Ant {
   
   float x,y;
   PVector speed;
   
   int bodySize;
   PImage img;
   

   Ant() {
      x = random(30,width-80);
      y = random(30,height-90);
      
      bodySize = int( random(5,40));
      speed = new PVector(random(-2,2),random(-2,2));

      img = loadImage("ant.png");

   }
   
   void drawAnt(){
      moveAnt();
      
      pushMatrix();
      translate(x + img.width/2,y + img.height/2);
      rotate(speed.heading()+ PI/2);
      translate(-img.width/2,-img.height/2);
      image(img,0,0); // POSITION 0,0
      popMatrix();
   }   
   void moveAnt() {
      //90% of the time move straight
      // 7% of the time waver right or left
      // 3% of the time make a larger movement right or left
      float testMove = random(0,1);
      if(testMove < 0.07) {
         speed.rotate(random(-0.1,0.1));
      }
      if(testMove > 0.97){
         speed.rotate(random(-1,1));
         
         
         
         
         
         
      }
      
      x = x + speed.x;
      y = y + speed.y;      
      
      
      if(isAntOffScreen() == true) {
         x = x - speed.x;
         y = y - speed.y;
         speed.rotate(random(-2,2));
      }
      
      
      
   }
   
   boolean isAntOffScreen() {
      
      
      if(x<10 || x> width - 30 || 
      //y<30 || y> 600-35) 
      y<10 || y> height - 70 -20)
      return true;
      
      return false;
      
      
   }
}
