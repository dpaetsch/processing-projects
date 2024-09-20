ArrayList<Ray> rays;
float nRays = 1000;
float nWalls = 0;
PVector[][] pt;
float xoff = 0;
float yoff = 100;
float mx, my;
int touchmode = 0;  //1 = mouse, 0 = random

int nBox = 5;

float[] bx;
float[] by;
float[] bw;
float[] bh;

ArrayList<Wall> walls;


void setup() {
  size(800, 800);


  bx = new float[nBox];
  by = new float[nBox];
  bw = new float[nBox];
  bh = new float[nBox];

  pt = new PVector[int(nRays)][int(nWalls)];
  walls = new ArrayList<Wall>();
  rays = new ArrayList<Ray>();


  for (int i=0; i<nRays; i++) {
    rays.add(new Ray(i*2*PI/nRays));
  }

  // Screen Walls: 
  walls.add(new Wall(-2, -1, -2, height));
  walls.add(new Wall(-1, -1, width, -1));
  walls.add(new Wall(width+1, -1, width+1, height));
  walls.add(new Wall(0, height+1, width, height+1));

  for (int i=0; i < nWalls; i++) {
    walls.add(new Wall(random(width), random(height), random(width), random(height)));
  }
  
  
// Add Boxes:
  for (int i=0; i<nBox; i++) {
    for (int j=0; j < nBox; j++) {

      bx[i] = i*height/nBox;
      by[j] = j*width/nBox;
      bw[i] = random(10, 100);
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
  if (touchmode == 1) {
    mx = mouseX;
    my = mouseY;
  }
  if (touchmode == 0) {
    xoff += 0.01;
    yoff += 0.01;
    mx = noise(xoff)*width;
    my = noise(yoff)*height;
    
    
    
  }
  

  for (int i = 0; i < walls.size(); i++) {
    walls.get(i).display(); // display walls
  }
  
  stroke(100);


  // Check for shortest distance one ray at a time:
  for (int i=0; i < nRays; i++) {
    
    float record = 1000000;
    PVector closest = null;
    
    
    rays.get(i).display(mx, my); 
    
 
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
