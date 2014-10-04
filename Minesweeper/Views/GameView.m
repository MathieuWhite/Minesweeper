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
    
    MinefieldView *minefieldView = [[MinefieldView alloc] initWithDifficulty: @"easy"];
    //[minefieldView storeTileViewAdjacentTiles];
    
    // Initialize the scroll view
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame: [self bounds]];
    [scrollView setContentSize: minefieldView.bounds.size];
    [scrollView setMinimumZoomScale: (scrollView.frame.size.width / minefieldView.frame.size.width)];
    [scrollView setMaximumZoomScale: 1];
    [scrollView setZoomScale: 1];
    [scrollView setShowsHorizontalScrollIndicator: NO];
    [scrollView setShowsVerticalScrollIndicator: NO];
    [scrollView setDelegate: self];
    
    // Add the components to the scroll view
    [scrollView addSubview: minefieldView];
    
    // Add the scroll view to the view
    [self addSubview: scrollView];
    
    // Set each component to a property
    [self setScrollView: scrollView];
    [self setMinefieldView: minefieldView];
}

#pragma mark - UIScrollViewDelegate Methods

- (void) scrollViewDidZoom: (UIScrollView *) scrollView
{
    NSLog(@"scrollViewDidZoom");
    
    CGFloat offsetX = MAX((scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5, 0.0);
    CGFloat offsetY = MAX((scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5, 0.0);
    
    [self.minefieldView setCenter: CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                               scrollView.contentSize.height * 0.5 + offsetY)];
    
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
                        completion: ^(BOOL finished) {
                            [self.minefieldView setUserInteractionEnabled: YES];
                        }];
    }
    else
    {
        [UIView transitionWithView: scrollView
                          duration: 0.4f
                           options: UIViewAnimationOptionCurveEaseInOut
                        animations: ^{
                            [scrollView setZoomScale: 0.5f];
                        }
                        completion: ^(BOOL finished) {
                            [self.minefieldView setUserInteractionEnabled: NO];
                        }];
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
