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
        ofDrawCircle(mask.getWidth() * 0.5, mask.getHeight() * 0.5, 40);
    
    }
    
    mask.end();
    
    for (int i = 0; i < 100; i++){
        
        positions.push_back(ofVec3f(ofRandom(500), ofRandom(500), ofRandom(-100, 100)));
    
    }
    
    
}

void ofApp::update(){
    
    canvas.begin();{
        
        ofClear(0, 0);
        
        
    
    }
    

}

void ofApp::draw(){

}

void ofApp::keyPressed(int key){

}

    
    
   
    
   
