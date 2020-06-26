//
//  UIColor+Extend.h
//  RebateApp
//
//  Created by Mac on 2019/11/12.
//  Copyright © 2019 Mac. All rights reserved.
//




#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Extend)
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert andAlpha:(CGFloat)alpha;
@end

NS_ASSUME_NONNULL_END
