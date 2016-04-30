
import themidibus.*;
import org.openkinect.processing.*;

KinectTracker tracker;
MidiBus midi1;
MidiBus midi2;
MidiBus midi3;
boolean play = false;
boolean play2 = false;
boolean play3 = false;
int lastX = 0;
int lastY = 0;

int lastX2 = 0;
int lastY2 = 0;

int lastX3 = 0;
int lastY3 = 0;

void setup() {
  size(480, 420);
  noStroke();
  midi1 = new MidiBus(this, 0, 3);
  midi2 = new MidiBus(this, 0, 4);
  midi3 = new MidiBus(this, 0, 5);
  tracker = new KinectTracker(this);
}

void draw() {
  background(0);
  tracker.track();

  tracker.display();

  PVector v1 = tracker.getPos();
  fill(50, 100, 250, 200);
  noStroke();
  ellipse(v1.x, v1.y, 20, 20);
  
    PVector v2 = tracker.getPos2();
  fill(50, 100, 250, 200);
  noStroke();
  ellipse(v2.x, v2.y, 20, 20);
  
    PVector v3 = tracker.getPos3();
  fill(50, 100, 250, 200);
  noStroke();
  ellipse(v3.x, v3.y, 20, 20);
  
  float p = 60; 
  float x = (v1.x / width) * 20;
  float y = (v1.y / height) * 20;
  int pitch = int(p + x + y);
  if ((v1.x != lastX || v1.y != lastY) && play) {
    int sendValue = int(v1.y * 0.308);
       println(sendValue);
      midi1.sendControllerChange(0, 1, sendValue);
  }
  
  lastX = int(v1.x);
  lastY = int(v1.y);
    
  float p2 = 60; 
  float x2 = (v2.x / width) * 20;
  float y2 = (v2.y / height) * 20;
  int pitch2 = int(p2 + x2 + y2);
  if ((v2.x != lastX2 || v2.y != lastY2) && play2) {
    int sendValue = int(v2.y * 0.308);
      midi2.sendControllerChange(1, 2, sendValue);    
  }    
  
  lastX2 = int(v2.x);
  lastY2 = int(v2.y);
  
  float p3 = 60; 
  float x3 = (v3.x / width) * 20;
  float y3 = (v3.y / height) * 20;
  int pitch3 = int(p3 + x3 + y3);
  if ((v3.x != lastX3 || v3.y != lastY3) && play3) {
    int sendValue = int(v3.y * 0.308);
      midi3.sendControllerChange(3, 3, sendValue);     
  }    
 
  lastX3 = int(v3.x);
  lastY3 = int(v3.y);

  delay(200);
  if (tracker.isMoving()){
    play = true;
  }
  else{
    play = false;
  }
  
  if (tracker.isMoving2()){
    play2 = true;
  }
  else{
    play2 = false;
  }
  
  if (tracker.isMoving3()){
    play3 = true;
  }
  else{
    play3 = false;
  }

   
}

void mousePressed() {
  play = !play; 
}