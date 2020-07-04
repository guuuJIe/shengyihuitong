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

+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}

- (float )fixWidthScreenFont{
    return self.fixWidthScreenFont;
}
@end
