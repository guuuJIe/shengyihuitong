//
//  NSString+Extend.h
//  MallApp
//
//  Created by mac on 2020/1/4.
//  Copyright © 2020 Mac. All rights reserved.
//




#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Extend)
+(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;
@end

NS_ASSUME_NONNULL_END
