//
//  CommonView.h
//  shengyihuitongApp
//
//  Created by mac on 2020/6/28.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonView : UIView
@property (nonatomic) UIButton *actButton;
/**
 加
 */
@property (nonatomic, copy) void (^actBlock)(void);
@end

NS_ASSUME_NONNULL_END
