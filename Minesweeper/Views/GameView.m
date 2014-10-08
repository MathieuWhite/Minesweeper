//
//  GameView.m
//  Minesweeper
//
//  Created by Mathieu White on 2014-10-02.
//  Copyright (c) 2014 Mathieu White. All rights reserved.
//

#import "GameView.h"

@interface GameView() <UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, weak) UILabel *remainingTilesLabel;
@property (nonatomic, weak) UIButton *menuButton;
@property (nonatomic, weak) UIButton *theNewGameButton;

@property (nonatomic, weak) MinefieldView *minefieldView;

@property (nonatomic) MinefieldDifficulty difficulty;

@end

@implementation GameView

#pragma mark - UIView Methods

- (instancetype) initWithFrame: (CGRect) frame difficulty: (MinefieldDifficulty) difficulty
{
    self = [super initWithFrame: frame];
    
    if (self)
    {
        [self setDifficulty: difficulty];
        [self initGameView];
    }
    
    return self;
}

#pragma mark - Object Methods

- (void) initGameView
{
    // Set the background color
    [self setBackgroundColor: [UIColor colorWithRed: 46.0f/255.0f green: 46.0f/255.0f blue: 59.0f/255.0f alpha: 1.0f]];
    
    // Initialize the Minefield
    MinefieldView *minefieldView = [[MinefieldView alloc] initWithDifficulty: [self difficulty]];
    
    // Initialize the scroll view
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame: [self bounds]];
    [scrollView setContentSize: minefieldView.bounds.size];
    [scrollView setMinimumZoomScale: (scrollView.frame.size.width / minefieldView.frame.size.width)];
    [scrollView setMaximumZoomScale: 1];
    [scrollView setZoomScale: 1];
    [scrollView setContentInset: UIEdgeInsetsMake(64, 0, 0, 0)];
    [scrollView setShowsHorizontalScrollIndicator: NO];
    [scrollView setShowsVerticalScrollIndicator: NO];
    [scrollView setDelegate: self];
    
    // Remaining Tiles Label
    UILabel *remainingTilesLabel = [[UILabel alloc] initWithFrame: CGRectMake(10, 10, 300, 44)];
    [remainingTilesLabel setText: @"Label"];
    [remainingTilesLabel setTextColor: [UIColor whiteColor]];
    [remainingTilesLabel setFont: [UIFont fontWithName: @"HelveticaNeue-Light" size: 22.0f]];
    [remainingTilesLabel setTextAlignment: NSTextAlignmentCenter];
    
    // Menu Button
    UIButton *menuButton = [UIButton buttonWithType: UIButtonTypeSystem];
    [menuButton setFrame: CGRectMake(0, 10, 64, 44)];
    [menuButton setTitle: @"Menu" forState: UIControlStateNormal];
    [menuButton setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
    [menuButton.titleLabel setFont: [UIFont fontWithName: @"HelveticaNeue-Light" size: 14.0f]];
    [menuButton addTarget: self action: @selector(userWantsMainMenu) forControlEvents: UIControlEventTouchUpInside];
    
    // New Game Button
    UIButton *theNewGameButton = [UIButton buttonWithType: UIButtonTypeSystem];
    [theNewGameButton setFrame: CGRectMake(self.frame.size.width - 90, 10, 80, 44)];
    [theNewGameButton setTitle: @"New Game" forState: UIControlStateNormal];
    [theNewGameButton setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
    [theNewGameButton.titleLabel setFont: [UIFont fontWithName: @"HelveticaNeue-Light" size: 14.0f]];
    [theNewGameButton addTarget: self action: @selector(userWantsNewGame) forControlEvents: UIControlEventTouchUpInside];
    
    // Add the components to the scroll view
    [scrollView addSubview: minefieldView];
    
    // Add the components to the view
    [self addSubview: remainingTilesLabel];
    [self addSubview: menuButton];
    [self addSubview: theNewGameButton];
    [self addSubview: scrollView];
    
    // Set each component to a property
    [self setScrollView: scrollView];
    [self setMinefieldView: minefieldView];
    [self setRemainingTilesLabel: remainingTilesLabel];
    [self setMenuButton: menuButton];
    [self setTheNewGameButton: theNewGameButton];
}

- (void) userWantsMainMenu
{
    [[NSNotificationCenter defaultCenter] postNotificationName: kGameViewToMenuNotification object: nil];
}

- (void) userWantsNewGame
{
    [[NSNotificationCenter defaultCenter] postNotificationName: kGameViewDidFinishNewGameNotification object: nil];
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
    if ([scrollView zoomScale] >= [scrollView minimumZoomScale] * 3/2)
    {
        [UIView transitionWithView: scrollView
                          duration: 0.4f
                           options: UIViewAnimationOptionCurveEaseInOut
                        animations: ^{
                            [scrollView setZoomScale: 1.0f];
                            [scrollView setContentInset: UIEdgeInsetsMake(64, 0, 0, 0)];
                        }
                        completion: ^(BOOL finished) {
                            [self.minefieldView setUserInteractionEnabled: YES];
                            [self bringSubviewToFront: scrollView];
                        }];
    }
    else
    {
        [UIView transitionWithView: scrollView
                          duration: 0.4f
                           options: UIViewAnimationOptionCurveEaseInOut
                        animations: ^{
                            [scrollView setZoomScale: [scrollView minimumZoomScale]];
                            [scrollView setContentInset: UIEdgeInsetsMake(0, 0, 0, 0)];
                        }
                        completion: ^(BOOL finished) {
                            [self.minefieldView setUserInteractionEnabled: NO];
                            [self bringSubviewToFront: [self theNewGameButton]];
                            [self bringSubviewToFront: [self menuButton]];
                        }];
    }
        
}

- (void) scrollViewDidScroll: (UIScrollView *) scrollView
{
    if (![scrollView isDragging]) return;
    
    [self bringSubviewToFront: scrollView];
    
    NSLog(@"scrollViewDidScroll");
}

- (void) scrollViewWillEndDragging: (UIScrollView *) scrollView withVelocity: (CGPoint) velocity targetContentOffset: (inout CGPoint *) targetContentOffset
{
    NSLog(@"scrollViewWillEndDragging");
    
    if (targetContentOffset->y >= -32)
    {
        [UIView transitionWithView: [self minefieldView]
                          duration: 0.4f
                           options: UIViewAnimationOptionCurveEaseInOut
                        animations: ^{
                            //targetContentOffset->y = 0.0;
                            [self bringSubviewToFront: scrollView];
                        }
                        completion: NULL];
    }
    else
    {
        [UIView transitionWithView: [self minefieldView]
                          duration: 0.4f
                           options: UIViewAnimationOptionCurveEaseInOut
                        animations: ^{
                            //targetContentOffset->y = -64.0;
                            [self bringSubviewToFront: [self theNewGameButton]];
                            [self bringSubviewToFront: [self menuButton]];
                        }
                        completion: NULL];
    }
    
    NSLog(@"targetContent y: %f", targetContentOffset->y);
    
    NSLog(@"y: %f", scrollView.contentOffset.y);
}

- (UIView *) viewForZoomingInScrollView: (UIScrollView *) scrollView
{
    return [self minefieldView];
}

@end
