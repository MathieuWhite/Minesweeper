//
//  MinefieldView.h
//  Minesweeper
//
//  Created by Mathieu White on 2014-10-04.
//  Copyright (c) 2014 Mathieu White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TileView.h"

typedef NS_ENUM(NSInteger, MinefieldDifficulty)
{
    MinefieldDifficultyEasy,
    MinefieldDifficultyMedium,
    MinefieldDifficultyHard
};

@interface MinefieldView : UIView

@property (nonatomic, strong) NSMutableArray *tileViews;

- (instancetype) initWithDifficulty: (MinefieldDifficulty) difficulty;

@end
