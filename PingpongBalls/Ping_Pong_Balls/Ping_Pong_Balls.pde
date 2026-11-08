

Pad leftPad;
Pad rightPad;

ArrayList<Pad> pads = new ArrayList<Pad>();

ArrayList<Ball> balls = new ArrayList<Ball>();
// Reused every frame instead of creating a new list each time
ArrayList<Ball> newBalls = new ArrayList<Ball>();

public int WINDOWWIDTH = 1000;
public int WINDOWHEIGHT = 1000;

public int DISTPADWALL = 100;

public int PADSPEED = 10;
public int BALLSPEED = 10;

public int MAXBALLS = 5000;

// When a ball splits, one child goes straight (0 bounces) and the other
// touches the top/bottom walls a random number of times, from 1 up to this
public int MAXBOUNCES = 4;

// How far from the pad's center balls may hit: 0 = always dead center, 1 = anywhere on the pad
public float HITSPREAD = 1;

// Each ball gets a random size in this range
public float MINBALLRADIUS = 8;
public float MAXBALLRADIUS = 12;

int startBallX = 500;
int startBallY = 500;

int bounces = 0;


void setup(){
  size(1000, 1000, P2D);
  noStroke();
  
  leftPad = new Pad(DISTPADWALL,0,PADSPEED);
  rightPad = new Pad(WINDOWWIDTH - DISTPADWALL,900,-PADSPEED);
  
  pads.add(leftPad);
  pads.add(rightPad);
  
  balls.add(new Ball(startBallX, startBallY, BALLSPEED, bounces, leftPad, rightPad));
}


void draw(){
  background(0,0,0);
 
  leftPad.draw();
  rightPad.draw();
  
  // New balls go into a separate list, so they don't move an extra step this frame
  newBalls.clear();
  
  for (int i = balls.size() - 1; i >= 0; i--) {
    Ball b = balls.get(i);
    b.draw();
    
    if (b.hasArrived()) {
      // Removing from the middle of an ArrayList shifts every later element.
      // Order doesn't matter here, so move the last ball into this slot and drop the last slot instead.
      int last = balls.size() - 1;
      balls.set(i, balls.get(last));
      balls.remove(last);
      
      if (balls.size() + newBalls.size() + 2 > MAXBALLS) {
        // At the limit: replace the ball with a single one instead of splitting
        newBalls.add(new Ball(b.getX(), b.getY(), randomBallSpeed(), int(random(MAXBOUNCES + 1)), b.getTargetPad(), b.getSourcePad()));
        continue;
      }
      
      // Split: both start where the ball hit and head back to the pad it came from.
      // Each gets its own random speed, so they arrive at different times (and the pad
      // is somewhere else by then), which keeps the balls from stacking on top of each other.
      newBalls.add(new Ball(b.getX(), b.getY(), randomBallSpeed(), 0, b.getTargetPad(), b.getSourcePad()));
      newBalls.add(new Ball(b.getX(), b.getY(), randomBallSpeed(), randomBounces(), b.getTargetPad(), b.getSourcePad()));
    }
  }
  
  balls.addAll(newBalls);
  
  fill(255);
  textSize(32);
  textAlign(CENTER, BOTTOM);
  text("Balls: " + balls.size() + "    FPS: " + round(frameRate), WINDOWWIDTH / 2, WINDOWHEIGHT - 10);
}


// Random speed around BALLSPEED. Based on BALLSPEED rather than the parent's speed,
// so speeds don't drift towards very slow or very fast over many generations.
float randomBallSpeed(){
  return BALLSPEED * random(0.6, 1.4);
}


// Random bounce count from 1 to MAXBOUNCES
int randomBounces(){
  return int(random(1, MAXBOUNCES + 1));
}


// Each bounce count gets its own hue, spread evenly around the color wheel.
// With 'vary' on, the hue, saturation and brightness get a small random change,
// so balls with the same bounce count look alike but not identical.
color bounceColor(int bounces, boolean vary){
  float hue = 360.0 * bounces / (MAXBOUNCES + 1);
  float saturation = 85;
  float brightness = 95;
  
  if (vary) {
    hue += random(-10, 10);
    saturation = random(65, 100);
    brightness = random(75, 100);
  }
  
  // HSB (hue, saturation, brightness) makes "same color family" easy; switch back to RGB afterwards
  colorMode(HSB, 360, 100, 100);
  color c = color((hue + 360) % 360, saturation, brightness);
  colorMode(RGB, 255);
  return c;
}
