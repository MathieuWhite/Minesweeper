//
//  MinefieldView.h
//  Minesweeper
//
//  Created by Mathieu White on 2014-10-04.
//  Copyright (c) 2014 Mathieu White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TileView.h"

static NSString * const kGameViewDidFinishMineHitNotification = @"kGameViewDidFinishMineHitNotification";
static NSString * const kGameViewDidRevealTileNotification = @"kGameViewDidRevealTileNotification";

typedef NS_ENUM (NSInteger, MinefieldDifficulty)
{
    MinefieldDifficultyEasy,
    MinefieldDifficultyMedium,
    MinefieldDifficultyHard,
    MinefieldDifficultyDemo
};

@interface MinefieldView : UIView

@property (nonatomic, strong) NSMutableArray *tileViews;

@property (nonatomic) NSUInteger remainingTiles;

- (instancetype) initWithDifficulty: (MinefieldDifficulty) difficulty;
- (TileView *) tileViewAtRow: (NSInteger) row column: (NSInteger) column;

@end
