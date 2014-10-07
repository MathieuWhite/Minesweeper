//
//  Tile.m
//  Minesweeper
//
//  Created by Mathieu White on 2014-10-02.
//  Copyright (c) 2014 Mathieu White. All rights reserved.
//

#import "Tile.h"

@implementation Tile

- (id) init
{
    self = [super init];
    
    if (self)
    {
        [self setMine: NO];
        [self setRevealed: NO];
        [self setFlagged: NO];
        [self setAdjacentMines: 0];
    }
    
    return self;
}

@end