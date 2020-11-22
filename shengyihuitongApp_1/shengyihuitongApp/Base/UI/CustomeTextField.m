//
//  CustomeTextField.m
//  MallApp
//
//  Created by mac on 2020/3/20.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "CustomeTextField.h"

@implementation CustomeTextField

- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    if (@available(iOS 13.0, *)) {
        
        self.attributedPlaceholder=[[NSAttributedString alloc]initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName:placeholderColor}];

      
    }else{
        [self setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
    }
    
}

@end
