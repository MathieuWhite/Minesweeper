//
//  GameView.h
//  Minesweeper
//
//  Created by Mathieu White on 2014-10-02.
//  Copyright (c) 2014 Mathieu White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MinefieldView.h"

static NSString * const kGameViewDidFinishNewGameNotification = @"kGameViewDidFinishNewGameNotification";
static NSString * const kGameViewDidFinishUserWinsNotification = @"kGameViewDidFinishUserWinsNotification";
static NSString * const kGameViewToMenuNotification = @"kGameViewToMenuNotification";

@interface GameView : UIView

- (instancetype) initWithFrame: (CGRect) frame difficulty: (MinefieldDifficulty) difficulty;

@end
