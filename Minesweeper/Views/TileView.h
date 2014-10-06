//
//  TileView.h
//  Minesweeper
//
//  Created by Mathieu White on 2014-10-02.
//  Copyright (c) 2014 Mathieu White. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TileView;

@protocol TileViewDelegate <NSObject>

- (void) revealedTileIsMine: (TileView *) tileView;
- (void) revealedTileIsZeroAtRow: (NSInteger) rowIndex column: (NSInteger) columnIndex;
- (void) didFlagTile: (TileView *) tileView;
- (void) didUnFlagTile: (TileView *) tileView;

@end

@interface TileView : UIView

@property (nonatomic, weak) id <TileViewDelegate> delegate;

//@property (nonatomic, strong) NSMutableArray *adjacentTiles;
@property (nonatomic) NSInteger adjacentMines;
@property (nonatomic) NSUInteger rowIndex;
@property (nonatomic) NSUInteger columnIndex;

@property (nonatomic) BOOL isMine;
@property (nonatomic) BOOL isFlagged;
@property (nonatomic) BOOL isRevealed;

- (void) setDarkerTone: (BOOL) isDarkerTone;
- (void) revealTile;
- (void) revealTileViewMineAfterMineHit;
- (void) revealTileViewWithZero;
- (void) disableGestureRecognizers;
- (void) enableGestureRecognizers;

@end
