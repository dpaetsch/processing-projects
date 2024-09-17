class button{
  float BX;
  float BY;
  float Br;
  float opac1 = 50;
  float opac2 = opac1+50;
  color Bcol = color(220);
  color Bcolreal;

  button(float tempBX, float tempBY, float tempBr) {    
     BX = tempBX;
     BY = tempBY;
     Br = tempBr;
  }

  boolean pressed(){
     float dx = dist(BX,BY,mouseX,mouseY);
     if (mousePressed && dx<Br) return true; 
     return false;
  }
   
  void display(){
     Bcolreal = color(Bcol,opac1);
     if (pressed()) Bcolreal = color(Bcol,opac2);
     noStroke();
     fill(Bcolreal);
     ellipse(BX,BY,Br*2,Br*2);
     noFill();
   }
   
}
