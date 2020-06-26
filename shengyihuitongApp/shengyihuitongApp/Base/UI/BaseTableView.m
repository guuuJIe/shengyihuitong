//
//  BaseTableView.m
//  MallApp
//
//  Created by Mac on 2020/3/15.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView

/**
 同时识别多个手势

 @param gestureRecognizer gestureRecognizer description
 @param otherGestureRecognizer otherGestureRecognizer description
 @return return value description
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
@end
