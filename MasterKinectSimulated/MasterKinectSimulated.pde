import blobDetection.*;
import processing.video.*;
import themidibus.*;
import oscP5.*;
import netP5.*;

//Need collections so that we can use the inbuilt shuffle() method
import java.util.Collections;
//Array of integers 0, 1, 2 used to represent track 1, 2, and 3 of music
ArrayList<Integer> instruments = new ArrayList<Integer>();

//Create the midibus port
MidiBus midiport;
//Create the video object
Movie video;
//Create instance of blobdetection
BlobDetection blobdetection;
//Set up osc location
OscP5 oscP5Location1;
//Set up osc net address
NetAddress location2;
//Image which will contain each frame of the video
PImage videoinput;

void setup() {
    size(480, 500);
    video = new Movie(this, "simulation.avi");
    video.loop();  
    video.play();
    videoinput = createImage(480, 450, RGB);

    blobdetection = new BlobDetection(480, 450);
    blobdetection.setPosDiscrimination(true);
    blobdetection.setThreshold(0.3f);

    midiport.list();
    //May need to change this for your computer, look at the outputs from the
    //line above, and change the third parameter to the port you want
    midiport = new MidiBus(this, -1, 5);
    //Do not change the following ports unless you also change them in the MSAFluid sketch
    oscP5Location1 = new OscP5(this, 3334);
    location2 = new NetAddress("127.0.0.1", 3333);

    instruments.add(0);
    instruments.add(1);
    instruments.add(2);
}

void draw() {
    //Just use a white background, you can change it and be more funky if you like...
    background(255);

    //If the video is available, copy the current frame into the image, accounting for the
    //extra white space at the top
    if (video.available()) {
        video.read();
        videoinput.copy(video, 0, 30, 480, 420, 0, 30, 480, 420);
    }
    //Appy the blur algorithm to the video so that tiny blobs don't cause problems
    blurAlgorithm(videoinput, 10);
    //Compute the blobs for the current frame after the blur has been applied
    blobdetection.computeBlobs(videoinput.pixels);

    //Draw the blobs and their corrosponding edges
    //Only really required for testing, since we don't actually have to SEE the blobs to know they are being registered
    drawBlobsAndEdges(true, true, blobdetection);

    //Call the function that handles all the MIDI, and pass it the instance of blobdetection
    sendMIDI(blobdetection);
}

