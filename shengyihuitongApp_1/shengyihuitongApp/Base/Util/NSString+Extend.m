//
//  NSString+Extend.m
//  MallApp
//
//  Created by mac on 2020/1/4.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "NSString+Extend.h"



@implementation NSString (Extend)

/**
 *  计算文字的Size大小
 *
 *  @param text    文字内容
 *  @param font    文字字体
 *  @param maxSize 文字最大尺寸
 */
+(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    if([text isKindOfClass:[NSNull class]]){
        text = @"";
    }
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

@end
