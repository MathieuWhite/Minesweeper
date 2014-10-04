//
//  MinefieldView.m
//  Minesweeper
//
//  Created by Mathieu White on 2014-10-04.
//  Copyright (c) 2014 Mathieu White. All rights reserved.
//

#import "MinefieldView.h"
#import "Minefield.h"
#import "TileView.h"

@interface MinefieldView()

@property (nonatomic, strong) Minefield *minefield;
@property (nonatomic, strong) NSMutableArray *tileViews;

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
            NSLog(@"(%lu, %lu): %lu", rowIndex, columnIndex, [self.minefield revealTileAtRow: rowIndex column: columnIndex]);
        }
    }
    
    // Set the background color
    [self setBackgroundColor: [UIColor colorWithRed: 46.0f/255.0f green: 46.0f/255.0f blue: 59.0f/255.0f alpha: 1.0f]];
    
    // The MinefiledView frame will be the amount of tiles times their width
    [self setFrame: CGRectMake(0, 0, [self.minefield columns] * 64, [self.minefield rows] * 64)];
    
    // Initialize the array that will store the TileViews
    NSMutableArray *tileViews = [[NSMutableArray alloc] initWithCapacity: [self.minefield rows]];
    
    // Initialize the TileViews and store them in the array
    for (NSUInteger rowIndex = 0; rowIndex < [self.minefield rows]; rowIndex++)
    {
        NSMutableArray *row = [[NSMutableArray alloc] initWithCapacity: [self.minefield columns]];
        [self.tileViews addObject: row];
        
        for (NSUInteger columnIndex = 0; columnIndex < [self.minefield columns]; columnIndex++)
        {
            CGFloat offsetX = (columnIndex * 64);
            CGFloat offsetY = (rowIndex * 64);
            
            TileView *tileView = [[TileView alloc] initWithFrame: CGRectMake(offsetX, offsetY, 64, 64)];
            
            if ((columnIndex + rowIndex) % 2 == 0)
                [tileView setDarkerTone: YES];
            else [tileView setDarkerTone: NO];
            
            [tileView setAdjacentCells: [self.minefield revealTileAtRow: rowIndex column: columnIndex]];
            
            [row addObject: tileView];
            [self addSubview: tileView];
        }
    }
    
    // Set each component to a property
    [self setTileViews: tileViews];
}

@end
