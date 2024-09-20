ArrayList<Ray> rays;
ArrayList<Wall> walls;
float nRays = 1000;
float nWalls = 0;
PVector[][] pt;
float xoff = 0;
float yoff = 100;
float mx, my;
int touchmode = 1;  //1 = mouse, 0 = random


int nBox = 10;
float[] bx = new float[nBox];
float[] by = new float[nBox];
float[] bw = new float[nBox];
float[] bh = new float[nBox];




void setup() {
   size(800,800);
   
  
   
   
   
   rays = new ArrayList<Ray>();
   walls = new ArrayList<Wall>();
   pt = new PVector[int(nRays)][int(nWalls)];
   
   for (int i=0; i<nRays; i++) {
      rays.add(new Ray(i*2*PI/nRays));
   }
   
   walls.add(new Wall(-1, -1, -1, height));
   walls.add(new Wall(-1, -1, width, -1));
   walls.add(new Wall(width+1, -1, width+1, height));
   walls.add(new Wall(0, height+1, width, height+1));
   
   for (int i=0; i<nWalls; i++) {
      walls.add(new Wall(random(width), random(height), random(width), random(height)));
   }

   
   for(int i=0;i < nBox;i++){
      for(int j=0; j< nBox;j++){
         
         bx[i] = i*width/nBox;
         by[j] = j*height/nBox;
         bw[i] = 10;
         bh[i] = bw[i];
         
         
         walls.add(new Wall(bx[i], by[j], bx[i]+bw[i], by[j]));
         walls.add(new Wall(bx[i]+bw[i], by[j], bx[i]+bw[i], by[j]+bh[i]));
         walls.add(new Wall(bx[i], by[j]+bh[i], bx[i]+bw[i], bh[i]+by[j]));
         walls.add(new Wall(bx[i], by[j], bx[i], by[j]+bh[i]));
      }
   }
}

void draw() {
   background(0);
   if(touchmode == 1){
      mx = mouseX;
      my = mouseY;
   }
   if(touchmode == 0){
      xoff += 0.01;
      yoff += 0.01;
      mx = noise(xoff)*width;
      my = noise(yoff)*height;
   }
   for (int i = 0; i < walls.size(); i++) {
      walls.get(i).display(); // display walls
   }
   stroke(100);
   
   for (int i=0; i<nRays; i++) {
      float record = 1000000;
      PVector closest = null;
      rays.get(i).display(mx, my); // display rays
      for (int j = 0; j < walls.size(); j++) {
         rays.get(i).cast(walls.get(j)); // Finds point on walls
         if (rays.get(i).touch == 1) {
            float d = dist(mx, my, rays.get(i).pt.x, rays.get(i).pt.y);
            if (d < record) {
               record = d;
               closest = new PVector(rays.get(i).pt.x, rays.get(i).pt.y);
            }
         }
      }
      if (closest != null) {
         line(mx, my, closest.x, closest.y);
      }
   }
}
