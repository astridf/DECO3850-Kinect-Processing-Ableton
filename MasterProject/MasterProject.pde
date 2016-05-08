import blobDetection.*;
import org.openkinect.processing.*;
import themidibus.*;
import oscP5.*;
import netP5.*;

MidiBus midiport;
KinectData kinect;
    //BlobDetection class
    BlobDetection blobdetection;
OscP5 oscP5Location1;
NetAddress location2;
//Image which will contain each frame of the video
PImage displayKinect;
// An array of integers we will write to, pass into the blob array and then re-write
// {x, y, w, h}
float[] previousBlob = {
    0, 0, 0, 0
};
// An array which will contain arrays of blob information
// {{x, y, w, h}, {x, y, w, h}, {x, y, w, h}, ...}
float[][] previousBlobsArray = new float[30][4];

void setup() {
    size(480, 420);
    kinect = new KinectData(this);
   
    
    midiport = new MidiBus(this, -1, 4);
    oscP5Location1 = new OscP5(this, 5001);
    location2 = new NetAddress("127.0.0.1", 6001);
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
