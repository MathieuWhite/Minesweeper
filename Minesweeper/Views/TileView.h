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
- (void) didFlagTile: (TileView *) tileView;
- (void) didUnFlagTile: (TileView *) tileView;

@end

@interface TileView : UIView

@property (nonatomic, weak) id <TileViewDelegate> delegate;

@property (nonatomic, strong) NSMutableArray *adjacentTiles;
@property (nonatomic) NSInteger adjacentMines;

@property (nonatomic) BOOL isMine;

- (void) setDarkerTone: (BOOL) isDarkerTone;
- (void) revealTile;
- (void) revealTileViewMineAfterMineHit;
- (void) disableGestureRecognizers;
- (void) enableGestureRecognizers;

@end
