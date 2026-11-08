

public class Ball {
  
  float x, y;
  float speed;             // speed along the ball's path in pixels per frame (bounces included)
  float speedX, speedY;
  float radius;
  
  Pad sourcePad;
  Pad targetPad;
  
  int bounces;         
  int framesLeft;          
  boolean arrived = false;
  color c;
  
  // Where on the pad this ball aims, from -1 (top end) to 1 (bottom end), 0 = center
  float hitOffset;
  // With bounces, whether the first bounce is off the top wall or the bottom wall
  boolean bounceUpFirst;
  
  
  public Ball(float startX, float startY, float startSpeed, int bounces, Pad sourcePad, Pad targetPad){
    x = startX;
    y = startY;
    speed = startSpeed;
    this.sourcePad = sourcePad;
    this.targetPad = targetPad;
    this.bounces = bounces;
    c = bounceColor(bounces, true);
    
    radius = random(MINBALLRADIUS, MAXBALLRADIUS);
    hitOffset = random(-1, 1) * HITSPREAD;
    bounceUpFirst = random(1) < 0.5;
    
    aimAt(targetPad);
  }
  
  
  public void draw() {
    fill(c);
    circle(x, y, radius * 2);
    
    calculatePos();
  }
  
  
  private void calculatePos(){
    x += speedX;
    y += speedY;
    
    float top = radius;
    float bottom = WINDOWHEIGHT - radius;
    while (y < top || y > bottom) {
      if (y < top)    y = 2 * top - y;
      if (y > bottom) y = 2 * bottom - y;
      speedY = -speedY;
    }
    
    framesLeft--;
    if (framesLeft <= 0) {
      arrived = true;
    }
  }
  
  
  private void aimAt(Pad target){

    boolean targetIsRight = target.getX() > x;
    float hitX = targetIsRight
      ? target.getX() - radius
      : target.getX() + target.getWidth() + radius;
    
    float distX = hitX - x;
    
    // A ball with more bounces travels a longer (zigzag) path, so it needs more frames.
    // Start with the fastest possible trip (straight across) and add frames until the
    // ball's actual speed, including the vertical part, is no more than 'speed'.
    // Each extra frame changes where the pad will be, so the aim point is recalculated every time.
    framesLeft = max(1, ceil(abs(distX) / speed));
    float aimY = aimPointAfter(target, framesLeft);
    while (dist(0, 0, distX, aimY - y) / framesLeft > speed) {
      framesLeft++;
      aimY = aimPointAfter(target, framesLeft);
    }
    
    speedX = distX / framesLeft;
    speedY = (aimY - y) / framesLeft;
  }
  
  
  // The (unfolded) y to aim at, if the ball should reach the target pad in the given number of frames
  private float aimPointAfter(Pad target, int frames){
    // Center of the pad at arrival, shifted by this ball's own hit offset.
    // The ball's center stays on the pad, so it still visibly hits it.
    float targetY = target.predictCenterY(frames) + hitOffset * target.getHeight() / 2.0;
    // Near the top or bottom wall that point could be outside where the ball can go, so keep it inside
    targetY = constrain(targetY, radius, WINDOWHEIGHT - radius);
    
    return mirrorImage(targetY, bounces);
  }
  
  
  private float mirrorImage(float targetY, int k){
    // Both images work (for k = 0 they're the same point); pick one at random.
    return bounceUpFirst ? imageInStrip(targetY, -k) : imageInStrip(targetY, k);
  }
  
  private float imageInStrip(float targetY, int m){
    float top = radius;
    float stripHeight = WINDOWHEIGHT - 2 * radius;
    float offset = targetY - top;
    
    if (m % 2 == 0) {
      return top + m * stripHeight + offset;      
    } else {
      return top + (m + 1) * stripHeight - offset;
    }
  }
  
  
  public boolean hasArrived(){
    return arrived;
  }
  public float getX(){
    return x;
  }
  public float getY(){
    return y;
  }
  public float getSpeed(){
    return speed;
  }
  public Pad getSourcePad(){
    return sourcePad;
  }
  public Pad getTargetPad(){
    return targetPad;
  }
  
  
}
