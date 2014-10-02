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
