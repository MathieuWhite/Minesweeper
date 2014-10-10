//
//  DemoTileView.h
//  Minesweeper
//
//  Created by Mathieu White on 2014-10-09.
//  Copyright (c) 2014 Mathieu White. All rights reserved.
//

#import "TileView.h"

typedef NS_ENUM(NSUInteger, DemoTileViewType)
{
    DemoTileViewTypeNormal,
    DemoTileViewTypeFlag
};

@interface DemoTileView : UIView

- (instancetype) initWithTileViewType: (DemoTileViewType) tileViewType;

- (void) setDarkerTone: (BOOL) darkerTone;

@end
