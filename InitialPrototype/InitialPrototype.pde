//Using MidiBus to send MIDI messages to the virtual MIDI ports
import themidibus.*;
//Using OpenKinect to grab the Kinect data
import org.openkinect.processing.*;

KinectTracker tracker;

MidiBus midi1;
MidiBus midi2;
MidiBus midi3;

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
  
  if (v1.x != lastX || v1.y != lastY) {
    int sendValue = int(v1.y * 0.308);
    midi1.sendControllerChange(0, 1, sendValue);
  }
  
  lastX = int(v1.x);
  lastY = int(v1.y);

  if (v2.x != lastX2 || v2.y != lastY2) {
    int sendValue = int(v2.y * 0.308);
    midi2.sendControllerChange(1, 2, sendValue);    
  }    
  
  lastX2 = int(v2.x);
  lastY2 = int(v2.y);
  
  if (v3.x != lastX3 || v3.y != lastY3) {
    int sendValue = int(v3.y * 0.308);
    midi3.sendControllerChange(3, 3, sendValue);     
  }    
 
  lastX3 = int(v3.x);
  lastY3 = int(v3.y);

}