#include "ofApp.h"

//--------------------------------------------------------------
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

//--------------------------------------------------------------
void ofApp::update(){

}

//--------------------------------------------------------------
void ofApp::draw(){

}

//--------------------------------------------------------------
void ofApp::keyPressed(int key){

}

//--------------------------------------------------------------
void ofApp::keyReleased(int key){

}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y ){

}

//--------------------------------------------------------------
void ofApp::mouseDragged(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mouseReleased(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mouseEntered(int x, int y){

}

//--------------------------------------------------------------
void ofApp::mouseExited(int x, int y){

}

//--------------------------------------------------------------
void ofApp::windowResized(int w, int h){

}

//--------------------------------------------------------------
void ofApp::gotMessage(ofMessage msg){

}

//--------------------------------------------------------------
void ofApp::dragEvent(ofDragInfo dragInfo){ 

}
