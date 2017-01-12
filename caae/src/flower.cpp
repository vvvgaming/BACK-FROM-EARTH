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


