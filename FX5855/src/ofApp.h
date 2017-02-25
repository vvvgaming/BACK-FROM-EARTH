#pragma once

#include "ofMain.h"
#include "ofxJpegGlitch.h"
#include "ofxCv.h"
#include "ofxFaceTrackerThreaded.h"
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
