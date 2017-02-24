#include "ofApp.h"




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


}




 





    
    
   
    
   
