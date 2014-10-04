//
//  TileView.h
//  Minesweeper
//
//  Created by Mathieu White on 2014-10-02.
//  Copyright (c) 2014 Mathieu White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tile.h"

@interface TileView : UIView

@property (nonatomic) NSInteger adjacentCells;

- (void) setDarkerTone: (BOOL) isDarkerTone;
- (void) touchedTile;

@end
