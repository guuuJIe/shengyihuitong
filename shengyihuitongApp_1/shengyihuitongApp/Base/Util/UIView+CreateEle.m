//
//  UIView+CreateEle.m
//  MallApp
//
//  Created by Mac on 2020/1/12.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "UIView+CreateEle.h"




@implementation UIView (CreateEle)

+ (UILabel *)commonLabelWithtext:(NSString*)text
                            color:(UIColor*)color
                             font:(UIFont*)font
                    textAlignment:(NSTextAlignment)textAlignment
{
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.textColor = color;
    label.font = font;
    label.textAlignment = textAlignment;
//    label.adjustsFontSizeToFitWidth = true;
    label.backgroundColor = [UIColor clearColor];
     
    return label;
}

@end
