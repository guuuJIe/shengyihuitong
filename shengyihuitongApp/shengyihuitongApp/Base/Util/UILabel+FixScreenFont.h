//
//  UILabel+FixScreenFont.h
//  MallApp
//
//  Created by Mac on 2020/1/14.
//  Copyright © 2020 Mac. All rights reserved.
//




#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (FixScreenFont)
@property (nonatomic)IBInspectable float fixWidthScreenFont;

/**
 *  改变行间距
 */
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;
@end

NS_ASSUME_NONNULL_END
