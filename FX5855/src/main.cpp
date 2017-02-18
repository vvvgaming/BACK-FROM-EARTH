#include "ofMain.h"
#include "ofApp.h"

int main( ){
    //	ofSetupOpenGL(1024,768,OF_WINDOW);			// <-------- setup the GL context
    
    // 720p
    ofSetupOpenGL(960,720,OF_WINDOW);
    
    // this kicks off the running of my app

    ofRunApp(new ofApp());
    
}
