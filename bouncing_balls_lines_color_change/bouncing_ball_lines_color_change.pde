int Balls = 50;

float[] x = new float[Balls];
float[] y = new float[Balls];

float [] xDelta = new float[Balls];
float [] yDelta = new float[Balls];

float [] BallWidth = new float[Balls];
float [] BallHeight = new float[Balls];

float [] color1 = new float[Balls];
float [] color2 = new float[Balls];
float [] color3 = new float[Balls];

void setup() {
noStroke();
   background(0);
   size(800, 800);
   frameRate(100);
   
   for(int i=0 ; i<Balls ; i=i+1) { 
      x[i] = random(10,width);
      y[i] = random(10,height);
      
      xDelta[i] = random(-10,10);
      yDelta[i] = random(-10,10);
      
      BallWidth[i] = random(20,22);
      BallHeight[i] = BallWidth[i];
   }
   
}

void draw() {   
   for(int i=0 ; i<Balls ; i=i+1) {   
      color1[i] = random(0,255);
      color2[i] = random(0,255);
      color3[i] = random(0,255);
      ellipse(x[i],y[i],BallWidth[i],BallHeight[i]);
      fill(color1[i],color2[i],color3[i]);
      
      x[i] = x[i] + xDelta[i];
      y[i] = y[i] + yDelta[i];
      
      if(x[i]>width-BallWidth[i]/2){
         xDelta[i] = -xDelta[i];
      }
      if(x[i]<BallWidth[i]/2) {
         xDelta[i] = -xDelta[i];
      }
      if(y[i]>height-BallHeight[i]/2){
         yDelta[i] = -yDelta[i];
      }
      if(y[i]<BallHeight[i]/2) {
         yDelta[i] = -yDelta[i];
      }    
   }
}
