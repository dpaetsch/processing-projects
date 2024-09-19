
color red = color(255,0,0);
color orange = color(255,140,0);
color yellow = color(255,255,0);
color green = color(0,255,0);
color blue = color(0,0,255);
color violet = color(255,0,255);
color white = color(255,255,255);
color grey = color(180,180,180);
color dgrey = color(90,90,90);

color now;

int set;

float t;
float W;
float H;
int Num = 10;

void setup() {
   size(800);
  
   H = height;
   W = width;
}

void draw() {
   background(0);
   stroke(255);
   strokeWeight(5);
   
   translate(W/2,H/2);
   
   
   
   
   
   
   
   
   
   
   for(int i = 0; i <Num;i++){
      
      if(i == 8)
      now = red;
      
      if(i == 7)
      now = orange;
      
      if(i == 6)
      now = yellow;
      
      if(i == 5)
      now = green;
      
      if(i == 4)
      now = blue;
      
      if(i == 3)
      now = violet;
      
      if(i == 2)
      now = white;
      
      if(i == 1)
      now = grey;
      
      if(i == 0)
      now = dgrey;
      
      
      
      stroke(now);
      
      
     line(x1(t+i),y1(t+i),x2(t+i),y2(t+i));
      line(-x1(t+i),y1(t+i),-x2(t+i),y2(t+i));
      line(x1(t+i),-y1(t+i),x2(t+i),-y2(t+i));
      line(-x1(t+i),-y1(t+i),-x2(t+i),-y2(t+i));
      
      /*line(x1(2*t+i),y1(2*t+i),x2(2*t+i),y2(2*t+i));
      line(-x1(2*t+i),y1(2*t+i),-x2(2*t+i),y2(2*t+i));
      line(x1(2*t+i),-y1(2*t+i),x2(2*t+i),-y2(2*t+i));
      line(-x1(2*t+i),-y1(2*t+i),-x2(2*t+i),-y2(2*t+i));
      */
      
      k = 0.5;
      line(x3(k*t+i),y3(k*t+i),x4(k*t+i),y4(k*t+i));
      line(-x3(k*t+i),y3(k*t+i),-x4(k*t+i),y4(k*t+i));
      line(x3(k*t+i),-y3(k*t+i),x4(k*t+i),-y4(k*t+i));
      line(-x3(k*t+i),-y3(k*t+i),-x4(k*t+i),-y4(k*t+i));
      
      i = i + 10;
      line(x3(k*t+i),y3(k*t+i),x4(k*t+i),y4(k*t+i));
      line(-x3(k*t+i),y3(k*t+i),-x4(k*t+i),y4(k*t+i));
      line(x3(k*t+i),-y3(k*t+i),x4(k*t+i),-y4(k*t+i));
      line(-x3(k*t+i),-y3(k*t+i),-x4(k*t+i),-y4(k*t+i));

i = i-10;
      
      
      
      //line(x1(2*t+i),y1(2*t+i),x2(2*t+i),y2(2*t+i));
      
      
      
      
   }
   
   t++;
   
}

float x1(float t){
   return sin(t/10) * 100 + sin(t/5)*20;
}
float y1(float t){
   return cos(t/10)*10+sin(t/15)*40;
}

float x2(float t){
   return sin(t/10) * 100 + sin(t/20)*80;
}
float y2(float t){
   return cos(t/10)*200+sin(t/20);
}


float x3(float t){
   return sin(t/10) * 100 + sin(t/20)*60;
}
float y3(float t){
   return cos(t/10)*100-sin(t/30)*70;
}

float x4(float t){
   return sin(t/10) * 100 + sin(t/20)*80;
}
float y4(float t){
   return cos(t/30)*200-sin(t/20)*100;
}
