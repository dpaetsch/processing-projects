class cube {
   float W = width;
   float H = height;
   float s = W/25;
   int x;
   int y;
   //color cubeColor;
   
   cube(int tempX, int tempY) {
      x = tempX;
      y = tempY;
      // cubeColor = color(random(255));
      
   }
   
   void display(){
      color c = color(random(mouseY*255/H),random(mouseY*255/H),random(mouseY*255/H));
      fill(c);
      rect(x*s,y*s,s,s);
      touched();
   }
   

   void touched(){
      if (mousePressed && mouseX <(x+1)*s && mouseX>x*s && mouseY<(1+y)*s && mouseY>y*s){
         //println("X: "+x+" ;Y: "+y);
         
         //float try = y;
      }
   }
}
