//
//  MenuViewController.m
//  Minesweeper
//
//  Created by Mathieu White on 2014-10-06.
//  Copyright (c) 2014 Mathieu White. All rights reserved.
//

#import "MenuViewController.h"
#import "GameViewController.h"

@interface MenuViewController ()

@property (nonatomic, weak) UIImageView *logoImageView;
@property (nonatomic, weak) UIButton *easyDifficultyButton;
@property (nonatomic, weak) UIView *separator;

@property (nonatomic, weak) GameViewController *gameViewController;


- (void) flyToTop: (UIView *) view;
- (void) fadeIn: (UIView *) view delay: (NSTimeInterval) delay;
- (void) fadeOut: (UIView *) view delay: (NSTimeInterval) delay;
+ (UIImage *)imageWithColor:(UIColor *)color;

@end

@implementation MenuViewController

#pragma mark - UIViewController Methods
- (void) viewDidLoad
{
    [super viewDidLoad];
    
    // Set the background color
    [self.view setBackgroundColor: [UIColor colorWithRed: 46.0f/255.0f green: 46.0f/255.0f blue: 59.0f/255.0f alpha: 1.0f]];
    
    // Hide the navigation bar
    [self.navigationController setNavigationBarHidden: YES];
    
    // Initialize the logo
    UIImageView *logoImageView = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"logo"]];
    [logoImageView setFrame: CGRectMake(0, 0, 163, 28.5f)];
    [logoImageView setCenter: [self.view center]];
    
    // Initialize the easy difficulty menu button
    UIButton *easyDifficultyButton = [[UIButton alloc] initWithFrame: CGRectMake(20, 140, 280, 44)];
    [easyDifficultyButton setTitle: @"Easy" forState: UIControlStateNormal];
    [easyDifficultyButton addTarget: self action: @selector(easyDifficultySelected) forControlEvents: UIControlEventTouchUpInside];
    [self styleMenuButton: easyDifficultyButton];
    
    // Initialize the separator
    UIView *separator = [[UIView alloc] initWithFrame: CGRectMake(10, 200, 300, 0.5)];
    [separator setBackgroundColor: [UIColor colorWithRed: 72.0f/255.0f green: 72.0f/255.0f blue: 96.0f/255.0f alpha: 1.0f]];
    
    // Add the components to the view
    [self.view addSubview: logoImageView];
    [self.view addSubview: easyDifficultyButton];
    [self.view addSubview: separator];
    
    // Set each component to a property
    [self setLogoImageView: logoImageView];
    [self setEasyDifficultyButton: easyDifficultyButton];
    [self setSeparator: separator];
    
    // Animations
    [self flyToTop: [self logoImageView]];
    [self fadeIn: [self easyDifficultyButton] delay: 1.4];
    [self fadeIn: [self separator] delay: 1.4];

}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) easyDifficultySelected
{
    NSLog(@"Easy!");
}

- (void) styleMenuButton: (UIButton *) menuButton
{
    [menuButton setBackgroundColor: nil];
    
    [menuButton setTitleColor: [UIColor whiteColor]
                               forState: UIControlStateNormal];
    [menuButton setTitleColor: [UIColor colorWithRed: 46.0f/255.0f green: 46.0f/255.0f blue: 59.0f/255.0f alpha: 1.0f]
                               forState: UIControlStateHighlighted];
    [menuButton setTitle: @"Easy" forState: UIControlStateNormal];
    [menuButton.layer setBorderColor: [UIColor whiteColor].CGColor];
    [menuButton.layer setBorderWidth: 0.5f];
    [menuButton.layer setCornerRadius: 22.0f];
    [menuButton.titleLabel setFont: [UIFont fontWithName: @"HelveticaNeue-Light" size: 18.0f]];
}

#pragma mark - Animation Methods

- (void) flyToTop: (UIView *) view
{
    CGPoint newCenter = [view center];
    newCenter.y = 80;
    
    [UIView animateWithDuration: 1.4
                          delay: 0.4
                        options: (UIViewAnimationCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction)
                     animations: ^{
                         [view setCenter: newCenter];
                     }
                     completion: NULL];
}

- (void) fadeIn: (UIView *) view delay: (NSTimeInterval) delay
{
    [view setAlpha: 0.0f];
    
    [UIView animateWithDuration: 0.6
                          delay: delay
                        options: (UIViewAnimationCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction)
                     animations: ^{
                         [view setAlpha: 1.0f];
                     }
                     completion: NULL];
}

- (void) fadeOut: (UIView *) view delay: (NSTimeInterval) delay
{
    
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end