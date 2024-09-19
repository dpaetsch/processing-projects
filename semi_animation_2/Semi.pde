class Semi {
   //center x,y, radius, rotation, num
   float Xc,Yc,r,R,rot;
   int num;
   
   
   Semi(float testXc, float testYc, float testr, float testR, float testrot, int testnum) {
      
      Xc = testXc;
      Yc = testYc;
      r = testr;
      R = testR;
      rot = testrot;
      num = testnum;
      
      
   }
   
   
   void display(){
      
      float angle;
      float[] x1 = new float[num+1];
      float[] y1 = new float[num+1];

      float[] x2 = new float[num+1];
      float[] y2 = new float[num+1];

      
      
      for(int i=0; i < x1.length; i++){
         angle = (PI/num)* i;
         x1[i] = -cos(angle) * r;
         y1[i] = sin(angle) * r;
         x2[i] = -cos(angle) * R;
         y2[i] = sin(angle) * R;
      }
      fill(0);
      beginShape();
      
      
      for(int i=0; i < x1.length; i++){
         vertex(Xc+x1[i],Yc-y1[i]);
      }
      
      for(int i=x1.length-1; i >= 0; i--){
         vertex(Xc+x2[i],Yc-y2[i]);
      }
      
      endShape(CLOSE);
      
      
      
   }
}
