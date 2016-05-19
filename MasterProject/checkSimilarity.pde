int frameNum = 0;
float[][] sendBlobs;
OscBundle oSCBundle;
void checkSimilarity() {

    Blob b;
    float[] foundBlob = {
        0, 0, 0, 0
    };
    sendBlobs = new float[blobdetection.getBlobNb()][4];
    oSCBundle = new OscBundle();
    OscMessage oSCMessage2 = null;
    OscMessage oSCMessage4 = null;
    OscMessage oSCMessage5 = null;
    OscMessage oSCMessage = new OscMessage("/tuio/2Dcur");
    oSCMessage.add("alive");
    //Iterate through every blob detected
    for (int n = 0; n < blobdetection.getBlobNb (); n++) {
        oSCMessage.add(n);
        //Get the current blob
        b = blobdetection.getBlob(n);

        float currentX = b.x;
        float currentY = b.y;
        float currentWidth = b.w;
        float currentHeight = b.w;
//            currentY = ((currentY * 300f)
        for (int i = 0; i < 5; i++) {
            if (n == 0) {
                oSCMessage2 = new OscMessage("/tuio/2Dcur");
                //println(currentX);
                oSCMessage2.add("set");
                oSCMessage2.add(0);
                oSCMessage2.add(currentX);
                oSCMessage2.add(currentY);
                oSCMessage2.add(0f);
                oSCMessage2.add(0f);
                oSCMessage2.add(float(2));
            } else if (n == 1) {
                oSCMessage4 = new OscMessage("/tuio/2Dcur");
                oSCMessage4.add("set");
                oSCMessage4.add(1);
                oSCMessage4.add(currentX);
                oSCMessage4.add(currentY);
                oSCMessage4.add(0f);
                oSCMessage4.add(0f);
                oSCMessage4.add(float(2));
            } else if (n == 2) {
                oSCMessage5 = new OscMessage("/tuio/2Dcur");
                oSCMessage5.add("set");
                oSCMessage5.add(2);
                oSCMessage5.add(currentX);
                oSCMessage5.add(currentY);
                oSCMessage5.add(0f);
                oSCMessage5.add(0f);
                oSCMessage5.add(float(2));
            }      
        }
    }
    oSCBundle.add(oSCMessage);
    if (oSCMessage2 != null) {
        oSCBundle.add(oSCMessage2);
    }
    if (oSCMessage4 != null) {
        oSCBundle.add(oSCMessage4);
    }
    if (oSCMessage5 != null) {
        oSCBundle.add(oSCMessage5);
    }
    OscMessage oSCMessage3 = new OscMessage("/tuio/2Dcur");
    oSCMessage3.add("fseq");
    oSCMessage3.add(frameNum);
    oSCBundle.add(oSCMessage3);
    oscP5Location1.send(oSCBundle, location2);
    frameNum++;
}
