#include "flower.h"

//--------------------------------------------------------------
void flower::setup(){

    float time = random(1000);
    float timeVal = random(0.001, 0.5);
    anchor = new Anchor[num];
    float[] angles = new float[num];
    
    for (int i = 0; i < num; i++)
    {
        angles[i] = random(360);
    }
    
    arrayCopy(sort(angles), angles);
    
    float val = map(mouseX, 0, width, 2, 60);
    if (mouseX <= 0 || mouseX > width) val = 14;
    float minLength = d * 10, maxLength = 0;
    float[] length = new float[num];
    
    for (int i = 0; i < length.length; i++)
    {
        length[i] = mode == 0 ? noise(time) * (float)d : d;
        if (length[i] < minLength) minLength = length[i];
        if (length[i] > maxLength) maxLength = length[i];
        
        time += timeVal;
    }
    
    if (minLength != maxLength)
    {
        for (int i = 0; i < length.length; i++)
        {
            length[i] = map(length[i], minLength, maxLength, minLength, d);
        }
    }
    
    for (int i = 0; i < num; i++)
    {
        
        anchor[i] = new Anchor(angles[i], -val, val, length[i], centerX, centerY, minNext);
    }

    
}

//--------------------------------------------------------------
void flower::update(){

}

//--------------------------------------------------------------
void flower::draw(){

}

//--------------------------------------------------------------
void flower::createAnchor(float angleIn, float minAngleIn, float maxAngleIn, float lengthIn,ofVec2f centerIn, float minNextIn){
    
    
    //----- recursion whilecount < 25 &&count++;
    for(int i=0;i<25;i++){
        if (flength > 1.5)
        {
            
            int dir = (int)ofRandom(0, 3);
            
            //----- on or two anchors
            if (dir <= 1)
            {
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

//--------------------------------------------------------------
void flower::createBranches(float fAngle, ofVec2f start, float minNext,float minAngleIn ,float maxAngleIn){

    float mangle = ofRandom(- minAngleIn / 2, maxAngleIn / 2);
    float weighing = ofRandom(0.25, 0.75);
    
    
    //----- start and end points to be drawn plus an in-between point
    //float[][] points = new float[5][2];
    Branch tBranch;
    tBranch.points.assign(5, ofVec2f(0, 0));
    if (flength>80) tBranch.points.assign(6, ofVec2f(0, 0)); //points = new float[6][2];
    //points[0][0] = points[1][0] = startX;                                                                                                                  // startpunkt x
    //points[0][1] = points[1][1] = startY;
    tBranch.points[0] = tBranch.points[1] = start;
    
    // startpunkt y
    //points[points.length - 2][0] = points[points.length - 1][0] = startX + cos(radians(fAngle)) * flength;                                                   // endpunkt x
    //points[points.length - 2][1] = points[points.length - 1][1] = startY + sin(radians(fAngle)) * flength;
    
    tBranch.points[tBranch.points.size() - 2] = tBranch.points[tBranch.points.size() - 1] = start + ofVec2f(cos(ofDegToRad(fAngle)) * flength, sin(ofDegToRad(fAngle)) * flength);
    // endpunkt y
    if (flength <= 80)
    {
        //points[2][0] = startX + cos(radians(fAngle + mangle)) * dist(startX, startY, points[points.length - 1][0], points[points.length - 1][1]) * weighing;  // kontrollpunkt x
        //points[2][1] = startY + sin(radians(fAngle + mangle)) * dist(startX, startY, points[points.length - 1][0], points[points.length - 1][1]) * weighing;  // kontrolltpunkt y
        tBranch.points[2] = ofVec2f(start.x + cos(ofDegToRad(fAngle + mangle)) * ofDist(start.x, start.y, tBranch.points[tBranch.points.size() - 1].x * weighing,tBranch.points[tBranch.points.size() - 1].y * weighing), start.y + cos(ofDegToRad(fAngle + mangle)) * ofDist(start.x, start.y, tBranch.points[tBranch.points.size() - 1].x * weighing,tBranch.points[tBranch.points.size() - 1].y * weighing));
    }
    else {
        weighing = ofRandom(0.25, 0.5);
        tBranch.points[2] = ofVec2f(start.x + cos(ofDegToRad(fAngle + mangle)) * ofDist(start.x, start.y, tBranch.points[tBranch.points.size() - 1].x * weighing, tBranch.points[tBranch.points.size() - 1].y * weighing), start.y + cos(ofDegToRad(fAngle + mangle)) * ofDist(start.x, start.y, tBranch.points[tBranch.points.size() - 1].x * weighing, tBranch.points[tBranch.points.size() - 1].y * weighing));
        
        //points[2][0] = startX + cos(radians(fAngle + mangle)) * dist(startX, startY, points[points.length - 1][0], points[points.length - 1][1]) * weighing;  // kontrollpunkt x
        //points[2][1] = startY + sin(radians(fAngle + mangle)) * dist(startX, startY, points[points.length - 1][0], points[points.length - 1][1]) * weighing;  // kontrolltpunkt y
        mangle = ofRandom(- minAngleIn / 2, maxAngleIn / 2);
        weighing = ofRandom(0.5, 0.75);
        tBranch.points[3] = ofVec2f(start.x + cos(ofDegToRad(fAngle + mangle)) * ofDist(start.x, start.y, tBranch.points[tBranch.points.size() - 1].x * weighing, tBranch.points[tBranch.points.size() - 1].y * weighing), start.y + cos(ofDegToRad(fAngle + mangle)) * ofDist(start.x, start.y, tBranch.points[tBranch.points.size() - 1].x * weighing, tBranch.points[tBranch.points.size() - 1].y * weighing));
        
        //points[3][0] = startX + cos(radians(fAngle + mangle)) * dist(startX, startY, points[points.length - 1][0], points[points.length - 1][1]) * weighing;  // kontrollpunkt x
        //points[3][1] = startY + sin(radians(fAngle + mangle)) * dist(startX, startY, points[points.length - 1][0], points[points.length - 1][1]) * weighing;  // kontrolltpunkt y
    }
    
    //----- add new branch
    //branches.add(new Branch(points));
    //tBranch.update
    branches.push_back(tBranch);


    //----- calculte current branch length
    totalLength += flength;

}
