import blobDetection.*;
import processing.video.*;
import themidibus.*;
import oscP5.*;
import netP5.*;

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
    videoinput = createImage(480, 500, RGB);

    blobdetection = new BlobDetection(480, 500);
    blobdetection.setPosDiscrimination(true);
    blobdetection.setThreshold(0.3f);

    midiport.list();
    //May need to change this for your computer, look at the outputs from the
    //line above, and change the '2' to the port you want
    midiport = new MidiBus(this, -1, 2);
    //Do not change the following ports unless you also change them in the MSAFluid sketch
    oscP5Location1 = new OscP5(this, 5001);
    location2 = new NetAddress("127.0.0.1", 6001);
}

void draw() {
    //Just use a white background, you can change it and be more funky if you like...
    background(255);

    //If the video is available, copy the current frame into the image, accounting for the
    //extra white space at the top
    if (video.available()) {
        video.read();
        videoinput.copy(video, 0, 80, 480, 420, 0, 80, 480, 420);
    }
    //Appy the blur algorithm to the video so that tiny blobs don't cause problems
    blurAlgorithm(videoinput, 10);
    //Compute the blobs for the current frame after the blur has been applied
    blobdetection.computeBlobs(videoinput.pixels);
    //Draw the blobs and their corrosponding edges
    drawBlobsAndEdges(true, true, blobdetection);

    /* Here is where we can do whatever we want. At the moment it is set up to iterate
        over every blob in the frame, get it's dimensions, and send that over OSC. If you 
        simultaneously run the MSAFluid sketch container within this folder it will work...
        ...to a degree. It currently goes crazy, but atleast the OSC communication works! */
    Blob b;
    for (int n = 0; n < blobdetection.getBlobNb (); n++) {
        b = blobdetection.getBlob(n);
        float blobx = b.x;
        float bloby = b.y;
        float blobw = b.w;
        float blobh = b.h;

        //Comment the OSC stuff out if you're only interested in MIDI stuff, not the visuals
        OscMessage myMessage = new OscMessage("/blob");
        myMessage.add(blobx);
        myMessage.add(bloby);
        myMessage.add(blobw);
        myMessage.add(blobh);
        oscP5Location1.send(myMessage, location2); 
        
        /* We can also do MIDI stuff in here, but I have not yet found a good way to track
            blobs so we can apply the same effect or whatver it used last time. So at the moment
            each blob can only be identified by it's index number in the array, which is recomputed
            at every frame. */
        //midiport.sendControllerChange(0, 1, int((b.x * 480) * 0.264));
    }
}

