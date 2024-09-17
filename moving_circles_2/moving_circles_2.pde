float x,y;
int num;
float a;
float b;
float[] r;
float rpast;
float rpres;
float rrate;
int wiggle;
float k;
float d;

void setup() {
   size(800,800);
   num = 20;
   x = 0;
   y = 0;
   
   r = new float[num];
   
   for(int i=0;i<num;i++){
      r[i] = 300 - 15*i;
   }
}

void draw() {
   background(0);
   k = map(mouseX,0,width,0,10);
   stroke(255,100);
   strokeWeight(1);
   fill(0);
   pushMatrix();
   translate(width/2,height/2);
   for(int i=0;i<num;i++){
         x = (num-i)*1.5*cos(a+(num-i)*k)*(1-cos(b));
         y = (num-i)*1.5*sin(a+(num-i)*k)*(1-cos(b));
      
      d = r[i] + r[i]*sin(b)/4;
      
      if(i == 0){
         stroke(255);
         strokeWeight(3);
        
      } else { 
         stroke(40+i*11);
         strokeWeight(1);
      }
      ellipse(x,y,d,d);
      
   }
   
   x = x + 1.5*(cos(a) - cos(b));
   y = y + 1.5*(sin(a) - sin(b));
   fill(255);
   ellipse(x,y,10,10);
   
   a += 0.06;
   b += 0.02;
   popMatrix();
   

}
