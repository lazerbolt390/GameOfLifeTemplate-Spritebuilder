#import "Grid.h"
#import "Creature.h"

// these are constant or final variables (cannot be changed)
static const int GRID_ROWS = 8;
static const int GRID_COLUMNS = 10;

@implementation Grid {
    
    NSMutableArray *_gridArray;
    float _cellWidth;
    float _cellHeight;
    
}


-(void)onEnter{
    [super onEnter];
    
    [self setupGrid];
    
    //accepts touches on the grid
    self.userInteractionEnabled = YES;
    
}

- (void)setupGrid{
    //divide the grid's size by the number of columns/rows
    //to deterimine the right width and height of each cell
    
    _cellWidth = self.contentSize.width / GRID_COLUMNS;
    _cellHeight = self.contentSize.height/GRID_ROWS;
    
    float x = 0;
    float y = 0;
    
    //initialize the array as a blank NSMutableArray here
    _gridArray = [NSMutableArray array];
    
    //initialize the creatures
    for (int i = 0; i < GRID_ROWS; i++){
        //this is how you create two dimensional arrays in objective-c. You place arrays into arrays.
        _gridArray[i] = [NSMutableArray array];
        x = 0;
        
        for (int j = 0; j < GRID_COLUMNS; j++) {
            Creature *creature = [[Creature alloc ] initCreature];
            creature.anchorPoint = ccp(0,0);
            creature.position = ccp(x,y);
            [self addChild:creature];
            
            //this is shorthand to access an array inside an array
            _gridArray[i][j] = creature;
            
            //make creatures visible to test this method, remove this once we know we have filled the grid
            //properly
            //  creature.isAlive = YES;
            
            x+= _cellWidth;
        }
        
        y+=_cellHeight;
    }
}

-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    
    //get the x and y coordinates of the touch points
    CGPoint touchLocation = [touch locationInNode:self];
    
    //get the Creature at that location
    Creature *creature = [self creatureForTouchPosition:touchLocation];
    
    //invert it's state - kill it if it's alive, bring it to life if its dead already
    creature.isAlive = !creature.isAlive;
    
}

- (Creature *)creatureForTouchPosition:(CGPoint)touchPosition
{
    //get the row and column that was touched, return the Creature
    
    int row =  touchPosition.y/_cellHeight;
    int column = touchPosition.x/_cellWidth;
    
    
    return _gridArray[row][column];
}

-(void)evolveStep
{
    //count neightbors
    [self countNeighbors];
    
    //update each Creature's state
    [self updateCreatures];
    
    //update the generation so the label's text will display the correct generation
    _generation++;
    
}



-(void) countNeighbors{
    // iterate through the rows
    // note that NSArray has a method 'count' that will return the number of elements in the array
    for (int i = 0; i < [_gridArray count]; i++)
    {
        // iterate through all the columns for a given row
        for (int j = 0; j < [_gridArray[i] count]; j++)
        {
            // access the creature in the cell that corresponds to the current row/column
            Creature *currentCreature = _gridArray[i][j];
            
            // remember that every creature has a 'livingNeighbors' property that we created earlier
            currentCreature.livingNeighbors = 0;
            
            // now examine every cell around the current one
            
            // go through the row on top of the current cell, the row the cell is in, and the row past the current cell
            for (int x = (i-1); x <= (i+1); x++)
            {
                // go through the column to the left of the current cell, the column the cell is in, and the column to the right of the current cell
                for (int y = (j-1); y <= (j+1); y++)
                {
                    // check that the cell we're checking isn't off the screen
                    BOOL isIndexValid;
                    isIndexValid = [self isIndexValidForX:x andY:y];
                    
                    // skip over all cells that are off screen AND the cell that contains the creature we are currently updating
                    if (!((x == i) && (y == j)) && isIndexValid)
                    {
                        Creature *neighbor = _gridArray[x][y];
                        if (neighbor.isAlive)
                        {
                            currentCreature.livingNeighbors += 1;
                        }
                    }
                    
                }
            }
        }
        
    }
    
}


- (BOOL)isIndexValidForX:(int)x andY:(int)y
{
    BOOL isIndexValid = YES;
    if(x < 0 || y < 0 || x >= GRID_ROWS || y >= GRID_COLUMNS)
    {
        isIndexValid = NO;
    }
    return isIndexValid;
}

-(void)updateCreatures{
    
    //initialize numbAlive to 0
    int numbAlive = 0;
    // iterate through the rows
    // 'count' will return the number of elements in the array
    for (int i = 0;  i<[_gridArray count]; i++) {
        // iterate through all the columns for a given row
        for (int j = 0; j< [ _gridArray[i] count ]; j++) {
            // access the creature in the cell that corresponds to the current row [i]/[j]column
            Creature *currentCreature = _gridArray[i][j];
            //if current creature has neighbors equal to 3 then the current creature can stay alive.
            if (currentCreature.livingNeighbors == 3)
            {
                //if the aboe is true then set current creature isAlive to True.
                currentCreature.isAlive = YES;
            }
            //else if the above is false then test if the current creature's neighbors are less than
            //or equal to 1 OR the current creature's neighbor is greater than or equal to 4 lives.
            else if (currentCreature.livingNeighbors <= 1 || currentCreature.livingNeighbors >= 4)
            {
                //if the above condition is true than the current creatuer cannot be alive
                //it's over population, set current creature isAlive to False.
                currentCreature.isAlive = NO;
            }
            //lastly after all that if else if above
            // if currentCreature is Alive then increment the number alive by 1
            if (currentCreature.isAlive) {
                
                numbAlive++;
                
            }
            
        }
    }
    
    //update the totalAlive so the label's text will display the correct population
    //add the total numbAlive after every iteration to _totalAlive to keep score
    _totalAlive = numbAlive;
}


@end
