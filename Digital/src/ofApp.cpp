#include "ofApp.h"

void ofApp::setup(){
    
    ofBackground(0);
    ofSetloglevel("ofxCsv", OF_LOG_VERBOSE);
    ofSetCircleResolution(3);
    
    if(csv.load("airports-extended.dat")){
        
        for(int i = 0; i < csv.getNumRows(); i++){
            for(int j = 0; j < csv.getNumCols(i); j++){
            
            }
        
        }
    
    }
    

}


void ofApp::update(){

}

void ofApp::draw(){
    
    ofVec2f airportLoc;
    
    ofPushmatrix();
    ofTranslate(ofGetWidth()/2, ofGetHeigh()/2);
    
    for(int i = 0; i < csv.getNumRows(); i++){
        
        ofxCsvRow row = csv[i];
        string type = row.getString(12);
        if(type == "airport"){
            ofSetColor(31, 127, 255);
        }else if(type == "station"){
            color = ofFloatColor(1.0, 0.5, 0.2);
        }else if(type == "port"){
            color = ofFloatColor(0.5, 1.0, 0.2);
        } 
    
    }
}



}





