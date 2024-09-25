int H, W;

int numCubes;
ArrayList<Cubes> AllCubes;

void setup() {
  size(800, 800, P3D);
  frameRate(100);
  W = width;
  H = height;
  
  numCubes = 30; 
  numCubes = (int)(random(1,20));

  AllCubes = new ArrayList<Cubes>(numCubes);
  
  int num = (int)(random(10, 80));
  
  for (int i = 0; i < numCubes; i++) {
    //int num = 10;//(int)(random(20, 100));
    AllCubes.add(new Cubes(num));
  }
}

void draw() {
  background(0);
  
  
  
  for (int i = 0; i < numCubes; i++) 
   AllCubes.get(i).display();
}
