//
//  GameViewController.m
//  Minesweeper
//
//  Created by Mathieu White on 2014-10-06.
//  Copyright (c) 2014 Mathieu White. All rights reserved.
//

#import "GameViewController.h"
#import "GameView.h"

@interface GameViewController ()

- (void) userWantsNewGameNotification: (NSNotification *) notification;

@end

@implementation GameViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    // Initialize a Game
    GameView *gameView = [[GameView alloc] initWithFrame: [self.view bounds] difficulty: [self difficulty]];
    
    // Add the components to the view
    [self.view addSubview: gameView];
    
    // Set each component to a property
    [self setGameView: gameView];
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(userWantsNewGameNotification:)
                                                 name: kGameViewDidFinishNewGameNotification
                                               object: nil];
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(userWantsMenuNotification:)
                                                 name: kGameViewToMenuNotification
                                               object: nil];
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver: self
                                                    name: kGameViewDidFinishNewGameNotification
                                                  object: nil];
}
- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Notification Method

- (void) userWantsMenuNotification: (NSNotification *) notification
{
    CATransition* transition = [CATransition animation];
    transition.duration = 0.4f;
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromBottom;
    
    [self.navigationController.view.layer addAnimation: transition
                                                forKey: kCATransition];
    
    [self.navigationController popViewControllerAnimated: NO];
}

- (void) userWantsNewGameNotification: (NSNotification *) notification
{
    [[self gameView] removeFromSuperview];
    
    // Re create the game view
    GameView *gameView = [[GameView alloc] initWithFrame: [self.view bounds] difficulty: [self difficulty]];
    
    [self.view addSubview: gameView];
    [self setGameView: gameView];
}

@end
