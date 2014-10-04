//
//  MinefieldView.m
//  Minesweeper
//
//  Created by Mathieu White on 2014-10-04.
//  Copyright (c) 2014 Mathieu White. All rights reserved.
//

#import "MinefieldView.h"
#import "Minefield.h"

@interface MinefieldView()

@property (nonatomic, strong) Minefield *minefield;

@end

@implementation MinefieldView

- (instancetype) initWithDifficulty: (NSString *) difficulty
{
    self = [super init];
    
    if (self)
    {
        if ([difficulty isEqualToString: @"easy"])
        {
            Minefield *minefield = [[Minefield alloc] initWithMines: 10 rows: 9 columns: 9];
            [self setMinefield: minefield];
            [self initMinefieldView];
        }
        else if ([difficulty isEqualToString: @"medium"])
        {
            Minefield *minefield = [[Minefield alloc] initWithMines: 16 rows: 13 columns: 13];
            [self setMinefield: minefield];
            [self initMinefieldView];
        }
        else
        {
            //Minefield *minefield = [[Minefield alloc] initWithMines: 40 rows: 17 columns: 17];
            Minefield *minefield = [[Minefield alloc] initWithMines: 50 rows: 25 columns: 25];
            [self setMinefield: minefield];
            [self initMinefieldView];
        }
    }
    
    return self;
}

- (void) initMinefieldView
{
    NSLog(@"Rows: %lu", [self.minefield.tiles count]);
    NSLog(@"Columns: %lu", [[self.minefield.tiles objectAtIndex: 0] count]);
    NSLog(@"Tiles: %lu", [self.minefield rows] * [self.minefield columns]);
    NSLog(@"Mines: %lu", [self.minefield mines]);
    NSLog(@"Safe: %lu", [self.minefield safeTiles]);
    NSLog(@"Revealed: %lu", [self.minefield revealedTiles]);
    
    for (NSUInteger rowIndex = 0; rowIndex < [self.minefield rows]; rowIndex++)
    {
        for (NSUInteger columnIndex = 0; columnIndex < [self.minefield columns]; columnIndex++)
        {
            NSLog(@"(%lu, %lu): %lu", rowIndex, columnIndex, [[self.minefield tileAtRow: rowIndex column: columnIndex] adjacentMines]);
        }
    }
    
    
    
}

@end
