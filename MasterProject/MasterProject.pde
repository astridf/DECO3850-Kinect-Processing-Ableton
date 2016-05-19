import blobDetection.*;
import org.openkinect.processing.*;
import themidibus.*;
import oscP5.*;
import netP5.*;

//Need collections so that we can use the inbuilt shuffle() method
import java.util.Collections;
//Array of integers 0, 1, 2 used to represent track 1, 2, and 3 of music
ArrayList<Integer> instruments = new ArrayList<Integer>();

//Create the midibus port
MidiBus midiport;
KinectData kinect;
//Create instance of blobdetection
BlobDetection blobdetection;
//Set up osc location
OscP5 oscP5Location1;
//Set up osc net address
NetAddress location2;
//Image which will contain each frame of the video
PImage displayKinect;


void setup() {
    size(480, 420);
    kinect = new KinectData(this);
    midiport = new MidiBus(this, -1, 3);
    oscP5Location1 = new OscP5(this, 3334);
    location2 = new NetAddress("127.0.0.1", 3333);
    instruments.add(0);
    instruments.add(1);
    instruments.add(2);
}

void draw() {
    background(0);
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
