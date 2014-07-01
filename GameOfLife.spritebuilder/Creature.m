//
//  Creature.m
//  GameOfLife
//
//  Created by Manish R on 6/28/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Creature.h"

@implementation Creature
- (instancetype)initCreature {
    // since we made Creature inherit from CCSprite, 'super' below refers to CCSprite
    self = [super initWithImageNamed:@"GameOfLifeAssets/Assets/bubble.png"];
    
    if (self) {
        self.isAlive = NO;
    }
    
    return self;
}

//when you create a @property as in the .h, an instance
//with leading underscore is automatically created for us

-(void)setIsAlive:(BOOL)newState {
    
    _isAlive = newState;
    
    // 'visible' is  a property of any class that inherits from CCNode
    //and Creature is a subclass of CCSprite, so Creatures have a visible property
    
    self.visible = _isAlive;
    
}
@end