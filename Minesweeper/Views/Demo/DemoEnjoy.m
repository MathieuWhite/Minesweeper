//
//  DemoEnjoy.m
//  Minesweeper
//
//  Created by Mathieu White on 2014-10-10.
//  Copyright (c) 2014 Mathieu White. All rights reserved.
//

#import "DemoEnjoy.h"

@interface DemoEnjoy()

@property (nonatomic, weak) UIImageView *enjoyImage;
@property (nonatomic, weak) UILabel *helpLabel;

@end

@implementation DemoEnjoy

- (instancetype) initWithFrame: (CGRect) frame
{
    self = [super initWithFrame: frame];
    
    if (self)
    {
        [self initEnjoyGameView];
    }
    
    return self;
}

- (void) initEnjoyGameView
{
    // Enjoy View
    UIImageView *enjoyImage = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 120, 120)];
    [enjoyImage setImage: [UIImage imageNamed: @"walkthroughEnjoy"]];
    [enjoyImage setCenter: [self center]];
    
    // Help Label
    UILabel *helpLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 320, 44)];
    [helpLabel setCenter: CGPointMake(self.center.x, self.center.y + 120)];
    [helpLabel setText: @"Have fun and enjoy the game!"];
    [helpLabel setTextColor: [UIColor whiteColor]];
    [helpLabel setTextAlignment: NSTextAlignmentCenter];
    [helpLabel setFont: [UIFont fontWithName: @"HelveticaNeue-Light" size: 16.0f]];
    
    // Add the minefield to the view
    [self addSubview: enjoyImage];
    [self addSubview: helpLabel];
    
    // Set each component to a property
    [self setEnjoyImage: enjoyImage];
    [self setHelpLabel: helpLabel];
}

@end
