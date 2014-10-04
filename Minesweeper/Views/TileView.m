//
//  TileView.m
//  Minesweeper
//
//  Created by Mathieu White on 2014-10-02.
//  Copyright (c) 2014 Mathieu White. All rights reserved.
//

#import "TileView.h"

#pragma mark Tile Colors
#define colorForHiddenLighterTone [UIColor colorWithRed: 102.0f/255.0f green: 99.0f/255.0f blue: 113.0f/255.0f alpha: 1.0f]
#define colorForHiddenDarkerTone [UIColor colorWithRed: 89.0f/255.0f green: 86.0f/255.0f blue: 101.0f/255.0f alpha: 1.0f]
#define colorForRevealedLighterTone [UIColor colorWithRed: 38.0f/255.0f green: 38.0f/255.0f blue: 49.0f/255.0f alpha: 1.0f]
#define colorForRevealedDarkerTone [UIColor colorWithRed: 34.0f/255.0f green: 34.0f/255.0f blue: 45.0f/255.0f alpha: 1.0f]
#define colorForYellowFlag [UIColor colorWithRed: 255.0f/255.0f green: 253.0f/255.0f blue: 103.0f/255.0f alpha: 1.0f]

#pragma mark - Number Colors
#define colorForNumberOne [UIColor colorWithRed: 103.0f/255.0f green: 175.0f/255.0f blue: 255.0f/255.0f alpha: 1.0f]
#define colorForNumberTwo [UIColor colorWithRed: 103.0f/255.0f green: 255.0f/255.0f blue: 121.0f/255.0f alpha: 1.0f]
#define colorForNumberThree [UIColor colorWithRed: 255.0f/255.0f green: 103.0f/255.0f blue: 103.0f/255.0f alpha: 1.0f]
#define colorForNumberFour [UIColor colorWithRed: 103.0f/255.0f green: 255.0f/255.0f blue: 250.0f/255.0f alpha: 1.0f]
#define colorForNumberFive [UIColor colorWithRed: 255.0f/255.0f green: 167.0f/255.0f blue: 103.0f/255.0f alpha: 1.0f]
#define colorForNumberSix [UIColor colorWithRed: 255.0f/255.0f green: 253.0f/255.0f blue: 103.0f/255.0f alpha: 1.0f]
#define colorForNumberSeven [UIColor colorWithRed: 255.0f/255.0f green: 103.0f/255.0f blue: 228.0f/255.0f alpha: 1.0f]
#define colorForNumberEight [UIColor colorWithRed: 175.0f/255.0f green: 103.0f/255.0f blue: 255.0f/255.0f alpha: 1.0f]
#pragma mark -

@interface TileView()

@property (nonatomic, weak) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic, weak) UILongPressGestureRecognizer *longPressGestureRecongnizer;

@property (nonatomic, weak) UIImageView *flagImage;
@property (nonatomic, weak) UILabel *adjacentCellsLabel;

@property BOOL isDarkTone;
@property BOOL isFlagged;

@end

@implementation TileView

#pragma mark - UIView Methods

- (instancetype) initWithFrame: (CGRect) frame
{
    self = [super initWithFrame: frame];
    
    if (self)
    {
        [self initTile];
    }
    
    return self;
}

#pragma mark - Object Methods

- (void) initTile
{
    // Create the gesture recognizer to handle single taps on the tile
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                    initWithTarget: self action: @selector(tileTouched)];
    
    // Create the gesture recognizer to handle long presses on the tile
    UILongPressGestureRecognizer *longPressGestureRecongnizer = [[UILongPressGestureRecognizer alloc]
                                                                 initWithTarget: self action: @selector(tileTouchedAndHeld)];
    
    // Initialize the flag image
    UIImageView *flagImage = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"flag"]];
    [flagImage setFrame: CGRectMake(0, 0, 64, 64)];
    
    // Initialize the label
    UILabel *adjacentCellsLabel = [[UILabel alloc] initWithFrame: [self bounds]];
    [adjacentCellsLabel setTextAlignment: NSTextAlignmentCenter];
    
    // Add the objets to the view
    [self addGestureRecognizer: tapGestureRecognizer];
    [self addGestureRecognizer: longPressGestureRecongnizer];
    
    // Set the objects to properties
    [self setTapGestureRecognizer: tapGestureRecognizer];
    [self setLongPressGestureRecongnizer: longPressGestureRecongnizer];
    [self setFlagImage: flagImage];
    [self setAdjacentCellsLabel: adjacentCellsLabel];
}

- (void) tileTouched
{
    if ([self isDarkTone]) [self setBackgroundColor: colorForRevealedDarkerTone];
    else [self setBackgroundColor: colorForRevealedLighterTone];
}

- (void) tileTouchedAndHeld
{
    [self setBackgroundColor: colorForYellowFlag];
    //[self addSubview: flagImage];
    //[self.tapGestureRecognizer setEnabled: NO];
    [self setIsFlagged: YES];
}

- (void) setDarkerTone: (BOOL) isDarkerTone
{
    if (isDarkerTone) [self setBackgroundColor: colorForHiddenDarkerTone];
    else [self setBackgroundColor: colorForHiddenLighterTone];
    
    [self setIsDarkTone: isDarkerTone];
}

@end