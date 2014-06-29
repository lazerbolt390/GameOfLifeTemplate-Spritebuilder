//
//  Grid.m
//  GameOfLife
//
//  Created by Manish R on 6/28/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Grid.h"
#import "Creature.h"

// these are variables that cannot be changed
static const int GRID_ROWS = 8;
static const int GRID_COLUMNS = 10;

@implementation Grid {
    NSMutableArray *_gridArray;
    float _cellWidth;
    float _cellHeight;
}
- (void)onEnter
{
    [super onEnter];
    
    [self setupGrid];
    
    self.userInteractionEnabled = YES;
}


@end
