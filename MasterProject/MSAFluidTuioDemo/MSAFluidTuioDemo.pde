
/***********************************************************************
 Copyright (c) 2008, 2009, Memo Akten, www.memo.tv
 *** The Mega Super Awesome Visuals Company ***
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *     * Neither the name of MSA Visuals nor the names of its contributors 
 *       may be used to endorse or promote products derived from this software
 *       without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, 
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS 
 * OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
 * OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE 
 * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE. 
 *
 * ***********************************************************************/ 

import msafluid.*;
import javax.media.opengl.GL2;
import java.text.*;
import java.util.*;


final float FLUID_WIDTH = 120;
float invWidth, invHeight;    // inverse of screen dimensions
float aspectRatio, aspectRatio2;
MSAFluidSolver2D fluidSolver;
ParticleSystem particleSystem;
PImage imgFluid;
boolean drawFluid = true;
ConfigurationBuilder cb = new ConfigurationBuilder();
Twitter twitter;
String sketchPath = "C:/Users/Daniel/Documents/Uni/0301/3850/3850Code/MasterProject/MSAFluidTuioDemo";
DateFormat dateFormat = new SimpleDateFormat("hh:mm a");
DateFormat saveFormat = new SimpleDateFormat("hhmm");
int lastTimeMovementDetected;
                       
//no response longer than 100 characters/////////////////onehundredcharacters//////////////////////
 String[] response = new String[] {
 "Good Work!", "Snappy Painting Champ!", "Looks sweet", "I peed a little at this one",  "wow, like awesome cool",
 "This is dope", "wow, great moves!", "super sexy painting", "magnifique", "with art like this, you must have good vibes!",
 "super duper lemon trooper", "straight radical work", "you're the Kobe Bryant of painting using MozART"," 'I loved this one' - Captain America",
 "SPECTACULAR!", "NICE!", "GRRRRRRRRRRRREAT!", "You sure know your way around spandex", "Spandex, more like Spandawesome!",
 "I would favourite this tweet if my human overloards programmed me to be able to", "crickey, thats some good painting there mate",
 "gr8 p8 m8", "tip top showing there chap, really gave it a good go!", "holy moley, I really like this one", "Look Lassey, someone did a cool painting with MozART",
 "This is so beautiful, it makes me question my very existance", "00010100 ERROR...TwitterBot cannot compute this much beauty. SHUTTING DOWN",
 "This picture is so pretty, it melted my cold steel robot heart", "You're like the Van Gogh of painting, oh wait Van Gogh was a painting.",
 "Twitter Rules! Facebook Drools! This picture sure doesn't drool though", "Y is for 'You rock', 'U is for yUo rock', O is for yuO 'rock'!",
 "I cannot think of a pun, my robot brain is not capable of humor, nice painting though", "10/10 would look at picture again",
 "So good it basically smacked the spit out of my mouth", "Props to you Mr Magoo, nice picture", "Im so sleepy, but this woke me up like a good cup of coffee, you got skills",
 "You're good kid real good, with my help you could be the best", "Picasso is a scrub compared to you", "straight trippin yo",
 "robot twitter is not capable of sight but even I know this picture is pretty good", "this picture proves that the terrorist havn't won....yet",
"If I could be a real human, my name would be Reginald Walter.  Not relevant but yer",
" 'I hate it' - Hitler.  Thats a good thing, who wants hitler to like there stuff?"
 };

void setup() {
    size(displayWidth, displayHeight, P3D);
    invWidth = 1.0f/width;
    invHeight = 1.0f/height;
    aspectRatio = width * invHeight;
    aspectRatio2 = aspectRatio * aspectRatio;

    // create fluid and set options
    fluidSolver = new MSAFluidSolver2D((int)(FLUID_WIDTH), (int)(FLUID_WIDTH * height/width));
    fluidSolver.enableRGB(true).setFadeSpeed(0.005).setDeltaT(0.5).setVisc(0.00008);

    // create image to hold fluid picture
    imgFluid = createImage(fluidSolver.getWidth(), fluidSolver.getHeight(), RGB);

    // create particle system
    particleSystem = new ParticleSystem();

    // init TUIO
    initTUIO();
    
    //get twitter access keys    
    cb.setOAuthConsumerKey("4ipuh2NN278XZggsjpUBdDyDD");//BdK3K2OYhIuBSas41zovnVSP7
    cb.setOAuthConsumerSecret("CVxlAT7T9L6JFD1clLkUyFNFU2b5Zl4gTL6qx7oQ9VkooWAtk7");//CYnqiQQx8wYYHlAvl9iNMNnQkwtsurLDzWr2FkfCNvxwuq6ttS
    cb.setOAuthAccessToken("727321708684681217-KR87hT0YKSj7UzucawZeZucH6fP2Y7n");//1371960072-kPN7N3r6qTIvk1mWVmJP7EIaDFj6i7KLTqKnPYE
    cb.setOAuthAccessTokenSecret("BErMebkc8F08H8Jllwg0jRktjSPb8RPSJYB0MsrYvfKem"); //78yRJaGv45cTrP6K2nEuzgs6vCNwLCSpRtH8FFBz2Z5MR
    twitter = new TwitterFactory(cb.build()).getInstance();
    
}


void mouseMoved() {
    float mouseNormX = mouseX * invWidth;
    float mouseNormY = mouseY * invHeight;
    float mouseVelX = (mouseX - pmouseX) * invWidth;
    float mouseVelY = (mouseY - pmouseY) * invHeight;

    addForce(mouseNormX, mouseNormY, mouseVelX, mouseVelY);
}

void draw() {
    updateTUIO();
    fluidSolver.update();

    if(drawFluid) {
        for(int i=0; i<fluidSolver.getNumCells(); i++) {
            int d = 2;
            imgFluid.pixels[i] = color(fluidSolver.r[i] * d, fluidSolver.g[i] * d, fluidSolver.b[i] * d);
        }  
        imgFluid.updatePixels();//  fastblur(imgFluid, 2);
        image(imgFluid, 0, 0, width, height);
    } 

    particleSystem.updateAndDraw();
    
    if(millis() - lastTimeMovementDetected > 10000){
    fluidSolver.reset();
      //T
         for(int x= 320; x < 445; x++){ particleSystem.addParticle(x,321);
       } for(int x= 321; x < 446; x++){ particleSystem.addParticle(383,x);
       };
     
     //O
         for(int x= 321; x < 446; x++){ particleSystem.addParticle(470,x); //vertical right
       } for(int x= 470; x < 595; x++){ particleSystem.addParticle(x,321); //horizontal top
       } for(int x= 321; x < 446; x++){ particleSystem.addParticle(595,x); //vertical left
       } for(int x= 470; x < 595; x++){ particleSystem.addParticle(x,446); //horizontal bottom
       }; 
       
     //U
         for(int x= 321; x < 446; x++){ particleSystem.addParticle(620,x);  
       } for(int x= 620; x < 745; x++){ particleSystem.addParticle(x,446); 
       } for(int x= 321; x < 446; x++){ particleSystem.addParticle(745,x);
       };
       
     //C
         for(int x= 770; x < 895; x++){ particleSystem.addParticle(x,321);
       } for(int x= 321; x < 446; x++){ particleSystem.addParticle(770,x);
       } for(int x= 770; x < 895; x++){ particleSystem.addParticle(x,446);
       }; 
       
     //H
         for(int x= 321; x < 446; x++){ particleSystem.addParticle(920,x);
       } for(int x= 920; x < 1025; x++){ particleSystem.addParticle(x,384);
       } for(int x= 321; x < 446; x++){ particleSystem.addParticle(1025,x);
       };  
   } 

}

void mousePressed() {
    drawFluid ^= true;
}

void keyPressed() {
    switch(key) {
    case 'r': 
        renderUsingVA ^= true; 
        println("renderUsingVA: " + renderUsingVA);
        break;
    }
}

//detects key release and creates picture file + tweet content
void keyReleased(){
   switch(key){
     case 'w':
        //println("W key was pressed and released");
        File newFile = new File(sketchPath,"picture.jpg");
        saveFrame("picture.jpg");
        
        int idx = new Random().nextInt(response.length);
        String tweetResponse = (response[idx]);
        Date date = new Date();
        uploadPicture(newFile, dateFormat.format(date) +": "+tweetResponse+ " #GoodVibes #MozART",twitter);
        
        File newName = new File(sketchPath+"/pictures", "picture"+saveFormat.format(date)+".jpg");
        newFile.renameTo(newName);
     break;
   } 
}

//gets picture file and uploads to twitter
void uploadPicture(File file, String message, Twitter twitter)  {
  // println(file); 
  try{
        StatusUpdate status = new StatusUpdate(message);
        status.setMedia(file);
        twitter.updateStatus(status);}
    catch(TwitterException e){
        println("Error: " + e);
    }
    //println("uploadPic ran");
    
}

// add force and dye to fluid, and create particles
void addForce(float x, float y, float dx, float dy) {
    float speed = dx * dx  + dy * dy * aspectRatio2;    // balance the x and y components of speed with the screen aspect ratio

    if(speed > 0) {
        if(x<0) x = 0; 
        else if(x>1) x = 1;
        if(y<0) y = 0; 
        else if(y>1) y = 1;

        float colorMult = 5;
        float velocityMult = 30.0f;

        int index = fluidSolver.getIndexForNormalizedPosition(x, y);

        color drawColor;

        colorMode(HSB, 360, 1, 1);
        float hue = ((x + y) * 180 + frameCount) % 360;
        drawColor = color(hue, 1, 1);
        colorMode(RGB, 1);  

        fluidSolver.rOld[index]  += red(drawColor) * colorMult;
        fluidSolver.gOld[index]  += green(drawColor) * colorMult;
        fluidSolver.bOld[index]  += blue(drawColor) * colorMult;

        particleSystem.addParticles(x * width, y * height, 30);
        fluidSolver.uOld[index] += dx * velocityMult;
        fluidSolver.vOld[index] += dy * velocityMult;
        
        lastTimeMovementDetected = millis();
    }
}

