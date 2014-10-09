//
//  DemoGameView.h
//  Minesweeper
//
//  Created by Mathieu White on 2014-10-09.
//  Copyright (c) 2014 Mathieu White. All rights reserved.
//

#import "GameView.h"

typedef NS_ENUM(NSUInteger, DemoGameViewWalkthroughPage)
{
    DemoGameViewWalkthroughPageFlag,
    DemoGameViewWalkthroughPageZoom,
    DemoGameViewWalkthroughPagePan
};

@interface DemoGameView : GameView

- (instancetype) initWithWalkthoughPage: (DemoGameViewWalkthroughPage) walkthroughPage;

@end
