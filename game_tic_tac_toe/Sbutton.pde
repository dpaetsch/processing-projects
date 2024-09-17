class Sbutton{
   float BX;
   float BY;
   float Br1;
   float Br2;
   float opac1 = 50;
   float opac2 = opac1+50;
   color Bcol = color(220);
   color Bcolreal;
   String Str;
   float Size;
   float DistX;
   float DistY;
   
   Sbutton(float tempBX, float tempBY, float tempBr1, float tempBr2, String tempStr, float tempSize, float tempDistX, float tempDistY) {    
      BX = tempBX;
      BY = tempBY;
      Br1 = tempBr1;
      Br2 = tempBr2;
      Str = tempStr;
      Size = tempSize;
      DistX = tempDistX;
      DistY = tempDistY;
   }
   
   boolean pressed(){
      if (mousePressed && mouseX <BX+Br1/2 && mouseX>BX-Br1/2 && mouseY<BY+Br2/2 && mouseY>BY-Br2/2)
         return true; 
      
      return false;
    }
    
   void display(){
      Bcolreal = color(Bcol,opac1);
      
      if (pressed()) Bcolreal = color(Bcol,opac2);
      
      //noStroke();
      stroke(0);
      rectMode(CENTER);
      fill(Bcolreal);
      rect(BX,BY,Br1,Br2);
      noFill();
      fill(0,opac2+30);
      textSize(Size);
      textAlign(CENTER);
      text(Str,BX,BY+DistY);
      noFill();   
   }
   
}
