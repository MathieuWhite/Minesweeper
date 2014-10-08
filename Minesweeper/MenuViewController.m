//
//  MenuViewController.m
//  Minesweeper
//
//  Created by Mathieu White on 2014-10-06.
//  Copyright (c) 2014 Mathieu White. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "MenuViewController.h"
#import "GameViewController.h"
#import "HowToViewController.h"

@interface MenuViewController ()

@property (nonatomic, weak) UIImageView *logoImageView;
@property (nonatomic, weak) UIButton *easyDifficultyButton;
@property (nonatomic, weak) UIButton *mediumDifficultyButton;
@property (nonatomic, weak) UIButton *hardDifficultyButton;
@property (nonatomic, weak) UIButton *howToPlayButton;

@property (nonatomic, weak) UIView *separator;

@property (nonatomic, weak) GameViewController *gameViewController;

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
    
    // Initialize the choose your difficulty label
    UILabel *chooseDifficultyLabel = [[UILabel alloc] initWithFrame: CGRectMake(20, 116, 280, 44)];
    [chooseDifficultyLabel setFont: [UIFont fontWithName: @"HelveticaNeue-Light" size: 14.0f]];
    [chooseDifficultyLabel setTextColor: [UIColor whiteColor]];
    [chooseDifficultyLabel setText:@"Choose Your Difficulty"];
    
    // Initialize the easy difficulty menu button
    UIButton *easyDifficultyButton = [[UIButton alloc] initWithFrame: CGRectMake(20, 160, 280, 44)];
    [easyDifficultyButton setTitle: @"Easy" forState: UIControlStateNormal];
    [easyDifficultyButton addTarget: self action: @selector(easyDifficultySelected) forControlEvents: UIControlEventTouchUpInside];
    [self styleMenuButton: easyDifficultyButton];
    
    // Initialize the medium difficulty menu button
    UIButton *mediumDifficultyButton = [[UIButton alloc] initWithFrame: CGRectMake(20, 214, 280, 44)];
    [mediumDifficultyButton setTitle: @"Medium" forState: UIControlStateNormal];
    [mediumDifficultyButton addTarget: self action: @selector(mediumDifficultySelected) forControlEvents: UIControlEventTouchUpInside];
    [self styleMenuButton: mediumDifficultyButton];
    
    // Initialize the hard difficulty menu button
    UIButton *hardDifficultyButton = [[UIButton alloc] initWithFrame: CGRectMake(20, 268, 280, 44)];
    [hardDifficultyButton setTitle: @"Hard" forState: UIControlStateNormal];
    [hardDifficultyButton addTarget: self action: @selector(hardDifficultySelected) forControlEvents: UIControlEventTouchUpInside];
    [self styleMenuButton: hardDifficultyButton];
    
    // Initialize the separator
    UIView *separator = [[UIView alloc] initWithFrame: CGRectMake(10, 332, 300, 0.5)];
    [separator setBackgroundColor: [UIColor colorWithRed: 72.0f/255.0f green: 72.0f/255.0f blue: 96.0f/255.0f alpha: 1.0f]];
    
    // Initialize the how to play button
    UIButton *howToPlayButton = [[UIButton alloc] initWithFrame: CGRectMake(20, 352, 280, 44)];
    [howToPlayButton setTitle: @"How to Play" forState: UIControlStateNormal];
    [howToPlayButton addTarget: self action: @selector(howToPlaySelected) forControlEvents: UIControlEventTouchUpInside];
    [self styleMenuButton: howToPlayButton];
    
    // Add the components to the view
    [self.view addSubview: logoImageView];
    [self.view addSubview: chooseDifficultyLabel];
    [self.view addSubview: easyDifficultyButton];
    [self.view addSubview: mediumDifficultyButton];
    [self.view addSubview: hardDifficultyButton];
    [self.view addSubview: separator];
    [self.view addSubview: howToPlayButton];
    
    // Set each component to a property
    [self setLogoImageView: logoImageView];
    [self setEasyDifficultyButton: easyDifficultyButton];
    [self setMediumDifficultyButton: mediumDifficultyButton];
    [self setHardDifficultyButton: hardDifficultyButton];
    [self setSeparator: separator];
    [self setHowToPlayButton: howToPlayButton];
    
    // Animations
    [self flyToTop: [self logoImageView]];
    [self fadeIn: chooseDifficultyLabel delay: 1.4];
    [self fadeIn: [self easyDifficultyButton] delay: 1.4];
    [self fadeIn: [self mediumDifficultyButton] delay: 1.4];
    [self fadeIn: [self hardDifficultyButton] delay: 1.4];
    [self fadeIn: [self separator] delay: 1.4];
    [self fadeIn: [self howToPlayButton] delay: 1.4];

}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - Button Methods

- (void) easyDifficultySelected
{
    NSLog(@"Easy!");
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.4f;
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromTop;
    
    [self.navigationController.view.layer addAnimation: transition
                                                forKey: kCATransition];
    
    GameViewController *gameViewController = [[GameViewController alloc] init];
    [gameViewController setDifficulty: MinefieldDifficultyEasy];
    
    [self.navigationController pushViewController: gameViewController animated: NO];    
}

- (void) mediumDifficultySelected
{
    NSLog(@"Medium!");
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.4f;
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromTop;
    
    [self.navigationController.view.layer addAnimation: transition
                                                forKey: kCATransition];
    
    GameViewController *gameViewController = [[GameViewController alloc] init];
    [gameViewController setDifficulty: MinefieldDifficultyMedium];
    
    [self.navigationController pushViewController: gameViewController animated: NO];
}

- (void) hardDifficultySelected
{
    NSLog(@"Hard!");
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.4f;
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromTop;
    
    [self.navigationController.view.layer addAnimation: transition
                                                forKey: kCATransition];
    
    GameViewController *gameViewController = [[GameViewController alloc] init];
    [gameViewController setDifficulty: MinefieldDifficultyHard];
    
    [self.navigationController pushViewController: gameViewController animated: NO];
}

- (void) howToPlaySelected
{
    NSLog(@"How to Play!");
    
    HowToViewController *howToViewController = [[HowToViewController alloc] init];
    [howToViewController setModalPresentationStyle: UIModalPresentationFullScreen];
    [howToViewController setModalTransitionStyle: UIModalTransitionStyleCoverVertical];
    
    [self presentViewController: howToViewController animated: YES completion: nil];
}

- (UIImage *) imageWithColor: (UIColor *) color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

- (void) styleMenuButton: (UIButton *) menuButton
{
    [menuButton setBackgroundColor: nil];
    [menuButton setBackgroundImage: [self imageWithColor: [UIColor whiteColor]] forState: UIControlStateHighlighted];
    
    [menuButton setTitleColor: [UIColor whiteColor]
                               forState: UIControlStateNormal];
    [menuButton setTitleColor: [UIColor colorWithRed: 46.0f/255.0f green: 46.0f/255.0f blue: 59.0f/255.0f alpha: 1.0f]
                               forState: UIControlStateHighlighted];
    [menuButton.layer setBorderColor: [UIColor whiteColor].CGColor];
    [menuButton.layer setBorderWidth: 0.5f];
    //[menuButton.layer setCornerRadius: 22.0f];
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

@end