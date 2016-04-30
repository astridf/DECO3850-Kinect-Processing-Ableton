
class KinectTracker {
  int threshold = 745;

  PVector loc;
  PVector loc2;
  PVector loc3;

  int[] depth;
  PImage display;
  boolean moving;
  boolean moving2;
  boolean moving3;
  Kinect2 kinect2;
  
  KinectTracker(PApplet pa) {
    kinect2 = new Kinect2(pa);
    kinect2.initDepth();
    kinect2.initDevice();
    display = createImage(kinect2.depthWidth, kinect2.depthHeight, RGB);
    loc = new PVector(0, 0);
    loc2 = new PVector(0, 0);
    loc3 = new PVector(0, 0);
  }

  void track() {
    depth = kinect2.getRawDepth();
    if (depth == null) return;

    float sumX = 0;
    float sumY = 0;
    float count = 0;

    float sumX2 = 0;
    float sumY2 = 0;
    float count2 = 0;
    
    float sumX3 = 0;
    float sumY3 = 0;
    float count3 = 0;
    
    for (int y = 0; y < kinect2.depthHeight; y++) {
      for (int x = 0; x < kinect2.depthWidth; x++) {
        int offset = kinect2.depthWidth - x - 1 + y * kinect2.depthWidth;
        int rawDepth = depth[offset];
        if (rawDepth > 0 && rawDepth < threshold) {
          if (x <= 160){
          sumX += x;
          sumY += y;
          count++;            
          }
          else if (x > 160 && x <= 320){
          sumX2 += x;
          sumY2 += y;
          count2++;            
          }
          else if (x > 320 && x <= 480){
          sumX3 += x;
          sumY3 += y;
          count3++;            
          }
        }
      }
   }
    
    if (count > 30) {
      loc = new PVector(sumX/count, sumY/count);
      moving = true;
    }
    else{
      moving = false;
    }
    
    if (count2 > 30) {
      loc2 = new PVector(sumX2/count2, sumY2/count2);
      moving2 = true;
    }
    else{
      moving2 = false;
    }
    
    if (count3 > 30) {
      loc3 = new PVector(sumX3/count3, sumY3/count3);
      moving3 = true;
    }
    else{
      moving3 = false;
    }
  }

  PVector getPos() {
    return loc;
  }
    PVector getPos2() {
    return loc2;
  }
    PVector getPos3() {
    return loc3;
  }
  
  boolean isMoving(){
    return moving;
  }
  
    boolean isMoving2(){
    return moving2;
  }

  boolean isMoving3(){
    return moving3;
  }

  void display() {
    PImage img = kinect2.getDepthImage();
    if (depth == null || img == null) return;
    display.loadPixels();
    for (int x = 0; x < kinect2.depthWidth; x++) {
      for (int y = 0; y < kinect2.depthHeight; y++) {
        int offset = (kinect2.depthWidth - x - 1) + y * kinect2.depthWidth;
        int rawDepth = depth[offset];
        int pix = x + y*display.width;
        if (rawDepth > 0 && rawDepth < threshold) {
          if (x < 160){
            display.pixels[pix] = color(43, 142, 162);
          }
          else if (x >= 160 && x < 320){
            display.pixels[pix] = color(242, 39, 100);
          }
          else if (x >= 320 && x <= 480){
            display.pixels[pix] = color(49, 242, 39);
          }
        } else {
          display.pixels[pix] = color(0);
        }
      }
    }
    display.updatePixels();
    image(display, 0, 0);
  }

  int getThreshold() {
    return threshold;
  }

  void setThreshold(int t) {
    threshold =  t;
  }
}