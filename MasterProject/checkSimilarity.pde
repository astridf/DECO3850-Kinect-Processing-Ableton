
void checkSimilarity(){
    
    Blob b;
    
    for (int n = 0; n < blobdetection.getBlobNb(); n++) {
        
        b = blobdetection.getBlob(n);
        float currentX = b.x;
        float currentY = b.y;
        float currentWidth = b.w;
        float currentHeight = b.w;
        
        for (int i = 0; i < previousBlobsArray.length; i++) {
            
            float previousX = previousBlobsArray[i][0];
            float previousY = previousBlobsArray[i][1];
            float previousWidth = previousBlobsArray[i][2];
            float previousHeight = previousBlobsArray[i][3];
            
            if (isSimilarX(previousX * width, currentX * width) && isSimilarY(previousY*height, currentY*height)){
                if (isSimilarW(previousWidth * width, currentWidth * width) && isSimilarH(previousHeight*height, currentHeight*height)){
                    OscMessage myMessage = new OscMessage("/blob");
                    myMessage.add(currentX);
                    myMessage.add(currentY );
                    myMessage.add(currentX - previousX);
                    myMessage.add(currentY - previousY);
                    oscP5Location1.send(myMessage, location2); 
                }
            }
        }
    }
}

int similarity = 60;

boolean isSimilarX(float x1, float x2){
    if ((x1 - similarity) < x2 && x2 < (x1 + similarity)){
        return true;
    }
    else {
        return false;
    }
}

boolean isSimilarY(float y1, float y2){
    if ((y1 - similarity) < y2 && y2 < (y1 + similarity)){
        return true;
    }
    else {
        return false;
    }
}

boolean isSimilarW(float w1, float w2){
    if ((w1 - similarity) < w2 && w2 < (w1 + similarity)){
        return true;
    }
    else {
        return false;
    }
}

boolean isSimilarH(float h1, float h2){
    if ((h1 - similarity) < h2 && h2 < (h1 + similarity)){
        return true;
    }
    else {
        return false;
    }
}
