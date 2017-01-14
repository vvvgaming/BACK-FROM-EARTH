//
//  flower.hpp
//  caae
//
//  Created by 刘志健 on 17/1/7.
//
//

#ifndef flower_hpp
#define flower_hpp

#include "ofMain.h"

struct Branch{
    
vector<ofVec3f>points;
    
    

};

class flower{
    
public:
    
    flower(){};
    ~flower(){};
    void setup();
    void update();
    void draw();
    
    void createAnchor(float angleIn, float minAngleIn, float maxAngleIn, float lengthIn,ofVec2f centerIn, float minNextIn);
    void createBranches(float fAngle, ofVec2f start, float minNext,float minAngleIn ,float maxAngleIn);
    vector<Branch>branches;
    
    
    float totalLength;
    float flength;

};

#endif /* flower_hpp */
