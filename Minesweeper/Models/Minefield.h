//
//  Minefield.h
//  Minesweeper
//
//  Created by Mathieu White on 2014-10-03.
//  Copyright (c) 2014 Mathieu White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tile.h"

@interface Minefield : NSObject

@property (nonatomic, strong) NSMutableArray *tiles;
@property (nonatomic) NSUInteger mines;
@property (nonatomic) NSUInteger revealedTiles;
@property (nonatomic) BOOL didHitMine;

- (id) initWithMines: (NSUInteger) mines rows: (NSUInteger) rows columns: (NSUInteger) columns;
- (Tile *) tileAtRow: (NSUInteger) row column: (NSUInteger) column;

- (NSUInteger) rows;
- (NSUInteger) columns;
- (NSUInteger) safeTiles;
- (NSInteger) revealTileAtRow: (NSUInteger) row column: (NSUInteger) column;
- (BOOL) autoRevealTileAtRow: (NSUInteger) row column: (NSUInteger) column;

- (void) resetMinefield;

@end
