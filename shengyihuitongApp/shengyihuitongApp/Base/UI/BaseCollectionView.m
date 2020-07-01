//
//  BaseCollectionView.m
//  shengyihuitongApp
//
//  Created by 温州轩捷贸易有限公司 on 2020/6/30.
//  Copyright © 2020 温州轩捷贸易有限公司. All rights reserved.
//

#import "BaseCollectionView.h"

@implementation BaseCollectionView

/**
 同时识别多个手势

 @param gestureRecognizer gestureRecognizer description
 @param otherGestureRecognizer otherGestureRecognizer description
 @return return value description
 */
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
//{
//    return YES;
//}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if ([view.superview isMemberOfClass:NSClassFromString(@"PLVDownloadComleteCell")]){
        self.scrollEnabled = NO;
    }else{
        self.scrollEnabled = YES;
    }
    return view;
}

@end
