//
//  UILabel+FixScreenFont.m
//  MallApp
//
//  Created by Mac on 2020/1/14.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "UILabel+FixScreenFont.h"




@implementation UILabel (FixScreenFont)
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
