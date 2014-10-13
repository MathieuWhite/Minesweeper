//
//  HowToViewController.m
//  Minesweeper
//
//  Created by Mathieu White on 2014-10-07.
//  Copyright (c) 2014 Mathieu White. All rights reserved.
//

#import "HowToViewController.h"
#import "DemoGameViewFlag.h"
#import "DemoGameViewNormal.h"
#import "DemoMinefieldView.h"
#import "DemoEnjoy.h"

@interface HowToViewController ()

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIPageControl *pageControl;

@property (nonatomic, strong) NSMutableArray *demoViews;

@end

@implementation HowToViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set the background color
    [self.view setBackgroundColor: [UIColor colorWithRed: 46.0f/255.0f green: 46.0f/255.0f blue: 59.0f/255.0f alpha: 1.0f]];
    
    // Title Label
    UILabel *howToTitle = [[UILabel alloc] initWithFrame: CGRectMake(10, 10, 300, 44)];
    [howToTitle setText: @"How to Play"];
    [howToTitle setTextColor: [UIColor whiteColor]];
    [howToTitle setFont: [UIFont fontWithName: @"HelveticaNeue-Light" size: 22.0f]];
    [howToTitle setTextAlignment: NSTextAlignmentCenter];
    
    // Separator between title and rules
    UIView *separator = [[UIView alloc] initWithFrame: CGRectMake(10, 64, 300, 0.5)];
    [separator setBackgroundColor: [UIColor colorWithRed: 72.0f/255.0f green: 72.0f/255.0f blue: 96.0f/255.0f alpha: 1.0f]];
    
    // Normal walkthrough
    DemoGameViewNormal *demoGameViewNormal = [[DemoGameViewNormal alloc] initWithFrame: [self.view bounds]];
    
    // Flag walkthrough
    DemoGameViewFlag *demoGameViewFlag = [[DemoGameViewFlag alloc] initWithFrame: [self.view bounds]];
    
    // Swipe Walkthrough
    DemoMinefieldView *demoMinefieldViewSwipe = [[DemoMinefieldView alloc] initWithFrame: [self.view bounds]];
    [demoMinefieldViewSwipe.helpLabel setText: @"Swipe to pan across the minefield"];
    
    // Zoom Walkthrough
    DemoMinefieldView *demoMinefieldViewZoom = [[DemoMinefieldView alloc] initWithFrame: [self.view bounds]];
    [demoMinefieldViewZoom.helpLabel setText: @"Pinch to zoom the minefield in or out"];
    
    // Enjoy View
    DemoEnjoy *demoEnjoy = [[DemoEnjoy alloc] initWithFrame: [self.view bounds]];
    
    // Initialize the the demo views array
    NSMutableArray *demoViews = [NSMutableArray arrayWithCapacity: 5];
    [demoViews addObject: demoGameViewNormal];
    [demoViews addObject: demoGameViewFlag];
    [demoViews addObject: demoMinefieldViewSwipe];
    [demoViews addObject: demoMinefieldViewZoom];
    [demoViews addObject: demoEnjoy];

    // Initialize the scroll view
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame: [self.view bounds]];
    [scrollView setMinimumZoomScale: 1.0f];
    [scrollView setMaximumZoomScale: 1.0f];
    [scrollView setShowsHorizontalScrollIndicator: NO];
    [scrollView setShowsVerticalScrollIndicator: NO];
    [scrollView setScrollEnabled: YES];
    [scrollView setPagingEnabled: YES];
    [scrollView setDelegate: self];
    
    // Initialize the page control
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame: CGRectMake(0, 0, 320, 20)];
    [pageControl setCenter: CGPointMake(self.view.center.x, self.view.frame.size.height - 32)];
    [pageControl setCurrentPage: 0];
    [pageControl setNumberOfPages: [demoViews count]];
    [pageControl setPageIndicatorTintColor: [separator backgroundColor]];
    
    // Add the components to the view
    [self.view addSubview: howToTitle];
    [self.view addSubview: separator];
    [self.view addSubview: pageControl];
    [self.view addSubview: scrollView];
    
    // Set each component to a property
    [self setDemoViews: demoViews];
    [self setScrollView: scrollView];
    [self setPageControl: pageControl];
}

- (void)viewWillAppear: (BOOL) animated
{
    [super viewWillAppear: animated];
    
    CGSize pagesScrollViewSize = self.scrollView.frame.size;
    [self.scrollView setContentSize: CGSizeMake(pagesScrollViewSize.width * [self.demoViews count], pagesScrollViewSize.height)];
    
    [self loadVisibleDemos];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) closeHowTo
{
    [self dismissViewControllerAnimated: YES completion: nil];
}

#pragma mark - Page Control Methods
- (void) loadVisibleDemos
{
    // Determine which demo is currently visible
    CGFloat demoWidth = self.scrollView.frame.size.width;
    NSInteger demo = (NSInteger) floor((self.scrollView.contentOffset.x * 2.0f + demoWidth) / (demoWidth * 2.0f));
    
    // Update the page control
    [self.pageControl setCurrentPage: demo];
    
    // Load the demos
    for (NSUInteger index = 0; index <= [self.demoViews count] - 1; index++)
        [self loadDemo: index];
}

- (void) loadDemo: (NSInteger) demo
{
    // Make sure the demo requested exists
    if (demo < 0 || demo >= [self.demoViews count])
        return;
    
    CGRect frame = [self.scrollView bounds];
    frame.origin.x = frame.size.width * demo;
    frame.origin.y = 0;
        
    UIView *newDemoView = [self.demoViews objectAtIndex: demo];
    [newDemoView setContentMode: UIViewContentModeScaleAspectFill];
    [newDemoView setFrame: frame];
    [self.scrollView addSubview: newDemoView];
        
    [self.demoViews replaceObjectAtIndex: demo withObject: newDemoView];
}

# pragma mark - UIScrollViewDelegate Methods

- (void) scrollViewDidScroll: (UIScrollView *) scrollView
{
    [self loadVisibleDemos];
    
    if ([self.pageControl currentPage] == [self.demoViews count] - 1)
    {
        // Close Button
        UIButton *closeButton = [UIButton buttonWithType: UIButtonTypeSystem];
        [closeButton setFrame: CGRectMake(self.view.center.x - 22, self.view.frame.size.height - 64, 44, 44)];
        [closeButton setBackgroundImage: [UIImage imageNamed: @"closeButton"] forState: UIControlStateNormal];
        [closeButton setBackgroundImage: [UIImage imageNamed: @"closeButtonPressed"] forState: UIControlStateHighlighted];
        [closeButton addTarget: self action: @selector(closeHowTo) forControlEvents: UIControlEventTouchUpInside];
        [closeButton setAlpha: 0.0f];
        [self.view addSubview: closeButton];
        
        [UIView transitionWithView: closeButton
                          duration: 0.6f
                           options: UIViewAnimationOptionCurveEaseInOut
                        animations: ^{
                            [closeButton setAlpha: 1.0f];
                            [self.pageControl setAlpha: 0.0f];
                        }
                        completion: ^(BOOL finished){
                            [self.scrollView setUserInteractionEnabled: NO];
                            [self.pageControl removeFromSuperview];
                        }];
    }
}

@end
