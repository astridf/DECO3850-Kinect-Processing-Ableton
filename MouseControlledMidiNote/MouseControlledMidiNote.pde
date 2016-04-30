
import themidibus.*;

MidiBus midiport;
boolean play = false;

// Store the previouse mouse position to check for movement
int previousMouseX = 0;
int previousMouseY = 0;

void setup() {
  size(480, 420);
  background(0);
  // Grab the list of Midi ports
  MidiBus.list();
  // Link up the Midi port, I'm using the inbuilt Microsoft GS Wavetable Synth on port 2
  midiport = new MidiBus(this, 0, 2);
}

// Draw loop
void draw() {
  // Midi channel
  int channel = 1;
  // Set the velocity of the note
  int velocity = 127;
  
  // Calculate position-based pitch value
  float x = (float(mouseX) / width) * 20;
  float y = (float(mouseY) / height) * 20;
  int pitch = int(60 + x + y);
  
  // If the mouse has moved, and play is set to true, play a note!
  if ((mouseX != previousMouseX || mouseY != previousMouseY) && play) {
    midiport.sendNoteOn(channel, pitch, velocity); 
  }
  
  //Add a short delay
  delay(200);
}

// Press mouse button to toggle play status
void mousePressed() {
  play = !play; 
}