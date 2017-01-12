//
//  flower.cpp
//  caae
//
//  Created by 刘志健 on 17/1/7.
//
//

#include "flower.hpp"

void flower::setup(){
    
    float time = random(1000);
    float timeVal = random(0.001, 0.5);
    anchor = new Anchor[num];
    anchor[] angles = new float[num];
    
    for(int i = 0; i < num; i++){
        
        angles[i] = random(360);
    
    }
    
    arrayCopy(sort(angles), angles);
    
    float val = map(mouseX, 0, width, 2, 60);
    if(mouseX <= 0 ||mouseX >width) val =14;
    float minlength = d * 10, maxLength = 0;
    float[] length = new float[num];
    
    for (int i = 0; i < length.length; i++){
        
        length[i] = mode ==0 ? noise(time) * (float)d : d;
        if (length[i] < minLength) minLength = length[i];
        if (length[i] > maxLength) maxLength = length[i];
        
        time += timeVal;
    
    }
    
    if (minLength != maxLength){
    
        for (int i = 0; i < length.length; i++){
            
            length[i] = map(length[i], minLength, maxLength, minLength, d);
        
        }
    }
    
    for (int i = 0; i < num; i++){
        
        anchor[i] = new Anchor(angles[i], -val, val, length[i], centerX, centerY, minNext);
    
    }

}

void flower::update(){
    

}

void flower::draw(){

}

void flower::createAnchor(float angleIn, float minAngleIn, float maxAngleIn, float lengthIn, int centerIn, float minNextIn){
    
    for (int i = 0; i < 25; i++){
        
        if (flength > 1.5){
            
            int dir = (int)ofRandom(0, 3);
            
            if (dir <= 1){
                
                float nextflength = flength * ofRandom(0.75, 1.20);
                if (totalLength + nextflength < lengthIn) createBranches(fAngle + ofRandom(minAngleIn * 2, maxAngleIn * 2), branches[branches.size()].points[branches[branches.size()].points.size() - 1], totalLength, nextflength, i, minNextIn);
            
            }
            
            else
                
            {
                float nextflength = flength * ofRandom(minNextIn, 1.05);
                if (totalLength + nextflength < lengthIn) createBranches(fAngle + ofRandom(minAngle / 2, 0), branches[branches.size()].points[branches[branches.size()].points.size() - 1], totalLength, nextflength, i, minNextIn);
                nextflength = flength * ofRandom(minNextIn, 1.05);
                if (totalLength + nextflength < lengthIn) createBranches(fAngle + ofRandom(0, maxAngle / 2), branches[branches.size()].points[branches[branches.size()].points.size() - 1], totalLength, nextflength, i, minNextIn);
            }

        
        }
    
    }

}

void flower::createBranches(float fAngle, ofVec2f start, float minNext,float minAngleIn ,float maxAngleIn){
    
    float mangle = ofRandom(- minAngleIn / 2, maxAngleIn / 2);
    float weighing = ofRandom(0.25, 0.75);
    
    Branch tBranch;
    tBranch.points.assign(5, ofVec2f(0, 0));
    if (flength>80) tBranch.points.assign(6, ofVec2f(0, 0));
    
    tBranch.points[0] = tBranch.points[1] = start;

    tBranch.points[tBranch.points.size() - 2] = tBranch.points[tBranch.points.size() - 1] = start + ofVec2f(cos(ofDegToRad(fAngle)) * flength, sin(ofDegToRad(fAngle)) * flength);
    
    
    if (flength <= 80){

        tBranch.points[2] = ofVec2f(start.x + cos(ofDegToRad(fAngle + mangle)) * ofDist(start.x, start.y, tBranch.points[tBranch.points.size() - 1].x * weighing,tBranch.points[tBranch.points.size() - 1].y * weighing), start.y + cos(ofDegToRad(fAngle + mangle)) * ofDist(start.x, start.y, tBranch.points[tBranch.points.size() - 1].x * weighing,tBranch.points[tBranch.points.size() - 1].y * weighing));
    }
    else {
        weighing = ofRandom(0.25, 0.5);
        tBranch.points[2] = ofVec2f(start.x + cos(ofDegToRad(fAngle + mangle)) * ofDist(start.x, start.y, tBranch.points[tBranch.points.size() - 1].x * weighing, tBranch.points[tBranch.points.size() - 1].y * weighing), start.y + cos(ofDegToRad(fAngle + mangle)) * ofDist(start.x, start.y, tBranch.points[tBranch.points.size() - 1].x * weighing, tBranch.points[tBranch.points.size() - 1].y * weighing));
        
        mangle = ofRandom(- minAngleIn / 2, maxAngleIn / 2);
        weighing = ofRandom(0.5, 0.75);
        tBranch.points[3] = ofVec2f(start.x + cos(ofDegToRad(fAngle + mangle)) * ofDist(start.x, start.y, tBranch.points[tBranch.points.size() - 1].x * weighing, tBranch.points[tBranch.points.size() - 1].y * weighing), start.y + cos(ofDegToRad(fAngle + mangle)) * ofDist(start.x, start.y, tBranch.points[tBranch.points.size() - 1].x * weighing, tBranch.points[tBranch.points.size() - 1].y * weighing));
    }
    
    
    branches.push_back(tBranch);
    
    totalLength += flength;

}
