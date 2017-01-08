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

}

#endif /* flower_hpp */
