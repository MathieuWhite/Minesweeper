//
//  MinefieldView.m
//  Minesweeper
//
//  Created by Mathieu White on 2014-10-04.
//  Copyright (c) 2014 Mathieu White. All rights reserved.
//

#import "MinefieldView.h"
#import "Minefield.h"

@interface MinefieldView() <TileViewDelegate>

@property (nonatomic, strong) Minefield *minefield;
@property (nonatomic, strong) NSMutableArray *minedTileViews;
@property (nonatomic, strong) NSMutableArray *flaggedTileViews;

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
    NSLog(@"Rows: %lu", (unsigned long)[self.minefield.tiles count]);
    NSLog(@"Columns: %lu", (unsigned long)[[self.minefield.tiles objectAtIndex: 0] count]);
    NSLog(@"Tiles: %lu", (unsigned long) ([self.minefield rows] * [self.minefield columns]));
    NSLog(@"Mines: %lu", (unsigned long)[self.minefield mines]);
    NSLog(@"Safe: %lu", (unsigned long)[self.minefield safeTiles]);
    NSLog(@"Revealed: %lu", (unsigned long)[self.minefield revealedTiles]);
    
    // Set the background color
    [self setBackgroundColor: [UIColor colorWithRed: 46.0f/255.0f green: 46.0f/255.0f blue: 59.0f/255.0f alpha: 1.0f]];
    
    // The MinefiledView frame will be the amount of tiles times their width
    [self setFrame: CGRectMake(0, 0, [self.minefield columns] * 64, [self.minefield rows] * 64)];
    
    // Initialize the array that will store the TileViews
    NSMutableArray *tileViews = [[NSMutableArray alloc] initWithCapacity: [self.minefield rows]];
    
    // Initialize the array that will store the TileViews with mines
    NSMutableArray *minedTileViews = [[NSMutableArray alloc] initWithCapacity: [self.minefield mines]];
    
    // Initialize the array that will store the TileViews with flags
    NSMutableArray *flaggedTileViews = [[NSMutableArray alloc] initWithCapacity: [self.minefield rows] * [self.minefield columns]];
    
    // Set each component to a property
    [self setTileViews: tileViews];
    [self setMinedTileViews: minedTileViews];
    [self setFlaggedTileViews: flaggedTileViews];
    
    // Initialize the TileViews and store them in the array
    [self initTileViews];
    
}

- (void) initTileViews
{
    // Places the tile views on the minefield
    for (NSUInteger rowIndex = 0; rowIndex < [self.minefield rows]; rowIndex++)
    {
        NSMutableArray *row = [[NSMutableArray alloc] initWithCapacity: [self.minefield columns]];
        [self.tileViews addObject: row];
        
        for (NSUInteger columnIndex = 0; columnIndex < [self.minefield columns]; columnIndex++)
        {
            CGFloat offsetX = (columnIndex * 64);
            CGFloat offsetY = (rowIndex * 64);
            
            TileView *tileView = [[TileView alloc] initWithFrame: CGRectMake(offsetX, offsetY, 64, 64)];
            [tileView setDelegate: self];
            [tileView setRowIndex: rowIndex];
            [tileView setColumnIndex: columnIndex];
            
            if ((columnIndex + rowIndex) % 2 == 0)
                [tileView setDarkerTone: YES];
            else [tileView setDarkerTone: NO];
            
            [tileView setAdjacentMines: [self.minefield revealTileAtRow: rowIndex column: columnIndex]];
            if ([tileView adjacentMines] == -1)
            {
                [tileView setMine: YES];
                [self.minedTileViews addObject: tileView];
            }
            
            [row addObject: tileView];
            
            [self addSubview: tileView];
        }
    }
}

// Returns the TileView at row column
- (TileView *) tileViewAtRow: (NSInteger) row column: (NSInteger) column
{
    return [[self.tileViews objectAtIndex: row] objectAtIndex: column];
}

#pragma mark - TileViewDelegate Methods

- (void) revealedTileIsMine: (TileView *) tileView
{
    NSLog(@"User hit a mine!");
    for (TileView *minedTileView in [self minedTileViews])
        [minedTileView revealTileViewMineAfterMineHit];
    
    for (TileView *flaggedTileView in [self flaggedTileViews])
        [flaggedTileView revealTileViewMineAfterMineHit];
    
    [self setUserInteractionEnabled: NO];
}

- (void) revealedTileIsZeroAtRow: (NSInteger) rowIndex column: (NSInteger) columnIndex
{
    NSLog(@"Revealed zero at row: %ld, col: %ld", (unsigned long) rowIndex, (unsigned long) columnIndex);
    
    if (rowIndex < 0 || columnIndex < 0 || rowIndex >= [self.minefield rows] || columnIndex >= [self.minefield columns])
        return;
    
    TileView *tileView = [self tileViewAtRow: rowIndex column: columnIndex];
    NSLog(@"Count: %ld", (long)[tileView adjacentMines]);
    
    if ([tileView isRevealed] || [tileView isMine])
        return;
    
    [tileView setRevealed: YES];
    [tileView revealTileViewWithZero];
    NSLog(@"row: %ld", (unsigned long)[tileView rowIndex]);
    NSLog(@"col: %ld", (unsigned long)[tileView columnIndex]);
    
    if ([tileView adjacentMines] == 0)
    {
        NSLog(@"Adjacent Mines == 0");
        for (NSInteger row = rowIndex - 1; row <= rowIndex + 1; row++)
        {
            for (NSInteger column = columnIndex - 1; column <= columnIndex + 1; column++)
            {
                [self revealedTileIsZeroAtRow: row column: column];
            }
        }
    }
    else if ([tileView adjacentMines] > 0)
    {
        [tileView revealTile];
    }
}

- (void) didFlagTile: (TileView *) tileView
{
    [self.flaggedTileViews addObject: tileView];
    NSLog(@"Flag count: %lu", (unsigned long) [self.flaggedTileViews count]);
}

- (void) didUnFlagTile: (TileView *) tileView
{
    [self.flaggedTileViews removeObject: tileView];
    NSLog(@"Flag count: %lu", (unsigned long) [self.flaggedTileViews count]);
}

@end
