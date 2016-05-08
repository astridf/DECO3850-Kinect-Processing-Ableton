
import themidibus.*;

MidiBus midi;

void setup() {
    size(200, 200);
    midi = new MidiBus(this, 0, 3);
    //Map from 0 to 127 just once
    mapping();
}

void draw() {
    //Use this if you want it to repeat over and over
    //mapping();
}
// http://www.ccarh.org/courses/253/handout/controllers/
void mapping() {
    int channel = 0;
    int number = 1;
    int i;
    for (i = 0; i <= 127; i++) {
        println(i);
        midi.sendControllerChange(channel, number, i);
    }
}
//sendControllerChange(int channel, int number, int value)
//channel - the channel associated with the message.
//number - the number associated with the message.
//value - the value associated with the message.
//Java docs for midibus here: http://www.smallbutdigital.com/themidibus/themidibus/MidiBus.html

