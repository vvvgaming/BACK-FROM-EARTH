#include "ofApp.h"

void ofApp::setup(){
    
    shader.load("mask");
    
    ofSetCircleResolution(120);
    ofEnableSmoothing();
    
    image.load("");
    image.resize(100, 100);
    image.setAnchorPercent(0.5, 0.5);
    
    canvas.allocate(ofGetWidth(), ofGetHeight(), GL_RGBA, 8);
    
    canvas.begin();{
    
        ofClear(0, 0);
    }
    
    canvas.end();
    
    
    
    mask.allocate(ofGetWidth(), ofGetHeight(), GL_RGBA, 8);
    
    mask.begin();{
    
        ofClear(0, 0);
        ofFill();
        ofSetColor(255, 255);
        
    
    }
    
    
}

void ofApp::update(){

}

void ofApp::draw(){

}

void ofApp::keyPressed(int key){

}

    
    
   
    
   
