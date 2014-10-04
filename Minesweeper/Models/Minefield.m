//
//  Minefield.m
//  Minesweeper
//
//  Created by Mathieu White on 2014-10-03.
//  Copyright (c) 2014 Mathieu White. All rights reserved.
//

#import "Minefield.h"

@implementation Minefield

- (id) initWithMines: (NSUInteger) mines rows: (NSUInteger) rows columns: (NSUInteger) columns
{
    self = [super init];
    
    if (self)
    {
        self.tiles = [[NSMutableArray alloc] initWithCapacity: rows];
        
        for (NSUInteger rowIndex = 0; rowIndex < rows; rowIndex++)
        {
            NSMutableArray *row = [[NSMutableArray alloc] initWithCapacity: columns];
            [self.tiles addObject: row];
            
            for (NSUInteger columnIndex = 0; columnIndex < columns; columnIndex++)
            {
                [row addObject: [[Tile alloc] init]];
            }
        }
        [self setMines: mines];
        [self resetMinefield];
    }
    
    return self;
}

// Method that returns the number of row in the minefield
- (NSUInteger) rows
{
    return [self.tiles count];
}

// Method that returns the number of columns in the minefield
- (NSUInteger) columns
{
    return [[self.tiles objectAtIndex: 0] count];
}

// Method used to count adjacent mines
- (Tile *) tileAtRow: (NSUInteger) row column: (NSUInteger) column
{
    return [[self.tiles objectAtIndex: row] objectAtIndex: column];
}

// Method to reset the minefield
- (void) resetMinefield
{
    [self setRevealedTiles: 0]; // Number of revealed tiles
    [self setDidHitMine: NO];
    
    // Reset all the tiles
    for (NSUInteger rowIndex = 0; rowIndex < [self rows]; rowIndex++)
    {
        for (NSUInteger columnIndex = 0; columnIndex < [self columns]; columnIndex++)
        {
            Tile *tile = [self tileAtRow: rowIndex column: columnIndex];
            [tile setIsRevealed: NO];
            [tile setIsFlagged: NO];
            [tile setIsMine: NO];
        }
    }
    
    // Set the mines in random tiles
    for (NSUInteger index = 0; index < [self mines]; index++)
    {
        NSUInteger randomRow = arc4random() % [self rows];
        NSUInteger randomColumn = arc4random() % [self columns];
        [[self tileAtRow: randomRow column: randomColumn] setIsMine: YES];
    }
    
    // Count adjacent mines for the tiles
    for (NSUInteger rowIndex = 0; rowIndex < [self rows]; rowIndex++)
    {
        for (NSUInteger columnIndex = 0; columnIndex < [self columns]; columnIndex++)
        {
            NSUInteger adjacentMines = 0;
        
            Tile *tile = [self tileAtRow: rowIndex column: columnIndex];
            
            // Checks adjacent tiles
            for (NSInteger row = -1; row <= 1; row++)
            {
                for (NSInteger column = -1; column <= 1; column++)
                {
                    if (column == 0 && row == 0) continue;
                    
                    NSInteger adjacentRow = rowIndex + row;
                    NSInteger adjacentColumn = columnIndex + column;
                    
                    if (adjacentRow < 0 || adjacentRow >= [self rows] ||
                        adjacentColumn < 0 || adjacentColumn >= [self columns]) continue;
                    
                    Tile *adjacentTile = [self tileAtRow: adjacentRow column: adjacentColumn];
                    
                    if ([adjacentTile isMine]) adjacentMines++;
                }
            }
            [tile setAdjacentMines: adjacentMines];
        }
    }
}

// Method that returns the number of unmined hidden tiles in the minefield
- (NSUInteger) safeTiles
{
    return [self rows] * [self columns] - [self mines] - [self revealedTiles];
}

// Returns the value of the tile (from -2 to 8)
- (NSInteger) revealTileAtRow: (NSUInteger) row column: (NSUInteger) column
{
    if ([self didHitMine]) return -2; // Mine was already hit
    
    Tile *tile = [self tileAtRow: row column: column];
    if ([tile isRevealed]) return -2; // Tile was already revealed
    
    [tile setIsRevealed: YES];
    self.revealedTiles++;
    
    if ([tile isMine])
    {
        [self setDidHitMine: YES];
        return -1;
    }
    
    NSUInteger adjacentMines = [tile adjacentMines];
    
    if (adjacentMines == 0)
    {
        BOOL hasChanged;
        
        do
        {
            hasChanged = NO;
            for (NSUInteger rowIndex = 0; rowIndex < [self rows]; rowIndex++)
            {
                for (NSUInteger columnIndex = 0; columnIndex < [self columns]; columnIndex++)
                {
                    if ([self autoRevealTileAtRow: rowIndex column: columnIndex])
                        hasChanged = YES;
                }
            }
        } while (hasChanged);
    }
    
    return adjacentMines;
}

// Method to reveal adjacent cells that don't have adjacent mines
- (BOOL) autoRevealTileAtRow: (NSUInteger) row column: (NSUInteger) column
{
    Tile *tile = [self tileAtRow: row column: column];
    
    // Check if the tile is hidden and if it doesn't contain a mine
    if (![tile isRevealed] && ![tile isMine])
    {
        // Check the adjacent tiles
        for (NSInteger rowIndex = -1; rowIndex <= 1; rowIndex++)
        {
            for (NSInteger columnIndex = -1; columnIndex <= 1; columnIndex++)
            {
                if (rowIndex == 0 && columnIndex == 0) continue;
                
                NSInteger adjacentRow = rowIndex + row;
                NSInteger adjacentColumn = columnIndex + column;
                
                if (adjacentRow < 0 || adjacentRow >= [self rows] ||
                    adjacentColumn < 0 || adjacentColumn >= [self columns]) continue;
                
                Tile *adjacentTile = [self tileAtRow: adjacentRow column: adjacentColumn];
                
                if ([adjacentTile isRevealed] && adjacentTile.adjacentMines == 0)
                {
                    [tile setIsRevealed: YES];
                    self.revealedTiles++;
                    return YES;
                }
            }
        }
    }
    
    return NO;
}


@end
