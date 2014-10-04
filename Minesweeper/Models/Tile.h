//
//  Tile.h
//  Minesweeper
//
//  Created by Mathieu White on 2014-10-02.
//  Copyright (c) 2014 Mathieu White. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tile : NSObject

@property (nonatomic) BOOL isMine;
@property (nonatomic) BOOL isRevealed;
@property (nonatomic) BOOL isFlagged;
@property (nonatomic) NSInteger adjacentMines;

- (id) init;

@end
