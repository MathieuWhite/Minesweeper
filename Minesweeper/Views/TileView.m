//
//  TileView.m
//  Minesweeper
//
//  Created by Mathieu White on 2014-10-02.
//  Copyright (c) 2014 Mathieu White. All rights reserved.
//

#import "TileView.h"

@interface TileView()

@end

@implementation TileView

#pragma mark - UIView Methods

- (instancetype) initWithFrame: (CGRect) frame
{
    self = [super initWithFrame: frame];
    
    if (self)
    {
        [self initTile];
    }
    
    return self;
}

#pragma mark - Object Methods

- (void) initTile
{
    [self setBackgroundColor: [UIColor grayColor]];
}

@end