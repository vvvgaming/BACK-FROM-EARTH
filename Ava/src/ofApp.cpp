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
    
    ofTranslate(width/2, 0);
    float x = (random(width/2) + random(random))

}








