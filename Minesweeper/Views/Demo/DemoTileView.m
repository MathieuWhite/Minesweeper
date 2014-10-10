//
//  DemoTileView.m
//  Minesweeper
//
//  Created by Mathieu White on 2014-10-09.
//  Copyright (c) 2014 Mathieu White. All rights reserved.
//

#import "DemoTileView.h"

#define colorForHiddenLighterTone [UIColor colorWithRed: 102.0f/255.0f green: 99.0f/255.0f blue: 113.0f/255.0f alpha: 1.0f]
#define colorForHiddenDarkerTone [UIColor colorWithRed: 89.0f/255.0f green: 86.0f/255.0f blue: 101.0f/255.0f alpha: 1.0f]
#define colorForRevealedLighterTone [UIColor colorWithRed: 38.0f/255.0f green: 38.0f/255.0f blue: 49.0f/255.0f alpha: 1.0f]
#define colorForRevealedDarkerTone [UIColor colorWithRed: 34.0f/255.0f green: 34.0f/255.0f blue: 45.0f/255.0f alpha: 1.0f]
#define colorForYellowFlag [UIColor colorWithRed: 255.0f/255.0f green: 253.0f/255.0f blue: 103.0f/255.0f alpha: 1.0f]

@interface DemoTileView()

@property (nonatomic, weak) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic, weak) UILongPressGestureRecognizer *longPressGestureRecongnizer;

@property (nonatomic, weak) UIImageView *flagImage;
@property (nonatomic, weak) UILabel *adjacentMinesLabel;

@property (nonatomic, getter = isFlagged) BOOL flagged;
@property (nonatomic, getter = isDarkTone) BOOL darkTone;

@end

@implementation DemoTileView

# pragma mark - Object Methods

- (instancetype) initWithTileViewType: (DemoTileViewType) tileViewType
{
    self = [super initWithFrame: CGRectMake(0, 0, 64, 64)];
    
    if (self)
    {
        if (tileViewType == DemoTileViewTypeFlag)
            [self initTileViewTypeFlag];
    }
    
    return self;
}

- (void) initTileViewTypeFlag
{
    // Create the gesture recognizer to handle long presses on the tile
    UILongPressGestureRecognizer *longPressGestureRecongnizer = [[UILongPressGestureRecognizer alloc]
                                                                 initWithTarget: self action: @selector(touchedAndHeldTile:)];
    
    // Initialize the flag image
    UIImageView *flagImage = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 64, 64)];
    
    // Add the objets to the view
    [self addGestureRecognizer: longPressGestureRecongnizer];
    [self addSubview: flagImage];
    
    // Set the objects to properties
    [self setLongPressGestureRecongnizer: longPressGestureRecongnizer];
    [self setFlagImage: flagImage];
    
    [self setFlagged: NO];
}

- (void) initTileViewTypeNormal
{
    
}

- (void) setDarkerTone: (BOOL) darkerTone
{
    if (darkerTone) [self setBackgroundColor: colorForHiddenDarkerTone];
    else [self setBackgroundColor: colorForHiddenLighterTone];
    
    [self setDarkTone: darkerTone];
}

# pragma mark - Gesture Recognizer Methods

- (void) touchedAndHeldTile: (UILongPressGestureRecognizer *) longPressGestureRecognizer
{
    if (longPressGestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        [self toggleTileMarkedAsFlag];
    }
}

- (void) toggleTileMarkedAsFlag
{
    if (![self isFlagged])
    {
        [self setBackgroundColor: colorForYellowFlag];
        [self.flagImage setImage: [UIImage imageNamed: @"flag"]];
        [self setFlagged: YES];
    }
    else
    {
        if ([self isDarkTone]) [self setDarkerTone: YES];
        else [self setDarkerTone: NO];
        
        [self.flagImage setImage: nil];
        [self setFlagged: NO];
    }
}

@end
