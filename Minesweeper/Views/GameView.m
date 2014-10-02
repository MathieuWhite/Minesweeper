//
//  GameView.m
//  Minesweeper
//
//  Created by Mathieu White on 2014-10-02.
//  Copyright (c) 2014 Mathieu White. All rights reserved.
//

#import "GameView.h"
#import "TileView.h"

@interface GameView() <UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) TileView *tileView;

@end

@implementation GameView

#pragma mark - UIView Methods

- (instancetype) initWithFrame: (CGRect) frame
{
    self = [super initWithFrame: frame];
    
    if (self)
    {
        [self initGameView];
    }
    
    return self;
}

#pragma mark - Object Methods

- (void) initGameView
{
    // Set the background color
    [self setBackgroundColor: [UIColor colorWithRed: 46.f/255.f green: 46.f/255.f blue: 59.f/255.f alpha: 1.f]];
    
    // Initialize the scroll view
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame: [self frame]];
    [scrollView setContentSize: CGSizeMake(640, 1136)];
    [scrollView setZoomScale: 1.0f];
    [scrollView setMinimumZoomScale: 0.5f];
    [scrollView setMaximumZoomScale: 1.0f];
    [scrollView setDelegate: self];
    
    // Create a tile
    TileView *tileView = [[TileView alloc] initWithFrame: CGRectMake(0, 0, 64, 64)];
    [tileView setCenter: [scrollView center]];
    
    // Add the components to the scroll view
    [scrollView addSubview: tileView];
    
    // Add the scroll view to the view
    [self addSubview: scrollView];
    
    // Set each component to a property
    [self setScrollView: scrollView];
    [self setTileView: tileView];
}

#pragma mark - UIScrollViewDelegate Methods

- (void) scrollViewDidZoom: (UIScrollView *) scrollView
{
    NSLog(@"scrollViewDidZoom");
}

- (UIView *) viewForZoomingInScrollView: (UIScrollView *) scrollView
{
    return self;
}

- (void) scrollViewDidEndZooming: (UIScrollView *) scrollView withView: (UIView *) view atScale: (CGFloat) scale
{
    
}

- (void) scrollViewDidScroll: (UIScrollView *) scrollView
{
    NSLog(@"scrollViewDidScroll");
}

@end
