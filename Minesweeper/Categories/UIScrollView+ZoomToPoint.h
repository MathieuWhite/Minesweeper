//
//  UIScrollView+ZoomToPoint.h
//  Minesweeper
//
//  Created by Mathieu White on 2014-10-07.
//  Copyright (c) 2014 Mathieu White. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (ZoomToPoint)

- (void)zoomToPoint: (CGPoint) zoomPoint withScale: (CGFloat) scale animated: (BOOL) animated;

@end
