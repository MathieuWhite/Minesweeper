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

- (void) revealedTile;
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

@property (nonatomic, getter = isMine) BOOL mine;
@property (nonatomic, getter = isFlagged) BOOL flagged;
@property (nonatomic, getter = isRevealed) BOOL revealed;

- (void) setDarkerTone: (BOOL) darkerTone;
- (void) revealTile;
- (void) revealTileViewMineAfterMineHit;
- (void) revealTileViewWithZero;
- (void) toggleTileMarkedAsFlag;
- (void) disableGestureRecognizers;
- (void) enableGestureRecognizers;

@end
