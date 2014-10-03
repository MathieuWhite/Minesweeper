//
//  ViewController.m
//  Minesweeper
//
//  Created by Mathieu White on 2014-09-30.
//  Copyright (c) 2014 Mathieu White. All rights reserved.
//

#import "ViewController.h"
#import "GameView.h"

@interface ViewController ()

@property (nonatomic, weak) GameView *gameView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self.view setBackgroundColor: [UIColor colorWithRed: 46.f/255.f green: 46.f/255.f blue: 59.f/255.f alpha: 1.f]];
    
    // Initialize a Game
    GameView *gameView = [[GameView alloc] initWithFrame: [self.view bounds]];
    
    // Add the components to the view
    [self.view addSubview: gameView];
    
    // Set each component to a property
    [self setGameView: gameView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end