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

void ofApp::updateGlitch(){
    
    glichCount = max(0, glitchCount -1);
    
    if(glitchType == JPEG){
        if(imageIndex == 0){
            imageIndex = ofRandom(1, images.size());
            glitchCount = 10;
        
        }
        if(!jpeg.getImage().isAllocated() || ofGetFrameNum() % 5 == 0){
            jpeg.setPixels(images.at(imageIndex - 1).getPixels());
            jpeg.glitch();
        }
    }
    else{
        imageIndex = 0;
    }

}

void ofApp::exit(){

    tracker.waiForThread();
}

void ofApp::draw(){

    ofBackground(0);
    ofSetColor(255, 255);

    shader.begin();
    ofBaseDraws *ofBaseDraw;

    switch(glitchType){
        case GRAY:

            ofBaseDraw = &grabber;
            shader.setUniformTexture("tex0", grabber.getTexture(), 0);
            shader.setUniform1f("doGray", 1);
            bgreak;

        case JPEG:

             baseDraw = &(jpeg.getImage());
             shader.setUniformTexture("tex0", jepg.getImage().getTexture(), 0);
             shader.setUniform1f("doGray", 0);
             break;

        case NONE:
        default:

             baseDraw = &grabber;
             shader.setUniformTexture("tex0", grabber.getTexture(), 0);
             shader.setUniform1f("doGary", 0);
             break;

    }

    shader.setUniform2f("imageViewPort", baseDraw->getWidth(), baseDraw->getHeight());
    shader.setUniform2f("screenViewPort", ofGetWidth(), ofGetHeight());

    ofDrawRectangle(0, 0, ofGetWidth(), ofGetHeight());

    shader.end();

    gui.draw();
    drawClassifier();

}

void ofApp::drawClassifier() {
    
    int w = 100, h = 12;
    
    ofPushStyle();
    ofPushMatrix();
    ofTranslate(5, 100);
    
    int n = classifier.size();
    
    
    
    ofPopMatrix();
    ofPopStyle();
    
}






 





    
    
   
    
   
