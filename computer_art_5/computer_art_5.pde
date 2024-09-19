float t;
float W;
float H;
int Num = 10;

void setup() {
   size(800,800);
   background(0,0,0);
   W = width;
   H = height;
}

void draw() {
   background(0);
   stroke(255);
   strokeWeight(5);
   
   translate(W/2,H/2);
   
   for(int i = 0; i <Num;i++){
      line(x1(t+i),y1(t+i),x2(t+i),y2(t+i));
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
   return sin(t/13) * 100 + sin(t/21)*95;
}
float y2(float t){
   return cos(t/10)*200+sin(t/15);
}
