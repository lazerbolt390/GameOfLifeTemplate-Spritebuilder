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
@end