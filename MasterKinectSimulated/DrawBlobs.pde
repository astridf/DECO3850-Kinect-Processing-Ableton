
void drawBlobsAndEdges(boolean drawBlobs, boolean drawEdges, BlobDetection blobdetection) {
    
    noFill();
    Blob b;
    EdgeVertex eA, eB;
  
    for (int n = 0; n < blobdetection.getBlobNb(); n++) {
        
        b = blobdetection.getBlob(n);
        checkSimilarity();
        previousBlob[0] = b.x;
        previousBlob[1] = b.y;
        previousBlob[2] = b.w;
        previousBlob[3] = b.h;
        previousBlobsArray[n] = previousBlob;
            
        if (b != null && b.h > 0) {
            
            if (drawEdges) {
                strokeWeight(3);
                stroke(0, 255, 0);
                for (int m = 0; m < b.getEdgeNb(); m++) {
                    eA = b.getEdgeVertexA(m);
                    eB = b.getEdgeVertexB(m);
                    if (eA != null && eB != null) line(eA.x * width, eA
                        .y * height, eB.x * width, eB.y * height);
                }
            }
            
            if (drawBlobs) {
                strokeWeight(1);
                stroke(255, 0, 0);
                rect(b.xMin * width, b.yMin * height, b.w * width, b.h *
                    height);
            }
//            textSize(22);
//            fill(0, 102, 153, 51);
//            text(n, b.x * width, b.y * height); 
        }
    }
}
