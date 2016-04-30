import blobDetection.*;
import org.openkinect.processing.*;

KinectData kinect;

void setup() {
    size(480, 420);
    kinect = new KinectData(this);
}

void draw() {
    background(255);
    kinect.display();
}

// Adjust the threshold with key presses
void keyPressed() {
    int t = kinect.getThreshold();
    if (key == CODED) {
        if (keyCode == UP) {
            t +=5;
            kinect.setThreshold(t);
        } else if (keyCode == DOWN) {
            t -=5;
            kinect.setThreshold(t);
        }
    }
}