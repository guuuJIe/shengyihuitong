//
//  CourseTitleView.m
//  shengyihuitongApp
//
//  Created by Mac on 2020/6/26.
//  Copyright © 2020 mac. All rights reserved.
//

#import "CourseTitleView.h"
@interface CourseTitleView()

@end

@implementation CourseTitleView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI{
    
    
    UIView *line2 = [UIView new];
    line2.backgroundColor = UIColorF5F7;
    [self addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self);
        make.height.mas_equalTo(10);
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = UIColor9BC;
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line2.mas_bottom);
        make.left.bottom.mas_equalTo(self);
        make.width.mas_equalTo(4);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line.mas_right).offset(10);
        make.centerY.mas_equalTo(line);
    }];
}

-(UILabel *)titleLabel
{
    if(!_titleLabel)
    {
        
        _titleLabel = [UILabel commonLabelWithtext:@"课程状况" color:UIColor333 font:LabelFont16 textAlignment:NSTextAlignmentCenter];
        _titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightBold];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

@end
