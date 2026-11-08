

public class Pad {
  
  private int width = 10;
  private int height = 100;
  
  private float x, y;
  private float speedY;
  
  
  public Pad(int startX, int startY, int startSpeedY) {
    x = startX;
    y = startY;
    speedY = startSpeedY;
  }
  
  
  public void draw(){
    fill(255);
    rect(x, y, width, height);
    calculatePos();
  }
  
  private void calculatePos(){
    y += speedY;
    
    float maxY = WINDOWHEIGHT - height;
    if (y > maxY) {
      y = 2 * maxY - y;
      speedY = -speedY;
    }
    if (y < 0) {
      y = -y;
      speedY = -speedY;
    }
  }
  
  
  public float predictY(int frames) {
    float maxY = WINDOWHEIGHT - height;
    float period = 2 * maxY;
    
    float s = (y + speedY * frames) % period;
    if (s < 0) s += period;
    
    return s <= maxY ? s : period - s;
  }
  
  public float predictCenterY(int frames) {
    return predictY(frames) + height / 2.0;
  }
  
  
  public float getX(){
    return x;
  }
  public float getY(){
    return y;
  }
  public int getWidth(){
    return width;
  }
  public int getHeight(){
    return height;
  }
  
  
}
