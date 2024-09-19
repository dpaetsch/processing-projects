class Semi {
   //center x,y, radius, rotation, num
   float Xc,Yc,r,R,rot;
   int num;
   
   float a,neg,speed;
   float smol;
   Semi(float testXc, float testYc, float testr, float testR, float testrot, int testnum) {
      
      Xc = testXc;
      Yc = testYc;
      r = testr;
      R = testR;
      R = r + random(10,20);
      rot = testrot;
      num = testnum;
      a = 0;
      neg = random(-1,1);
      if(neg == 0)
      neg = 1;
      speed = random(80,100);
      smol = 0;
   }
   
   
   void display(){
      
      float angle;
      float[] x1 = new float[num+1];
      float[] y1 = new float[num+1];
      
      float[] x2 = new float[num+1];
      float[] y2 = new float[num+1];
      
      
      
      for(int i=0; i < x1.length; i++){
         angle = (smol/num)* i;
         x1[i] = -cos(angle) * r;
         y1[i] = sin(angle) * r;
         x2[i] = -cos(angle) * R;
         y2[i] = sin(angle) * R;
      }
      fill(0);
      beginShape();
      pushMatrix();
      translate(width/2,height/2);
      
      rotate(neg*a/speed);
      
      
      for(int i=0; i < x1.length; i++){
         vertex(Xc+x1[i],Yc-y1[i]);
      }
      
      for(int i=x1.length-1; i >= 0; i--){
         vertex(Xc+x2[i],Yc-y2[i]);
      }
      
      endShape(CLOSE);
      
      popMatrix();
      
      a++;
      smol = smol + 0.01;
      
   }
}
