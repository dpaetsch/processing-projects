button B = new button(100,100,50);

void setup() {
   size(800, 800);
}

void draw() {
   background(255,255,255);
   
   B.display();
   if(B.pressed())
   {
      rectMode(CENTER);
      fill(255,0,0);
      rect(300,300,100,100);
      println("Hello World");
   }   
}
