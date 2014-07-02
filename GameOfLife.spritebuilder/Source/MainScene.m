#import "MainScene.h"
#import "Grid.h"

@implementation MainScene {
    Grid *_grid;
    CCTimer *_timer;
    CCLabelTTF *_generationLabel;
    CCLabelTTF *_populationLabel;
    
}

- (id)init
{
    self = [super init];
    if (self) {
        
        _timer = [[CCTimer alloc] init];
    }
    
    return self;
    
}

-(void)play
{
    //this tells the game to call a method called 'step every' half a second.
    [self schedule:@selector(step) interval:0.5f];
    
}

-(void)pause
{
    [self unschedule:@selector(step)];
}

// this method will get called every half of a second when you hit the pause button
-(void)step
{
    [_grid evolveStep];
    _generationLabel.string = [NSString stringWithFormat:@"%d", _grid.generation];
    _populationLabel.string = [NSString stringWithFormat:@"%d", _grid.totalAlive];
    
}


@end
