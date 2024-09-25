float x1, y1; // pos of first ball
float x2, y2; // pos of second ball
float m1, m2; // mass or width
float r1, r2; // lenght of sticks
float a1, a2; // angles
float a1_v; // angular velocity
float a2_v;
float a1_a; // angular acceleration
float a2_a;
float num1, num2, num3, num4, den; // for calculations
float g; // gravity
float px2, py2; // previous position (for line tracing)
float cx,cy;
float t; // parameter for rainbow colors

int colorSetting; // for different types of colorings 


PGraphics canvas;

void setup() {
  size(800, 800);
  
  cx = width/2;
  cy = 300;
  
  
  canvas = createGraphics(width, height);
  canvas.beginDraw();
  canvas.background(0);
  canvas.endDraw();

  x1 = width/2;
  y1 = 200;

  r1 = 200;
  r2 = 200;
  m1 = 30;
  m2 = 30;
  
  g = 1;

  a1 = random(-PI,PI);
  a2 = random(-PI,PI);

  a1_v = 0;
  a2_v = 0;
  a1_a = 0.01;
  a2_a = -0.001;

  px2 = 0; 
  py2 = 0;
  
  t = 0;
  
  colorSetting = 1 ;

  
}

void draw() {

  num1 = -g * (2 * m1 + m2) * sin(a1);
  num2 = -m2 * g * sin(a1-2*a2);
  num3 = -2 * sin(a1-a2)*m2;
  num4 = a2_v*a2_v * r2 + a1_v*a1_v * r1 * cos(a1-a2);
  den = r1 * (2 * m1 + m2 - m2*cos(2*a1-2*a2));

  a1_a = (num1 + num2 + num3 * num4)/den;

  num1 = 2 * sin(a1-a2);
  num2 = (a1_v*a1_v*r1*(m1+m2));
  num3 = g * (m1+m2)*cos(a1);
  num4 = a2_v*a2_v*r2*m2*cos(a1-a2);
  den = r2 * (2*m1+m2-m2*cos(2*a1-2*a2));

  a2_a = (num1*(num2+num3+num4)) / den;


  //background(0);
  image(canvas, 0, 0);
  stroke(255);
  fill(255);
  strokeWeight(4);
  translate(cx, cy);

  float x1 = r1 * sin(a1);
  float y1 = r1 * cos(a1);

  float x2 = x1 + r2 * sin(a2);
  float y2 = y1 + r2 * cos(a2);

  line(0, 0, x1, y1);
  ellipse(x1, y1, m1, m1);

  line(x1, y1, x2, y2);
  ellipse(x2, y2, m2, m2);


  a1_v += a1_a;
  a2_v += a2_a;
  a1 += a1_v;
  a2 += a2_v;

  // Dampening
  //a1_v *= 0.999;
  //a2_v *= 0.999;
  
  
  t += 0.01;
  color c = color(0,0,0);
  
  if(colorSetting == 0){
    c = getRainbowColor(t);
  } else if (colorSetting == 1) {
    c = getRainbowColor(y2/500 + 0.25); // adjustment (division for larger colors, addition for having red at bottom)
  }



  canvas.beginDraw();
  canvas.translate(cx, cy );
  canvas.strokeWeight(2);
  canvas.stroke(c);
  if (frameCount >1)
    canvas.line(px2, py2, x2, y2);
  canvas.endDraw();

  px2 = x2;
  py2 = y2;
  
  
  
}




color getRainbowColor(double value) {
  // Loop the value continuously by taking modulo
  double normalizedValue = value % 1.0;
  if (normalizedValue < 0) {
    normalizedValue += 1.0;  // Handle negative values
  }

  // Convert the normalized value to a hue (range from 0 to 360 for a full circle of colors)
  double hue = normalizedValue * 360.0; // 0 is red, 360 is also red (loops)

  // Convert HSL to RGB
  return hslToRgb(hue, 1.0, 0.5); // Full saturation and lightness
}

// Method to convert HSL values to an RGB color
color hslToRgb(double h, double s, double l) {
  double c = (1 - Math.abs(2 * l - 1)) * s;
  double x = c * (1 - Math.abs((h / 60.0) % 2 - 1));
  double m = l - c / 2;

  double r = 0, g = 0, b = 0;

  if (0 <= h && h < 60) {
    r = c;
    g = x;
    b = 0;
  } else if (60 <= h && h < 120) {
    r = x;
    g = c;
    b = 0;
  } else if (120 <= h && h < 180) {
    r = 0;
    g = c;
    b = x;
  } else if (180 <= h && h < 240) {
    r = 0;
    g = x;
    b = c;
  } else if (240 <= h && h < 300) {
    r = x;
    g = 0;
    b = c;
  } else if (300 <= h && h < 360) {
    r = c;
    g = 0;
    b = x;
  }

  // Adjust to RGB scale (0-255)
  int red = (int) ((r + m) * 255);
  int green = (int) ((g + m) * 255);
  int blue = (int) ((b + m) * 255);

  return color(red, green, blue);
}
