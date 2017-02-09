#pragma once

#include "ofMain.h"

class ofApp : public ofBaseApp{
    
public:
    
    void setup();
    void update();
    void draw();
    void keyPressed(int key);
    
    ofShader shader;
    ofImage image;
    
    ofFbo canvas;
    ofFbo mask;
    
    vector<ofVec3f> positions;
    
    ofEasyCam cam;

};
