//
//  AllSelView.h
//  shengyihuitongApp
//
//  Created by 温州轩捷贸易有限公司 on 2020/6/29.
//  Copyright © 2020 温州轩捷贸易有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AllSelView : UIView
@property (nonatomic, copy) void (^clickRowBlock)(BOOL isClick);
@property (nonatomic, copy) void (^downloadBlock)(void);
@end

NS_ASSUME_NONNULL_END
