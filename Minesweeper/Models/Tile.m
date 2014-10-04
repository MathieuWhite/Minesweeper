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
        [self setIsMine: NO];
        [self setIsRevealed: NO];
        [self setIsFlagged: NO];
        [self setAdjacentMines: 0];
    }
    
    return self;
}

@end