//
//  NSLayoutConstraint+IBDesignable.m
//  MallApp
//
//  Created by mac on 2020/3/12.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "NSLayoutConstraint+IBDesignable.h"



@implementation NSLayoutConstraint (IBDesignable)
- (void)setAdapterScreen:(BOOL)adapterScreen{
    
    if (adapterScreen){
        self.constant = self.constant * KsuitParam;
    }
}

- (BOOL)adapterScreen{
    return YES;
}

@end
