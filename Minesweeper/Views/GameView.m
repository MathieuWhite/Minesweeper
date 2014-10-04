//
//  GameView.m
//  Minesweeper
//
//  Created by Mathieu White on 2014-10-02.
//  Copyright (c) 2014 Mathieu White. All rights reserved.
//

#import "GameView.h"
#import "MinefieldView.h"

@interface GameView() <UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;
//@property (nonatomic, weak) UIView *mineFieldView;
//@property (nonatomic, weak) TileView *tileView;

@property (nonatomic, weak) MinefieldView *minefieldView;

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
    [self setBackgroundColor: [UIColor colorWithRed: 46.0f/255.0f green: 46.0f/255.0f blue: 59.0f/255.0f alpha: 1.0f]];
    
    // Create the minefield view
    // Frame will depend on difficulty - to implement later..
    //UIView *mineFieldView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 576, 576)];
    
    MinefieldView *minefieldView = [[MinefieldView alloc] initWithDifficulty: @"easy"];
    
    /*
    // Initialize the scroll view
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame: [self bounds]];
    [scrollView setContentSize: mineFieldView.frame.size];
    [scrollView setMinimumZoomScale: (scrollView.frame.size.width / mineFieldView.frame.size.width)];
    [scrollView setMaximumZoomScale: 1];
    [scrollView setZoomScale: 1];
    [scrollView setShowsHorizontalScrollIndicator: NO];
    [scrollView setShowsVerticalScrollIndicator: NO];
    [scrollView setDelegate: self];
     */
    
    /*
    // Create the CardViews
    for (NSUInteger row = 0; row < 9; row++)
    {
        for (NSUInteger col = 0; col < 9; col++)
        {
            CGFloat offsetX = (row * 64);
            CGFloat offsetY = (col * 64);
            
            TileView *tileView = [[TileView alloc] initWithFrame: CGRectMake(offsetX, offsetY, 64, 64)];
            
            if ((row + col) % 2 == 0)
                [tileView setDarkerTone: YES];
            else [tileView setDarkerTone: NO];
            
            //[scrollView addSubview: tileView];
            [mineFieldView addSubview: tileView];
        }
    }
     */
    
    // Create a tile
    //TileView *tileView = [[TileView alloc] initWithFrame: CGRectMake(0, 0, 64, 64)];
    //[tileView setCenter: [scrollView center]];
    
    // Add the components to the scroll view
    //[scrollView addSubview: mineFieldView];
    
    // Add the scroll view to the view
    //[self addSubview: scrollView];
    //[self addSubview: mineFieldView];
    [self addSubview: minefieldView];
    
    // Set each component to a property
    //[self setScrollView: scrollView];
    //[self setTileView: tileView];
    
    [self setMinefieldView: minefieldView];
}

#pragma mark - UIScrollViewDelegate Methods

- (void) scrollViewDidZoom: (UIScrollView *) scrollView
{
    NSLog(@"scrollViewDidZoom");
    /*
    CGFloat offsetX = MAX((scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5, 0.0);
    CGFloat offsetY = MAX((scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5, 0.0);
    
    [self.mineFieldView setCenter: CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                               scrollView.contentSize.height * 0.5 + offsetY)];
    */
}

- (void) scrollViewDidEndZooming: (UIScrollView *) scrollView withView: (UIView *) view atScale: (CGFloat) scale
{
    NSLog(@"viewForZoomingInScrollView");
    if ([scrollView zoomScale] >= 0.75f)
    {
        [UIView transitionWithView: scrollView
                          duration: 0.4f
                           options: UIViewAnimationOptionCurveEaseInOut
                        animations: ^{
                            [scrollView setZoomScale: 1.0f];
                        }
                        completion: NULL];
    }
    else
    {
        [UIView transitionWithView: scrollView
                          duration: 0.4f
                           options: UIViewAnimationOptionCurveEaseInOut
                        animations: ^{
                            [scrollView setZoomScale: 0.5f];
                        }
                        completion: NULL];
    }
        
}

- (void) scrollViewDidScroll: (UIScrollView *) scrollView
{
    if (![scrollView isDragging]) return;
    
    NSLog(@"scrollViewDidScroll");
}

- (UIView *) viewForZoomingInScrollView: (UIScrollView *) scrollView
{
    return [self minefieldView];
}

@end
