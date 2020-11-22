//
//  UITextField+FixScreenfont.m
//  MallApp
//
//  Created by mac on 2020/1/16.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "UITextField+FixScreenfont.h"



@implementation UITextField (FixScreenfont)
-(void)setFixWidthScreenFont:(float)fixWidthScreenFont{
    
    if (fixWidthScreenFont > 0 ) {
        self.font = [UIFont systemFontOfSize:C_WIDTH(fixWidthScreenFont)];
    }else{
        self.font = self.font;
    }
}

- (float )fixWidthScreenFont{
    return self.fixWidthScreenFont;
}
@end
