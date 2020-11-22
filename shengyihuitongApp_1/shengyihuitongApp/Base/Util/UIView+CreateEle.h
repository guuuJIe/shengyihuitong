//
//  UIView+CreateEle.h
//  MallApp
//
//  Created by Mac on 2020/1/12.
//  Copyright © 2020 Mac. All rights reserved.
//




#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CreateEle)
+ (UILabel *)commonLabelWithtext:(NSString*)text
        color:(UIColor*)color
         font:(UIFont*)font
                   textAlignment:(NSTextAlignment)textAlignment;
@end

NS_ASSUME_NONNULL_END
