class Coordinates {
  float t;
  int Num;
  float[] var1 = new float[8];
  float[] var2 = new float[8];


  Coordinates(int tempNum) {
    Num = tempNum;
    for (int i=0; i<8; i++) {
      var1[i] = random(10, 50);
      var2[i] = random(50, 500);
    }
  }
  
  
  void display() {

    for (int i = 0; i <Num; i++) {
      stroke(random(200), random(200), random(200), i);
      line(x1(t+i), y1(t+i), x2(t+i), y2(t+i));
    }

    t++;
  }



  float x1(float t) {
    return sin(t/var1[0]) *  var2[1]+ sin(t/var1[2])*var2[3];
  }
  float y1(float t) {
    return cos(t/var1[4])*var2[5]-cos(t/var1[6])*var2[7];
  }

  float x2(float t) {
    return sin(t/var1[0]) * var2[1]+ sin(t/var1[2])*var2[3];
  }
  float y2(float t) {
    return cos(t/var1[4])*var2[5]+sin(t/var2[6]*var1[7]);
  }
}
