//
//  DemoGameViewFlag.m
//  Minesweeper
//
//  Created by Mathieu White on 2014-10-09.
//  Copyright (c) 2014 Mathieu White. All rights reserved.
//

#import "DemoGameViewFlag.h"
#import "DemoTileView.h"

@interface DemoGameViewFlag()

@property (nonatomic, weak) UIImageView *flagWalkthroughView;
@property (nonatomic, weak) DemoTileView *flagDemoTileView;
@property (nonatomic, weak) UILabel *helpLabel;

@end

@implementation DemoGameViewFlag

- (instancetype) initWithFrame: (CGRect) frame
{
    self = [super initWithFrame: frame];
    
    if (self)
    {
        [self initGameViewFlagDemo];
    }
    
    return self;
}

- (void) initGameViewFlagDemo
{
    // Demo Minefield
    UIImageView *flagWalkthroughView = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 280, 280)];
    [flagWalkthroughView setImage: [UIImage imageNamed:@"walkthroughFlag"]];
    [flagWalkthroughView setUserInteractionEnabled: YES];
    [flagWalkthroughView setCenter: [self center]];
    
    // Demo Tile
    DemoTileView *flagDemoTileView = [[DemoTileView alloc] initWithTileViewType: DemoTileViewTypeFlag];
    [flagDemoTileView setFrame: CGRectMake(128, 88, 64, 64)];
    [flagDemoTileView setDarkerTone: YES];
    
    // Help Label
    UILabel *helpLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 320, 44)];
    [helpLabel setCenter: CGPointMake(self.center.x, self.center.y + 160)];
    [helpLabel setText: @"Tap and hold tiles to mark as flagged"];
    [helpLabel setTextColor: [UIColor whiteColor]];
    [helpLabel setTextAlignment: NSTextAlignmentCenter];
    [helpLabel setFont: [UIFont fontWithName: @"HelveticaNeue-Light" size: 16.0f]];
    
    // Add the tile to the minefield
    [flagWalkthroughView addSubview: flagDemoTileView];
    
    // Add the minefield to the view
    [self addSubview: flagWalkthroughView];
    [self addSubview: helpLabel];
    
    // Set each component to a property
    [self setFlagDemoTileView: flagDemoTileView];
    [self setFlagWalkthroughView: flagWalkthroughView];
    [self setHelpLabel: helpLabel];
}

@end
