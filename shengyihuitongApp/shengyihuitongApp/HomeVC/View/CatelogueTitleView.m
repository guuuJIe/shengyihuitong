//
//  CatelogueTitleView.m
//  shengyihuitongApp
//
//  Created by Mac on 2020/6/26.
//  Copyright © 2020 mac. All rights reserved.
//

#import "CatelogueTitleView.h"
@interface CatelogueTitleView()

@end
@implementation CatelogueTitleView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI{
    
    UIView *line = [UIView new];
    line.backgroundColor = UIColorEF;
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self);
        make.height.mas_equalTo(10);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(14);
        make.top.mas_equalTo(line.mas_bottom).offset(14);
    }];
    
//    UIButton *button = [UIButton new];
//    [button setImage:[UIImage imageNamed:@"white_arrow"] forState:0];
//    [self addSubview:button];
//    [button mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(-12);
//        make.centerY.mas_equalTo(self.titleLabel);
//        make.size.mas_equalTo(CGSizeMake(22, 22));
//    }];
}

-(UILabel *)titleLabel
{
    if(!_titleLabel)
    {
        
        _titleLabel = [UILabel commonLabelWithtext:@"标题" color:UIColor333 font:LabelFont16 textAlignment:NSTextAlignmentLeft];
//        _titleLabel.numberOfLines = 2;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}
@end
