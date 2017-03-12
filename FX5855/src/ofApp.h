#pragma once

#include "ofMain.h"
#include "ofxJpegGlitch.h"
#include "ofxGui.h"

class ofApp : public ofBaseApp {
public:
    void setup();
    void setupImages(string, string);
    void update();
    void updateDecision();
    void updateGlitch();
    void draw();
    void drawClassifier();
    void exit();

    void mousePressed(int x, int y, int button);
    void mouseReleased(int x, int y, int button);
    void windowResized(int w, int h);
    void dragEvent(ofDragInfo dragInfo);
    void gotMessage(ofMessage msg);

private:
    ofVideoGrabber grabber;
    ofxFaceTrackerThreaded tracker;
    
    
    
    vector<ofImage> images;
    int imageIndex;
    int glitchCount;
    enum GlitchType {NONE, JPEG, GRAY} glitchType;
    ofxJpegGlitch jpeg;
    ofShader shader;
    
    ofxPanel gui;
