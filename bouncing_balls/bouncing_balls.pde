int Balls;
int BallWidth;
int BallHeight;

float x[];
float y[];

float xDelta[];
float yDelta[];

float color1[];
float color2[];
float color3[];

int set = 1;

void setup() {
   size(800, 800);
   frameRate(60);
   
   Balls = 200;
   BallWidth = 20;
   BallHeight = 20;
   
   x = new float[Balls];
   y = new float[Balls];
   
   xDelta = new float[Balls];
   yDelta = new float[Balls];
   
   color1 = new float[Balls];
   color2 = new float[Balls];
   color3 = new float[Balls];

   
   for(int i=0 ; i<Balls ; i=i+1) { 
     
      x[i] = (float)random(10, width);
      y[i] = random(10, height);
      
      xDelta[i] = random(-10,10);
      yDelta[i] = random(-10,10);
      
      color1[i] = random(0,255);
      color2[i] = random(0,255);
      color3[i] = random(0,255);
   }
   
}

void draw() {
   if( set == 1)
   background(0);
   
   for(int i=0 ; i<Balls ; i=i+1) {   
     
      ellipse(x[i], y[i], BallWidth, BallHeight);
      fill(color1[i],color2[i],color3[i]);
      
      x[i] = x[i] + xDelta[i];
      y[i] = y[i] + yDelta[i];
      
      if(x[i]>width-BallWidth/2){
         xDelta[i] = -xDelta[i];
      }
      if(x[i]<BallWidth/2) {
         xDelta[i] = -xDelta[i];
      }
      if(y[i]>height-BallHeight/2){
         yDelta[i] = -yDelta[i];
      }
      if(y[i]<BallHeight/2) {
         yDelta[i] = -yDelta[i];
      }    
   }
}
