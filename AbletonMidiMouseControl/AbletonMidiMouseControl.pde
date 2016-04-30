// Include TheMidiBus library
import themidibus.*;

// Create new MidiBus objects
MidiBus mb;
MidiBus mb2;
MidiBus mb3;

//Set playing to be off automatically, click mouse to begin
boolean play = false;

// Last mouse coordinates
int lastX = 0;
int lastY = 0;

// Setup sketch
void setup() {
  size(480, 420);
  background(0);
  noStroke();
  // List available MIDI inputs and outputs
  MidiBus.list();
  /* You may need to change "3","4" and "5" based on the 
   MIDI ports available to you */
  mb = new MidiBus(this, -1, 3);
  mb2 = new MidiBus(this, -1, 4);
  mb3 = new MidiBus(this, -1, 5);
}

// Draw loop
void draw() {
  // Draw three rectangles for clarity
   fill(153);
   rect(0, 0, 160, 420);
 
   fill(0);
   rect(160, 0, 160, 420);
   
   fill(153);
   rect(320, 0, 160, 420);
  
  // If mouse in left rectangle, send Midi to first MidiBus
  if(mouseX < 160){
     // Scale mouse position to a value between 0 and 127
     int sendValue = int(mouseY * 0.308);
     mb.sendControllerChange(0, 1, sendValue);
  }
  // If mouse in middle rectangle, send Midi to second MidiBus
  else if(mouseX > 160 && mouseX < 320){
    // Scale mouse position to a value between 0 and 127
     int sendValue = int(mouseY * 0.308);
     mb2.sendControllerChange(1, 2, sendValue);    
  }
  // If mouse in right rectangle, send Midi to third MidiBus
  else if(mouseX > 320 && mouseX < 480){
    // Scale mouse position to a value between 0 and 127
     int sendValue = int(mouseY * 0.308);
     mb3.sendControllerChange(3, 3, sendValue);    
  }
}

// Toggle playing
void mousePressed() {
  play = !play; 
}