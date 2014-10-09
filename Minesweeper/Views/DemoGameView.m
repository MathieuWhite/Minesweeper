//
//  DemoGameView.m
//  Minesweeper
//
//  Created by Mathieu White on 2014-10-09.
//  Copyright (c) 2014 Mathieu White. All rights reserved.
//

#import "DemoGameView.h"

@implementation DemoGameView

- (instancetype) initWithWalkthoughPage: (DemoGameViewWalkthroughPage) walkthroughPage
{
    self = [super initWithFrame: CGRectMake(0, 0, 280, 280) difficulty: MinefieldDifficultyDemo];
    
    if (self)
    {
        if (walkthroughPage == DemoGameViewWalkthroughPageFlag)
            [self initWalkthroughFlag];
    }
    
    return self;
}

- (void) initWalkthroughFlag
{
    
}

@end
