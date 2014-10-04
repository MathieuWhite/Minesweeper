//
//  TileView.m
//  Minesweeper
//
//  Created by Mathieu White on 2014-10-02.
//  Copyright (c) 2014 Mathieu White. All rights reserved.
//

#import "TileView.h"

#pragma mark Tile Colors
#define hiddenLighterTone [UIColor colorWithRed: 102.0f/255.0f green: 99.0f/255.0f blue: 113.0f/255.0f alpha: 1.0f]
#define hiddenDarkerTone [UIColor colorWithRed: 89.0f/255.0f green: 86.0f/255.0f blue: 101.0f/255.0f alpha: 1.0f]
#define revealedLighterTone [UIColor colorWithRed: 38.0f/255.0f green: 38.0f/255.0f blue: 49.0f/255.0f alpha: 1.0f]
#define revealedDarkerTone [UIColor colorWithRed: 34.0f/255.0f green: 34.0f/255.0f blue: 45.0f/255.0f alpha: 1.0f]
#define yellowFlag [UIColor colorWithRed: 255.0f/255.0f green: 253.0f/255.0f blue: 103.0f/255.0f alpha: 1.0f]

#pragma mark - Number Colors
#define colorForNumberOne
#define colorForNumberTwo
#define colorForNumberThree
#define colorForNumberFour
#define colorForNumberFive
#define colorForNumberSix
#define colorForNumberSeven
#define colorForNumberEight
#pragma mark -

@interface TileView()

@property (nonatomic, weak) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic, weak) UILongPressGestureRecognizer *longPressGestureRecongnizer;

@property (nonatomic, weak) UIImageView *flagImage;

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
    
    // Add the objets to the view
    [self addGestureRecognizer: tapGestureRecognizer];
    [self addGestureRecognizer: longPressGestureRecongnizer];
    
    // Set the objects to properties
    [self setTapGestureRecognizer: tapGestureRecognizer];
    [self setLongPressGestureRecongnizer: longPressGestureRecongnizer];
    [self setFlagImage: flagImage];
}

- (void) tileTouched
{
    if ([self isDarkTone]) [self setBackgroundColor: revealedDarkerTone];
    else [self setBackgroundColor: revealedLighterTone];
}

- (void) tileTouchedAndHeld
{
    [self setBackgroundColor: yellowFlag];
    //[self addSubview: flagImage];
    //[self.tapGestureRecognizer setEnabled: NO];
    [self setIsFlagged: YES];
}

- (void) setDarkerTone: (BOOL) isDarkerTone
{
    if (isDarkerTone) [self setBackgroundColor: hiddenDarkerTone];
    else [self setBackgroundColor: hiddenLighterTone];
    
    [self setIsDarkTone: isDarkerTone];
}

@end