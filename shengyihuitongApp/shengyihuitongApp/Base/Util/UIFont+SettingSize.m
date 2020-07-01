//
//  UIFont+SettingSize.m
//  MallApp
//
//  Created by Mac on 2020/1/14.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "UIFont+SettingSize.h"




@implementation UIFont (SettingSize)
+(void)load{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        //获取替换后的类方法
//        Method newMethod = class_getClassMethod([self class], @selector(adjustFont:));
//        //获取替换前的类方法
//        Method method = class_getClassMethod([self class], @selector(systemFontOfSize:));
//        //然后交换类方法
//        method_exchangeImplementations(newMethod, method);
//    });
    
    
}

//针对5s设置字体
+(UIFont *)adjustFont:(CGFloat)fontSize{
    
    UIFont *newFont = nil;
    NSString *phone = [XJUtil getCurrentDeviceModel];
//    JLog(@"%@",phone);
    if ([phone isEqualToString:@"iPhone 5S"]){
        newFont = [UIFont adjustFont:fontSize - IPHONE5_INCREMENT];
    }else{
        newFont = [UIFont adjustFont:fontSize];
    }
    return newFont;
}

//+(UIFont *)adjustFont:(CGFloat)fontSize{
////
//    UIFont *newFont = nil;
//    if (IS_IPHONE_5 || IS_IPHONE_4){
//        newFont = [UIFont adjustFont:fontSize - IPHONE5_INCREMENT];
//    }else if (IS_IPHONE_6_PLUS){
//        newFont = [UIFont adjustFont:fontSize + IPHONE6PLUS_INCREMENT];
//    }else{
//        newFont = [UIFont adjustFont:fontSize];
//    }
//    return newFont;
//}
@end
