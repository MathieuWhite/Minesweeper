//
//  GameViewController.h
//  Minesweeper
//
//  Created by Mathieu White on 2014-10-06.
//  Copyright (c) 2014 Mathieu White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameView.h"

@interface GameViewController : UIViewController

@property (nonatomic, weak) GameView *gameView;

@end
