//
//  HowToViewController.m
//  Minesweeper
//
//  Created by Mathieu White on 2014-10-07.
//  Copyright (c) 2014 Mathieu White. All rights reserved.
//

#import "HowToViewController.h"

@interface HowToViewController ()

@end

@implementation HowToViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set the background color
    [self.view setBackgroundColor: [UIColor colorWithRed: 46.0f/255.0f green: 46.0f/255.0f blue: 59.0f/255.0f alpha: 1.0f]];
    
    // Close Button
    UIButton *closeButton = [UIButton buttonWithType: UIButtonTypeSystem];
    [closeButton setFrame: CGRectMake(self.view.center.x - 22, self.view.frame.size.height - 64, 44, 44)];
    [closeButton setBackgroundImage: [UIImage imageNamed: @"closeButton"] forState: UIControlStateNormal];
    [closeButton setBackgroundImage: [UIImage imageNamed: @"closeButtonPressed"] forState: UIControlStateHighlighted];
    [closeButton addTarget: self action: @selector(closeHowTo) forControlEvents: UIControlEventTouchUpInside];
    
    // Title Label
    UILabel *howToTitle = [[UILabel alloc] initWithFrame: CGRectMake(10, 10, 300, 44)];
    [howToTitle setText: @"How to Play"];
    [howToTitle setTextColor: [UIColor whiteColor]];
    [howToTitle setFont: [UIFont fontWithName: @"HelveticaNeue-Light" size: 22.0f]];
    [howToTitle setTextAlignment: NSTextAlignmentCenter];
    
    // Separator between title and rules
    UIView *separator = [[UIView alloc] initWithFrame: CGRectMake(10, 64, 300, 0.5)];
    [separator setBackgroundColor: [UIColor colorWithRed: 72.0f/255.0f green: 72.0f/255.0f blue: 96.0f/255.0f alpha: 1.0f]];
    
    // Add the components to the view
    [self.view addSubview: closeButton];
    [self.view addSubview: howToTitle];
    [self.view addSubview: separator];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) closeHowTo
{
    [self dismissViewControllerAnimated: YES completion: nil];
}

-(UIImage *) convertViewToImage
{
    UIGraphicsBeginImageContext(self.view.bounds.size);
    [self.view drawViewHierarchyInRect: self.view.bounds afterScreenUpdates: YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
