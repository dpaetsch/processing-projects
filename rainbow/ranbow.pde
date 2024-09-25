
double t = 0;


void setup() {
  size(800, 800);
}

void draw() {
  background(120);

  color c = getRainbowColor(t);

  fill(c);
  ellipse(width/2, height/2, 100, 100);


  t += 0.01;
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
