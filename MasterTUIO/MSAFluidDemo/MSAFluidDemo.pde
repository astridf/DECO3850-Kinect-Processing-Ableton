
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
 * ***********************************************************************/

import msafluid.*;
import javax.media.opengl.GL2;
import oscP5.*;
import netP5.*;

OscP5 oscP5Location2;
NetAddress location1;

final float FLUID_WIDTH = 120;

float invWidth, invHeight;
float aspectRatio, aspectRatio2;

MSAFluidSolver2D fluidSolver;

ParticleSystem particleSystem;

PImage imgFluid;

boolean drawFluid = true;

void setup() {
    //size(960, 640, P3D); 
    size(displayWidth, displayHeight, P3D);
    oscP5Location2 = new OscP5(this, 6001);
    location1 = new NetAddress("127.0.0.1", 5001);
    invWidth = 1.0f/width;
    invHeight = 1.0f/height;
    aspectRatio = width * invHeight;
    aspectRatio2 = aspectRatio * aspectRatio;

    // create fluid and set options
    fluidSolver = new MSAFluidSolver2D((int)(FLUID_WIDTH), (int)(FLUID_WIDTH * height/width));
    fluidSolver.enableRGB(true).setFadeSpeed(0.003).setDeltaT(0.5).setVisc(0.0001);

    // create image to hold fluid picture
    imgFluid = createImage(fluidSolver.getWidth(), fluidSolver.getHeight(), RGB);

    // create particle system
    particleSystem = new ParticleSystem();
}


void mouseMoved() {
    float mouseNormX = mouseX * invWidth;
    float mouseNormY = mouseY * invHeight;
    float mouseVelX = (mouseX - pmouseX) * invWidth;
    float mouseVelY = (mouseY - pmouseY) * invHeight;
    addForce(mouseNormX, mouseNormY, mouseVelX, mouseVelY);
}

float blobX;

void oscEvent(OscMessage theOscMessage) {  
    float mouseNormX = theOscMessage.get(0).floatValue();
    float mouseNormY = theOscMessage.get(1).floatValue();
    float mouseVelX = (theOscMessage.get(2).floatValue()); //dropping the velocity by a bunch
    float mouseVelY = (theOscMessage.get(3).floatValue());
    addForce(mouseNormX, mouseNormY, mouseVelX, mouseVelY);
    
    blobX = theOscMessage.get(0).floatValue();
}

void draw() {
    fluidSolver.update();

    if (drawFluid) {
        for (int i=0; i<fluidSolver.getNumCells (); i++) {
            int d = 2;
            imgFluid.pixels[i] = color(fluidSolver.r[i] * d, fluidSolver.g[i] * d, fluidSolver.b[i] * d);
        }  
        imgFluid.updatePixels();//  fastblur(imgFluid, 2);
        image(imgFluid, 0, 0, width, height);
    } 

    particleSystem.updateAndDraw();
}

void mousePressed() {
    drawFluid ^= true;
}


void addForce(float x, float y, float dx, float dy) {
    float speed = dx * dx  + dy * dy * aspectRatio2;
    if (speed > 0) {
        if (x<0) x = 0; 
        else if (x>1) x = 1;
        if (y<0) y = 0; 
        else if (y>1) y = 1;

        float colorMult = 5;
        float velocityMult = 30.0f;

        int index = fluidSolver.getIndexForNormalizedPosition(x, y);

        color drawColor;

        colorMode(HSB, 360, 1, 1);
        float hue = ((x + y) * 180 + frameCount) % 360;
        drawColor = color(hue, 1, 1);
        colorMode(RGB, 1);  

        fluidSolver.rOld[index]  += 0;//red(drawColor) * colorMult;
        fluidSolver.gOld[index]  += 0;//green(drawColor) * colorMult;
        fluidSolver.bOld[index]  += 0;//blue(drawColor) * colorMult;
        
        //setting the colours based on column
         if(blobX < 0.3333){ //left
         fluidSolver.rOld[index]  = 255; 
       } else if(blobX > 0.3333 && blobX < 0.6666){ //middle
         fluidSolver.gOld[index]  = 255;
       } else{//right
         fluidSolver.bOld[index]  = 255;
       }

        particleSystem.addParticles(x * width, y * height, 50);
        fluidSolver.uOld[index] += dx * velocityMult;
        fluidSolver.vOld[index] += dy * velocityMult;
    }
}

