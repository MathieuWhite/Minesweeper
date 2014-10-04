//
//  MinefieldView.h
//  Minesweeper
//
//  Created by Mathieu White on 2014-10-04.
//  Copyright (c) 2014 Mathieu White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TileView.h"

@interface MinefieldView : UIView

@property (nonatomic, strong) NSMutableArray *tileViews;

- (instancetype) initWithDifficulty: (NSString *) difficulty;

- (void) storeTileViewAdjacentTiles;

@end
