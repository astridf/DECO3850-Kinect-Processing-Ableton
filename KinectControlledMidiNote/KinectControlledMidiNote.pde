import org.openkinect.processing.*;
import themidibus.*;

KinectTracker tracker;
MidiBus midiport;
boolean play = true;

// Store the previous position to check for movement
int previousX = 0;
int previousY = 0;

void setup() {
  size(480, 520);
  // Grab the list of Midi ports
  MidiBus.list();
  // Link up the Midi port, I'm using the inbuilt Microsoft GS Wavetable Synth on port 2
  midiport = new MidiBus(this, 1, 2);
  tracker = new KinectTracker(this);
}

void draw() {
  background(255);

  // Run the tracking analysis
  tracker.track();
  // Show the image
  tracker.display();

  // Let's draw the raw location
  PVector v1 = tracker.getPos();
  fill(50, 100, 250, 200);
  noStroke();
  ellipse(v1.x, v1.y, 20, 20);

  // Let's draw the "lerped" location
  PVector v2 = tracker.getLerpedPos();
  fill(100, 250, 50, 200);
  noStroke();
  ellipse(v2.x, v2.y, 20, 20);
  // Display some info
  int t = tracker.getThreshold();
  fill(0);
  text("Threshold: " + t + "    " +  "Framerate: " + int(frameRate) + "    " +
    "UP increase threshold, DOWN decrease threshold", 10, 500);
    
  // Midi channel
  int channel = 1;
  // Set the velocity of the note
  int velocity = 127;
  
  // Calculate position-based pitch value
  float x = (v1.x / width) * 20;
  float y = (v1.y / height) * 20;
  int pitch = int(60 + x + y);
  
  // If the mouse has moved, and play is set to true, play a note!
  if ((v1.x != previousX || v1.y != previousY) && play) {
    midiport.sendNoteOn(channel, pitch, velocity); 
  }
  
  //Add a short delay
  delay(200);
}

// Adjust the threshold with key presses
void keyPressed() {
  int t = tracker.getThreshold();
  if (key == CODED) {
    if (keyCode == UP) {
      t +=5;
      tracker.setThreshold(t);
    } else if (keyCode == DOWN) {
      t -=5;
      tracker.setThreshold(t);
    }
  }
}

// Press mouse button to toggle play status
void mousePressed() {
  play = !play; 
}