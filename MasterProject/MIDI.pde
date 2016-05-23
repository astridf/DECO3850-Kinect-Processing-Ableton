
//Array of arrays containing the numbers for the mapped controller change thingos
int[][] midi1 = {{1,2,3}, {4,5,6}, {7,8,9} };

void sendMIDI(BlobDetection blobdetection) {

    //If there is atleast one blob
    if (blobdetection.getBlobNb() > 0){
        
        //CHANGE THIS TO WHATEVER CHANNEL WE ARE USING
         int channel = 1;

         //If there is one blob, get the first effect from the first instrument in the random order
         if (blobdetection.getBlobNb() == 1){
             midiport.sendControllerChange(channel, midi1[instruments.get(0)][2], 127);             
             midiport.sendControllerChange(channel, midi1[instruments.get(0)][0], calculateMIDIvalue(blobdetection.getBlob(0).x, blobdetection.getBlob(0).y));

         }
         //Two blobs, play one random effect for first and second instruments
         else if (blobdetection.getBlobNb() == 2){
             midiport.sendControllerChange(channel, midi1[instruments.get(0)][2], 127); 
             midiport.sendControllerChange(channel, midi1[instruments.get(1)][2], 127); 
             midiport.sendControllerChange(channel, midi1[instruments.get(0)][0], calculateMIDIvalue(blobdetection.getBlob(0).x, blobdetection.getBlob(0).y));
             midiport.sendControllerChange(channel, midi1[instruments.get(1)][0], calculateMIDIvalue(blobdetection.getBlob(1).x, blobdetection.getBlob(1).y));
         }
         //Three blobs, play one random effect for first, second, and third instruments
         else if (blobdetection.getBlobNb() == 3){
             midiport.sendControllerChange(channel, midi1[instruments.get(0)][2], 127); 
             midiport.sendControllerChange(channel, midi1[instruments.get(1)][2], 127); 
             midiport.sendControllerChange(channel, midi1[instruments.get(2)][2], 127); 
             midiport.sendControllerChange(channel, midi1[instruments.get(0)][0], calculateMIDIvalue(blobdetection.getBlob(0).x, blobdetection.getBlob(0).y));
             midiport.sendControllerChange(channel, midi1[instruments.get(1)][0], calculateMIDIvalue(blobdetection.getBlob(1).x, blobdetection.getBlob(1).y));
             midiport.sendControllerChange(channel, midi1[instruments.get(2)][0], calculateMIDIvalue(blobdetection.getBlob(2).x, blobdetection.getBlob(2).y));
         }
         else if (blobdetection.getBlobNb() == 4){
             midiport.sendControllerChange(channel, midi1[instruments.get(0)][2], 127); 
             midiport.sendControllerChange(channel, midi1[instruments.get(1)][2], 127); 
             midiport.sendControllerChange(channel, midi1[instruments.get(2)][2], 127); 
             midiport.sendControllerChange(channel, midi1[instruments.get(0)][0], calculateMIDIvalue(blobdetection.getBlob(0).x, blobdetection.getBlob(0).y));
             midiport.sendControllerChange(channel, midi1[instruments.get(1)][0], calculateMIDIvalue(blobdetection.getBlob(1).x, blobdetection.getBlob(1).y));
             midiport.sendControllerChange(channel, midi1[instruments.get(2)][0], calculateMIDIvalue(blobdetection.getBlob(2).x, blobdetection.getBlob(2).y));
             midiport.sendControllerChange(channel, midi1[instruments.get(0)][1], calculateMIDIvalue(blobdetection.getBlob(3).x, blobdetection.getBlob(3).y));
         }
         else if (blobdetection.getBlobNb() == 5){
             midiport.sendControllerChange(channel, midi1[instruments.get(0)][2], 127); 
             midiport.sendControllerChange(channel, midi1[instruments.get(1)][2], 127); 
             midiport.sendControllerChange(channel, midi1[instruments.get(2)][2], 127); 
             midiport.sendControllerChange(channel, midi1[instruments.get(0)][0], calculateMIDIvalue(blobdetection.getBlob(0).x, blobdetection.getBlob(0).y));
             midiport.sendControllerChange(channel, midi1[instruments.get(1)][0], calculateMIDIvalue(blobdetection.getBlob(1).x, blobdetection.getBlob(1).y));
             midiport.sendControllerChange(channel, midi1[instruments.get(2)][0], calculateMIDIvalue(blobdetection.getBlob(2).x, blobdetection.getBlob(2).y));
             midiport.sendControllerChange(channel, midi1[instruments.get(0)][1], calculateMIDIvalue(blobdetection.getBlob(3).x, blobdetection.getBlob(3).y));
             midiport.sendControllerChange(channel, midi1[instruments.get(1)][1], calculateMIDIvalue(blobdetection.getBlob(4).x, blobdetection.getBlob(4).y));
         }
         else if (blobdetection.getBlobNb() == 6){
             midiport.sendControllerChange(channel, midi1[instruments.get(0)][2], 127); 
             midiport.sendControllerChange(channel, midi1[instruments.get(1)][2], 127); 
             midiport.sendControllerChange(channel, midi1[instruments.get(1)][2], 127); 
             midiport.sendControllerChange(channel, midi1[instruments.get(0)][0], calculateMIDIvalue(blobdetection.getBlob(0).x, blobdetection.getBlob(0).y));
             midiport.sendControllerChange(channel, midi1[instruments.get(1)][0], calculateMIDIvalue(blobdetection.getBlob(1).x, blobdetection.getBlob(1).y));
             midiport.sendControllerChange(channel, midi1[instruments.get(2)][0], calculateMIDIvalue(blobdetection.getBlob(2).x, blobdetection.getBlob(2).y));
             midiport.sendControllerChange(channel, midi1[instruments.get(0)][1], calculateMIDIvalue(blobdetection.getBlob(3).x, blobdetection.getBlob(3).y));
             midiport.sendControllerChange(channel, midi1[instruments.get(1)][1], calculateMIDIvalue(blobdetection.getBlob(4).x, blobdetection.getBlob(4).y));
             midiport.sendControllerChange(channel, midi1[instruments.get(2)][1], calculateMIDIvalue(blobdetection.getBlob(5).x, blobdetection.getBlob(5).y));
         }
    }
    //If there are no blobs
    else {
         //Shuffle the order of instruments
         Collections.shuffle(instruments);
         midiport.sendControllerChange(1, midi1[instruments.get(0)][2], 30); 
         midiport.sendControllerChange(1, midi1[instruments.get(1)][2], 30); 
         midiport.sendControllerChange(1, midi1[instruments.get(2)][2], 30); 
    }
}
//currentY = (((currentY * 420f) - 150f) /270f);


int calculateMIDIvalue(float x, float y){
    x = x * 480f;
    y = (y * 420f) - 150f;
    //Map the x and y values to a new value between 0 and 127
    if (x < 160){
        println(int(map(x + y, 0, 580, 0, 127)));
        return int(map(x + y, 0, 580, 0, 127));
    }
    else if (x >= 160 && x < 320) {
        println(int(map(x + y, 160, 740, 0, 127)));
        return int(map(x + y, 160,740, 0, 127));
    }
    else if (x >= 320 && x <= 480) {
        println(int(map(x + y, 320, 900, 0, 127)));
        return int(map(x + y, 320, 900, 0, 127));
    }
    else{
        return 0;
    }
//    return int(map((x * 480) + (y * 420), 0, 900, 0, 127));
}
