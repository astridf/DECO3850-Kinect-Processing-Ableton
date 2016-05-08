
class KinectData {
    
    // Depth threshold
    int depthThreshold = 800;
    
    // Depth data
    int[] depth;
    
    // What we'll show the user
    //PImage displayKinect;
    
    //Kinect2 class
    Kinect2 kinect2;
    

    
    KinectData(PApplet pa) {
        kinect2 = new Kinect2(pa);
        kinect2.initDepth();
        kinect2.initDevice();
        displayKinect = createImage(kinect2.depthWidth, kinect2.depthHeight, RGB);
       
        //Set up blob detection
        blobdetection = new BlobDetection(kinect2.depthWidth, kinect2.depthHeight);
        blobdetection.setPosDiscrimination(true);
        blobdetection.setThreshold(0.3f);
    }
    
    void display() {
        // Retrieve array of depth integers
        depth = kinect2.getRawDepth();
        // Retrieve depth image from Kinect
        PImage depthImg = kinect2.getDepthImage();
        // Being overly cautious here
        if (depth == null || depthImg == null) return;
        // Loads the pixel data for the display window into the pixels[] array
        displayKinect.loadPixels();
        // For each pixel horizontally...
        for (int x = 0; x < kinect2.depthWidth; x++) {
            // Check each pixel in the corrosponding vertical row
            for (int y = 0; y < kinect2.depthHeight; y++) {
                // Mirror the image
                int offset = (kinect2.depthWidth - x - 1) + y * kinect2.depthWidth;
                // Raw depth
                int rawDepth = depth[offset];
                int pix = x + y * displayKinect.width;
                // If infront of the threshold, change the colour of the pixel
                // Since we are only using this for blob detection, you will never actually see this colour
                if (rawDepth > 0 && rawDepth < depthThreshold) {
                    displayKinect.pixels[pix] = color(150, 50, 50);
                } 
                // If not infront of threshold, just make it black
                else {
                    displayKinect.pixels[pix] = color(0);
                }
            }
        }
        // Updates the display window with the data in the pixels[] array
        displayKinect.updatePixels();
        // Blur the frame since we don't care about precise edges
        // This also reduces the likelihood of random tiny blobs causing problems
        blurAlgorithm(displayKinect, 10);
        // Compute the blobs using the pixels in the Kinect depth image
        blobdetection.computeBlobs(displayKinect.pixels);
        // Draw the blobs and their corrosponding edges
        drawBlobsAndEdges(true, true, blobdetection);
        //midiport.sendControllerChange(0, 1, 0);
        int count1=0;
            int count2=0;
            int count3=0;
            Blob b;
            if (blobdetection.getBlobNb() == 0 ){
                 midiport.sendControllerChange(0, 7, 0);
            }
            else{
                 midiport.sendControllerChange(0, 7,80);
            }
            for (int n = 0; n < blobdetection.getBlobNb(); n++) {
                b = blobdetection.getBlob(n);
                if (b.x * width <= 160){
                   count1++;
                   midiLeft(b, count1);
                }
                else if (b.x * width > 160 && b.x * width < 320){
                    count2++;
                    midiMiddle(b, count2);
                }
                else{
                    count3++;
                    midiRight(b, count3);
            }
    }
    }
    
    // Return the depth threshold
    int getThreshold() {
        return depthThreshold;
    }
    // Change the depth threshold
    void setThreshold(int t) {
        depthThreshold = t;
    }
}

void midiLeft(Blob b, int num) {
    if (num == 1){
        midiport.sendControllerChange(0, 1, int((b.y * height) * 0.308));
    }
    else if (num == 2){
        midiport.sendControllerChange(0, 2, int((b.y * height) * 0.308));
    }
    else if (num == 3){
        midiport.sendControllerChange(0, 3, int((b.y * height) * 0.308));
    }
}

void midiMiddle(Blob b, int num) {
    if (num == 1){
        midiport.sendControllerChange(0, 1, int((b.y * height) * 0.308));
    }
    else if (num == 2){
        midiport.sendControllerChange(0, 2, int((b.y * height) * 0.308));
    }
    else if (num == 3){
        midiport.sendControllerChange(0, 3, int((b.y * height) * 0.308));
    }
}

void midiRight(Blob b, int num) {
    if (num == 1){
        midiport.sendControllerChange(0, 1, int((b.y * height) * 0.308));
    }
    else if (num == 2){
        midiport.sendControllerChange(0, 2, int((b.y * height) * 0.308));
    }
    else if (num == 3){
        midiport.sendControllerChange(0, 3, int((b.y * height) * 0.308));
    }
}
