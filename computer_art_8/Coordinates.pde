class Coordinates {
  float t;
  int Num;
  float[] var1 = new float[8];
  float[] var2 = new float[8];


  Coordinates(int tempNum) {
    Num = tempNum;
    for (int i=0; i<8; i++) {
      var1[i] = int(random(10, 30));
      var2[i] = int(random(50, 300));
      //translate(0,random(-200,200));
    }
  }
  void display() {

    for (int i = 0; i <Num; i++) {
      stroke(random(200), random(200), random(200), 30+i);
      line(x1(t+i), y1(t+i), x2(t+i), y2(t+i));
    }
    t++;
  }

  float x1(float t) {
    return sin(t/var1[0]) *  var2[0]+ sin(t/var1[1])*var2[1];
  }
  float y1(float t) {
    return cos(t/var1[2])*var2[2]-cos(t/var1[3])*var2[3];
  }

  float x2(float t) {
    return sin(t/var1[5]) * var2[4]-sin(t/var1[5])*var2[5];
  }
  float y2(float t) {
    return cos(t/var1[6])*var2[6]+sin(t/var1[7])*var2[7];
  }
}
