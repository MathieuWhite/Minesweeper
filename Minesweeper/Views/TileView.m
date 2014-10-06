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
#define colorForHitMine [UIColor colorWithRed: 144.0f/255.0f green: 22.0f/255.0f blue: 22.0f/255.0f alpha: 1.0f]

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
@property (nonatomic, weak) UIImageView *mineImage;
@property (nonatomic, weak) UILabel *adjacentMinesLabel;

@property (nonatomic) BOOL isDarkTone;
@property (nonatomic) BOOL didHitMine;

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
                                                    initWithTarget: self action: @selector(touchedTile)];
    
    // Create the gesture recognizer to handle long presses on the tile
    UILongPressGestureRecognizer *longPressGestureRecongnizer = [[UILongPressGestureRecognizer alloc]
                                                                 initWithTarget: self action: @selector(touchedAndHeldTile:)];
    
    // Initialize the array that will hold the adjacent tiles
    //NSMutableArray *adjacentTiles = [[NSMutableArray alloc] initWithCapacity: 8];
    
    // Initialize the flag image
    UIImageView *flagImage = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 64, 64)];
    
    // Initialize the mine image
    UIImageView *mineImage = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 64, 64)];
    
    // Initialize the label
    UILabel *adjacentMinesLabel = [[UILabel alloc] initWithFrame: [self bounds]];
    [adjacentMinesLabel setTextAlignment: NSTextAlignmentCenter];
    [adjacentMinesLabel setFont: [UIFont systemFontOfSize: 30.0f]];
    
    // Add the objets to the view
    [self addGestureRecognizer: tapGestureRecognizer];
    [self addGestureRecognizer: longPressGestureRecongnizer];
    [self addSubview: flagImage];
    [self addSubview: mineImage];
    [self addSubview: adjacentMinesLabel];
    
    // Set the objects to properties
    [self setTapGestureRecognizer: tapGestureRecognizer];
    [self setLongPressGestureRecongnizer: longPressGestureRecongnizer];
    [self setFlagImage: flagImage];
    [self setMineImage: mineImage];
    [self setAdjacentMinesLabel: adjacentMinesLabel];
    //[self setAdjacentTiles: adjacentTiles];
    
    [self setIsRevealed: NO];
    [self setIsFlagged: NO];
    [self setIsMine: NO];
    [self setDidHitMine: NO];
}

- (void) setDarkerTone: (BOOL) isDarkerTone
{
    if (isDarkerTone) [self setBackgroundColor: colorForHiddenDarkerTone];
    else [self setBackgroundColor: colorForHiddenLighterTone];
    
    [self setIsDarkTone: isDarkerTone];
}

# pragma mark - Gesture Methods

- (void) touchedTile
{
    [self revealTile];
}

- (void) revealTile
{
    if ([self adjacentMines] == 0)
    {
        [self revealTileViewWithZero];
        
        // Check if the delegate is set and it responds to the selector
        if ([self.delegate respondsToSelector: @selector(revealedTileIsZeroAtRow:column:)])
            [self.delegate revealedTileIsZeroAtRow: [self rowIndex] column: [self columnIndex]];
        
        return;
    }
    
    [self setIsRevealed: YES];
    
    [self disableGestureRecognizers];
    
    if ([self isDarkTone]) [self setBackgroundColor: colorForRevealedDarkerTone];
    else [self setBackgroundColor: colorForRevealedLighterTone];
    
    if ([self adjacentMines] == -1)
    {
        [self setDidHitMine: YES];
        
        [self setBackgroundColor: colorForHitMine];

        [self.mineImage setImage: [UIImage imageNamed: @"mine"]];
        
        // Check if the delegate is set and it responds to the selector
        if ([self.delegate respondsToSelector: @selector(revealedTileIsMine:)])
            [self.delegate revealedTileIsMine: self];
         
        return;
    }
    
    if ([self adjacentMines] == 1) [self.adjacentMinesLabel setTextColor: colorForNumberOne];
    else if ([self adjacentMines] == 2) [self.adjacentMinesLabel setTextColor: colorForNumberTwo];
    else if ([self adjacentMines] == 3) [self.adjacentMinesLabel setTextColor: colorForNumberThree];
    else if ([self adjacentMines] == 4) [self.adjacentMinesLabel setTextColor: colorForNumberFour];
    else if ([self adjacentMines] == 5) [self.adjacentMinesLabel setTextColor: colorForNumberFive];
    else if ([self adjacentMines] == 6) [self.adjacentMinesLabel setTextColor: colorForNumberSix];
    else if ([self adjacentMines] == 7) [self.adjacentMinesLabel setTextColor: colorForNumberSeven];
    else if ([self adjacentMines] == 8) [self.adjacentMinesLabel setTextColor: colorForNumberEight];
    else [self.adjacentMinesLabel setTextColor: [UIColor whiteColor]];
    
    NSLog(@"%ld", (long)[self adjacentMines]);
    [self.adjacentMinesLabel setText: [NSString stringWithFormat: @"%ld", (long)[self adjacentMines]]];
}

- (void) revealTileViewWithZero
{
    //[self setIsRevealed: YES];
    [self disableGestureRecognizers];

    if ([self isDarkTone]) [self setBackgroundColor: colorForRevealedDarkerTone];
    else [self setBackgroundColor: colorForRevealedLighterTone];
}

- (void) revealTileViewMineAfterMineHit
{
    [self disableGestureRecognizers];
    
    // Reveal the mines that aren't flagged
    if (![self didHitMine] && ![self isFlagged])
    {
        if ([self isDarkTone]) [self setBackgroundColor: colorForRevealedDarkerTone];
        else [self setBackgroundColor: colorForRevealedLighterTone];
        [self.mineImage setImage: [UIImage imageNamed:@"mine"]];
    }
    
    // Reveal incorrectly flagged tiles
    if (![self isMine] && [self isFlagged])
    {
        NSLog(@"Incorrect flag");
        [self.flagImage removeFromSuperview];
        
        if ([self isDarkTone]) [self setBackgroundColor: colorForRevealedDarkerTone];
        else [self setBackgroundColor: colorForRevealedLighterTone];
        
        [self.adjacentMinesLabel setTextColor: colorForYellowFlag];
        [self.adjacentMinesLabel setText: @"x"];
    }
}

- (void) disableGestureRecognizers
{
    [self.tapGestureRecognizer setEnabled: NO];
    [self.longPressGestureRecongnizer setEnabled: NO];
}

- (void) enableGestureRecognizers
{
    [self.tapGestureRecognizer setEnabled: YES];
    [self.longPressGestureRecongnizer setEnabled: YES];
}

- (void) touchedAndHeldTile: (UILongPressGestureRecognizer *) longPressGestureRecognizer
{
    if (longPressGestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        if (![self isFlagged])
        {
            [self.tapGestureRecognizer setEnabled: NO];
            [self setBackgroundColor: colorForYellowFlag];
            [self.flagImage setImage: [UIImage imageNamed: @"flag"]];
            [self setIsFlagged: YES];
            
            // Check if the delegate is set and it responds to the selector
            if ([self.delegate respondsToSelector: @selector(didFlagTile:)])
                [self.delegate didFlagTile: self];
        }
        else
        {
            [self.tapGestureRecognizer setEnabled: YES];
            
            if ([self isDarkTone]) [self setDarkerTone: YES];
            else [self setDarkerTone: NO];
            
            [self.flagImage setImage: nil];
            [self setIsFlagged: NO];
            
            // Check if the delegate is set and it responds to the selector
            if ([self.delegate respondsToSelector: @selector(didUnFlagTile:)])
                [self.delegate didUnFlagTile: self];
        }
    }
}

@end