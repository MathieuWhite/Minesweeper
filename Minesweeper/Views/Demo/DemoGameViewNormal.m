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
    for (NSUInteger rowIndex = 0; rowIndex < 3; rowIndex++)
    {
        for (NSUInteger columnIndex = 0; columnIndex < 3; columnIndex++)
        {
            CGFloat offsetX = (columnIndex * 64);
            CGFloat offsetY = (rowIndex * 64) + 24;
            
            NSUInteger random = arc4random_uniform((uint32_t) 8) + 1;

            DemoTileView *normalDemoTileView = [[DemoTileView alloc] initWithTileViewType: DemoTileViewTypeNormal];
            [normalDemoTileView setFrame: CGRectMake(offsetX, offsetY, 64, 64)];
            [normalDemoTileView setAdjacentMines: random];
            
            if ((columnIndex + rowIndex) % 2 == 0)
                [normalDemoTileView setDarkerTone: YES];
            else [normalDemoTileView setDarkerTone: NO];
            
            [normalWalkthroughView addSubview: normalDemoTileView];
        }
    }
    
    // Help Label
    UILabel *helpLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, self.frame.size.height - 64, 320, 44)];
    [helpLabel setText: @"Reveal tiles and avoid mines"];
    [helpLabel setTextColor: [UIColor whiteColor]];
    [helpLabel setTextAlignment: NSTextAlignmentCenter];
    [helpLabel setFont: [UIFont fontWithName: @"HelveticaNeue-Light" size: 16.0f]];
    
    // Add the minefield to the view
    [self addSubview: normalWalkthroughView];
    [self addSubview: helpLabel];
    
    // Set each component to a property
    //[self setFlagDemoTileView: flagDemoTileView];
    [self setNormalWalkthroughView: normalWalkthroughView];
    [self setHelpLabel: helpLabel];
}

@end
