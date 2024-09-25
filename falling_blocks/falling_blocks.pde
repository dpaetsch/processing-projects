ArrayList <Blocks> blocks = new ArrayList<Blocks>();

int NBlocks = 20;

float[] ceil = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

void setup() {
  size(800, 800);

  for (int i = 0; i < NBlocks; i++)
    blocks.add(new Blocks());
}

void draw() {
  background(0);

  for (int i = 0; i < NBlocks; i++)
    blocks.get(i).drawBlock();


  for (int i=0; i< ceil.length; i++) {
    float ran = random(1);
    if (ran > 0.3) ceil[i] = 0;
    else ceil[i] = 1;
  }
}
