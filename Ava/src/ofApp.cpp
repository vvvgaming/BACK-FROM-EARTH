#include "ofApp.h"

void ofApp::setup(){
    
    ofBackground(0);
    

}

void ofApp::update(){
    
    for(int i = 0; i < 100000; i++){
        
        float x = random(ofGetWidth/2);
        float y = random(ofGetHeight);
        point(x,y);
    
    }

}


void ofApp::draw(){
    
    ofTranslate(OfGetW
                idth/2, 0);
    float x = (random(width/2) + random(width/2) + random(width/2) + random(width/2) + random(width/2)) /5.0;
    
    float y = (random(height) + random(height) + random(height) + random(height) + random(height)) / 5.0;

}








