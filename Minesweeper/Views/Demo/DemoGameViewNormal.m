//
//  DemoGameViewNormal.m
//  Minesweeper
//
//  Created by Mathieu White on 2014-10-09.
//  Copyright (c) 2014 Mathieu White. All rights reserved.
//

#import "DemoGameViewNormal.h"
#import "DemoTileView.h"

@interface DemoGameViewNormal()

@property (nonatomic, weak) UIImageView *normalWalkthroughView;
@property (nonatomic, weak) DemoTileView *flagDemoTileView;
@property (nonatomic, weak) UILabel *helpLabel;

@end

@implementation DemoGameViewNormal

- (instancetype) initWithFrame: (CGRect) frame
{
    self = [super initWithFrame: frame];
    
    if (self)
    {
        [self initGameViewNormalDemo];
    }
    
    return self;
}

- (void) initGameViewNormalDemo
{
    // Demo Minefield
    UIImageView *normalWalkthroughView = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 280, 280)];
    [normalWalkthroughView setImage: [UIImage imageNamed:@"walkthroughNormal"]];
    [normalWalkthroughView setUserInteractionEnabled: YES];
    [normalWalkthroughView setCenter: [self center]];
    
    // Demo Tiles
    for (NSInteger rowIndex = 0; rowIndex < 4; rowIndex++)
    {
        for (NSInteger columnIndex = 0; columnIndex < 4; columnIndex++)
        {
            CGFloat offsetX = (columnIndex * 64) + 24;
            CGFloat offsetY = (rowIndex * 64) + 12;
            
            NSUInteger random = arc4random_uniform((uint32_t) 8) + 1;

            DemoTileView *normalDemoTileView = [[DemoTileView alloc] initWithTileViewType: DemoTileViewTypeNormal];
            [normalDemoTileView setFrame: CGRectMake(offsetX, offsetY, 64, 64)];
            [normalDemoTileView setAdjacentMines: random];
            
            if ((columnIndex + rowIndex) % 2 == 0)
                [normalDemoTileView setDarkerTone: NO];
            else [normalDemoTileView setDarkerTone: YES];
            
            [normalWalkthroughView addSubview: normalDemoTileView];
        }
    }
    
    // Help Label
    UILabel *helpLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 320, 44)];
    [helpLabel setCenter: CGPointMake(self.center.x, self.center.y + 160)];
    [helpLabel setText: @"Reveal tiles and avoid mines"];
    [helpLabel setTextColor: [UIColor whiteColor]];
    [helpLabel setTextAlignment: NSTextAlignmentCenter];
    [helpLabel setFont: [UIFont fontWithName: @"HelveticaNeue-Light" size: 16.0f]];
    
    // Add the minefield to the view
    [self addSubview: normalWalkthroughView];
    [self addSubview: helpLabel];
    
    // Set each component to a property
    [self setNormalWalkthroughView: normalWalkthroughView];
    [self setHelpLabel: helpLabel];
}

@end
