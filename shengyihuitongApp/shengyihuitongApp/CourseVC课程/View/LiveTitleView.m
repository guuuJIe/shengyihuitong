//
//  LiveTitleView.m
//  shengyihuitongApp
//
//  Created by Mac on 2020/6/25.
//  Copyright © 2020 温州轩捷贸易有限公司. All rights reserved.
//

#import "LiveTitleView.h"

@implementation LiveTitleView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
      
        [self setupUI];
       
    }
    return self;
}

- (void)setupUI{
    
//    UIView *view = [UIView new];
//    view.backgroundColor = UIColorF5F7;
//    [self addSubview:view];
//    [view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.mas_equalTo(self);
//        make.height.mas_equalTo(10);
//    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(15);
    }];
    
    
}



-(UILabel *)titleLabel
{
    if(!_titleLabel)
    {
        
        _titleLabel = [UILabel commonLabelWithtext:@"最新直播" color:UIColor999 font:LabelFont14 textAlignment:NSTextAlignmentCenter];

        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

@end
