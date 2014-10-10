//
//  DemoMinefieldView.m
//  Minesweeper
//
//  Created by Mathieu White on 2014-10-10.
//  Copyright (c) 2014 Mathieu White. All rights reserved.
//

#import "DemoMinefieldView.h"
#import "DemoTileView.h"
#import "UIScrollView+ZoomToPoint.h"

@interface DemoMinefieldView() <UIScrollViewDelegate>

@property (nonatomic, weak) UITapGestureRecognizer *doubleTapGestureRecognizer;

@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, weak) UIView *minefieldWalkthroughView;

@end

@implementation DemoMinefieldView

- (instancetype) initWithFrame: (CGRect) frame
{
    self = [super initWithFrame: frame];
    
    if (self)
    {
        [self initMineFieldDemo];
    }
    
    return self;
}

- (void) initMineFieldDemo
{
    // Initialize the tap gesture recognizer
    UITapGestureRecognizer *doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget: self
                                                                                                 action: @selector(doubleTap)];
    [doubleTapGestureRecognizer setNumberOfTapsRequired: 2];
    [doubleTapGestureRecognizer setEnabled: NO];
    
    // Demo Minefield View
    UIView *minefieldWalkthroughView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 512, 512)];
    
    // Demo Tiles
    for (NSInteger rowIndex = 0; rowIndex < 8; rowIndex++)
    {
        for (NSInteger columnIndex = 0; columnIndex < 8; columnIndex++)
        {
            CGFloat offsetX = (columnIndex * 64);
            CGFloat offsetY = (rowIndex * 64);
            
            NSUInteger random = arc4random_uniform((uint32_t) 8) + 1;
            
            DemoTileView *normalDemoTileView = [[DemoTileView alloc] initWithTileViewType: DemoTileViewTypeNormal];
            [normalDemoTileView setFrame: CGRectMake(offsetX, offsetY, 64, 64)];
            [normalDemoTileView setAdjacentMines: random];
            
            if ((columnIndex + rowIndex) % 2 == 0)
                [normalDemoTileView setDarkerTone: NO];
            else [normalDemoTileView setDarkerTone: YES];
            
            [minefieldWalkthroughView addSubview: normalDemoTileView];
        }
    }
    
    // Initialize the scroll view
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame: CGRectMake(0, 0, 280, 280)];
    [scrollView setCenter: [self center]];
    [scrollView setContentSize: minefieldWalkthroughView.bounds.size];
    [scrollView setMinimumZoomScale: (scrollView.frame.size.width / minefieldWalkthroughView.frame.size.width)];
    [scrollView setMaximumZoomScale: 1];
    [scrollView setZoomScale: 1];
    [scrollView setShowsHorizontalScrollIndicator: NO];
    [scrollView setShowsVerticalScrollIndicator: NO];
    [scrollView addGestureRecognizer: doubleTapGestureRecognizer];
    [scrollView setDelegate: self];
    [scrollView addSubview: minefieldWalkthroughView];
    
    // Help Label
    UILabel *helpLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 320, 44)];
    [helpLabel setCenter: CGPointMake(self.center.x, self.center.y + 160)];
    [helpLabel setTextColor: [UIColor whiteColor]];
    [helpLabel setTextAlignment: NSTextAlignmentCenter];
    [helpLabel setFont: [UIFont fontWithName: @"HelveticaNeue-Light" size: 16.0f]];
    
    // Add the minefield to the view
    [self addSubview: scrollView];
    [self addSubview: helpLabel];
    
    // Set each component to a property
    [self setDoubleTapGestureRecognizer: doubleTapGestureRecognizer];
    [self setScrollView: scrollView];
    [self setMinefieldWalkthroughView: minefieldWalkthroughView];
    [self setHelpLabel: helpLabel];
}

#pragma mark - Gesture Recognizer Method

- (void) doubleTap
{
    CGPoint tapLocation = [self.doubleTapGestureRecognizer locationInView: [self scrollView]];
    [self.scrollView zoomToPoint: tapLocation withScale: [self.scrollView maximumZoomScale] animated: YES];
}

#pragma mark - UIScrollViewDelegate Methods

- (void) scrollViewDidZoom: (UIScrollView *) scrollView
{
    NSLog(@"scrollViewDidZoom");
    
    CGFloat offsetX = MAX((scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5, 0.0);
    CGFloat offsetY = MAX((scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5, 0.0);
    
    [self.minefieldWalkthroughView setCenter: CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                               scrollView.contentSize.height * 0.5 + offsetY)];
    
}

- (void) scrollViewDidEndZooming: (UIScrollView *) scrollView withView: (UIView *) view atScale: (CGFloat) scale
{
    NSLog(@"viewForZoomingInScrollView");
    if ([scrollView zoomScale] >= [scrollView minimumZoomScale] * 3/2)
    {
        [UIView transitionWithView: scrollView
                          duration: 0.4f
                           options: UIViewAnimationOptionCurveEaseInOut
                        animations: ^{
                            [scrollView setZoomScale: 1.0f];
                        }
                        completion: ^(BOOL finished) {
                            [self.minefieldWalkthroughView setUserInteractionEnabled: YES];
                            [self.doubleTapGestureRecognizer setEnabled: NO];
                        }];
    }
    else
    {
        [UIView transitionWithView: scrollView
                          duration: 0.4f
                           options: UIViewAnimationOptionCurveEaseInOut
                        animations: ^{
                            [scrollView setZoomScale: [scrollView minimumZoomScale]];
                        }
                        completion: ^(BOOL finished) {
                            [self.minefieldWalkthroughView setUserInteractionEnabled: NO];
                            [self.doubleTapGestureRecognizer setEnabled: YES];
                        }];
    }
    
}

- (void) scrollViewDidScroll: (UIScrollView *) scrollView
{
    if (![scrollView isDragging]) return;
}

- (UIView *) viewForZoomingInScrollView: (UIScrollView *) scrollView
{
    return [self minefieldWalkthroughView];
}

@end
