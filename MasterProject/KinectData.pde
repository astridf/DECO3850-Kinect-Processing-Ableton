
class KinectData {
    
    // Depth threshold
    int depthThreshold = 800;
    
    // Depth data
    int[] depth;
    
    // What we'll show the user
    PImage displayKinect;
    
    //Kinect2 class
    Kinect2 kinect2;
    
    //BlobDetection class
    BlobDetection blobdetection;
    
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