#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup()
{
    // load shader
    shader.load("mask");
    
    ofSetCircleResolution(128);
    ofEnableSmoothing();
    
    // prepare original image
    image.load("IMG_7223.JPG");
    image.resize(100, 100);
    image.setAnchorPercent(0.5, 0.5);
    
    // fbo for canvas
    canvas.allocate(ofGetWidth(), ofGetHeight(), GL_RGBA, 8);
    canvas.begin();
    {
        ofClear(0, 0);
    }
    canvas.end();
    
    // fbo for masking
    mask.allocate(image.getWidth(), image.getHeight(), GL_RGBA, 8);
    mask.begin();
    {
        ofClear(0, 0);
        ofFill();
        ofSetColor(255, 255);
        ofDrawCircle(mask.getWidth() * 0.5, mask.getHeight() * 0.5, 40);
    }
    mask.end();






 





    
    
   
    
   
