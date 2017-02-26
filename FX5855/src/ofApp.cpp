#include "ofApp.h"

using namespace ofxCv;


void ofApp::setup(){
    ofShowCursor();
    
    ofSetFrameRate(30);
    
    jpeg.setup(20, 40, 80);
    
    shader.load("shaders/shader.vert", "shaders/shader.frag");
    
    gui.setup();
    gui.add(ratioThreshold.setup( "ratio", 0.75f, 0, 1 ));
    
    setupImages("images", "png");
    
    tracker.setup();
    tracker.setRescale(.5);
    
    classifier.reset();
    classifierInited = false;
    
    grabber.initGrabber(640, 480);
    
    
    imageIndex = 0;
    glitchCount = 0;


}

void ofApp::setupImages(string dirName, string ext){
    // load images in images folder
    ofDirectory dir(dirName);
    dir.allowExt(ext);
    dir.listDir();
    for(int i = 0; i < dir.size(); i++) {
        images.push_back(ofImage());
        images.back().loadImage(dirName + "/" + dir.getName(i));
    }
    
}

void ofApp::update(){
    ofSetWindowTitle(ofToString(ofGetFrameRate()));
    
    grabber.update();
    if(grabber.isFrameNew()) {
        tracker.update(toCv(grabber));
    }
    
    if(tracker.getFound() && !classifierInited) {
        classifier.load("expressions");
        classifierInited = true;
    }
    
    updateDecision();
    updateGlitch();

}

void ofApp::updateDecision(){
    classifier.classify(tracker);
    
    int primary = classifier.getPrimaryExpression();
    float pTotal = 0;
    float pPrime = classifier.getProbability(primary);
    for(int i = 0; i < classifier.size(); i++){
        pTotal += classifier.getProbability(i);
    }
    

    if(pPrime / pTotal < ratioThreshold) {
       
        if(classifier.getProbability(0) > classifier.getProbability(2)) {
            glitchType = GRAY;
        }
        
        else {
            glitchType = JPEG;
        }
    }
    
    else {
        glitchType = NONE;
    }
}




 





    
    
   
    
   
