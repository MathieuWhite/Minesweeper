//
//  Tile.h
//  Minesweeper
//
//  Created by Mathieu White on 2014-10-02.
//  Copyright (c) 2014 Mathieu White. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tile : NSObject

@property (nonatomic, getter = isMine) BOOL mine;
@property (nonatomic, getter = isRevealed) BOOL revealed;
@property (nonatomic, getter = isFlagged) BOOL flagged;
@property (nonatomic) NSInteger adjacentMines;

- (id) init;

@end
