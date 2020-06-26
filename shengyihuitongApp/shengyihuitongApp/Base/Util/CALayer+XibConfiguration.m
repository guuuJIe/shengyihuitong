//
//  CALayer+XibConfiguration.m
//  MallApp
//
//  Created by Mac on 2020/2/15.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "CALayer+XibConfiguration.h"


@implementation CALayer (XibConfiguration)
- (void)setBorderUIColor:(UIColor *)color {
    self.borderColor = color.CGColor;
}


- (UIColor*)borderUIColor {
    return [UIColor colorWithCGColor:self.borderColor];
}

@end
