import blobDetection.*;
import processing.video.*;
import themidibus.*;
import oscP5.*;
import netP5.*;
import java.util.Collections;
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
// An array of integers we will write to, pass into the blob array and then re-write
// {x, y, w, h}
float[] previousBlob = {
    0, 0, 0, 0
};
// An array which will contain arrays of blob information
// {{x, y, w, h}, {x, y, w, h}, {x, y, w, h}, ...}
float[][] previousBlobsArray = new float[30][4];

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
    //line above, and change the '2' to the port you want
    midiport = new MidiBus(this, -1, 3);
    //Do not change the following ports unless you also change them in the MSAFluid sketch
    oscP5Location1 = new OscP5(this, 5001);
    location2 = new NetAddress("127.0.0.1", 6001);
    
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
    drawBlobsAndEdges(true, true, blobdetection);
    
     sendMIDI(blobdetection);
}

