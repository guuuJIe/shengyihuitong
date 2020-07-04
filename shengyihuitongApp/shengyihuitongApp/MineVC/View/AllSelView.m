//
//  AllSelView.m
//  shengyihuitongApp
//
//  Created by mac on 2020/6/29.
//  Copyright © 2020 mac. All rights reserved.
//

#import "AllSelView.h"
@interface AllSelView()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIButton *selBtn;
@property (nonatomic, strong) UIButton *downBtn;
@end

@implementation AllSelView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        [self setupUI];
    }
    
    return self;
}
- (void)setupUI{
    
    [self.selBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.selBtn);
        make.left.mas_equalTo(self.selBtn.mas_right).offset(12);
    }];
    
    [self.downBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.mas_equalTo(self);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(50);
    }];
}




- (void)clickAct:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    if (self.clickRowBlock) {
        self.clickRowBlock(sender.selected);
    }
}

- (void)downAct{
    if (self.downloadBlock) {
        self.downloadBlock();
    }
}

-(UILabel *)titleLabel
{
    if(!_titleLabel)
    {
        _titleLabel = [UILabel commonLabelWithtext:@"全选" color:UIColor333 font:LabelFont15 textAlignment:NSTextAlignmentLeft];
    
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIButton *)selBtn{
    if (!_selBtn) {
        _selBtn = [UIButton new];
        [_selBtn setImage:[UIImage imageNamed:@"unsel"] forState:0];
        [_selBtn setImage:[UIImage imageNamed:@"sel"] forState:UIControlStateSelected];
        [_selBtn addTarget:self action:@selector(clickAct:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_selBtn];
    }
    
    return _selBtn;
}

- (UIButton *)downBtn{
    if (!_downBtn) {
        _downBtn = [UIButton new];
        [_downBtn setTitle:@"下载" forState:0];
        [_downBtn setTitleColor:UIColor.whiteColor forState:0];
        [_downBtn.titleLabel setFont:LabelFont14];
        [_downBtn setBackgroundColor:APPColor];
        [_downBtn addTarget:self action:@selector(downAct) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_downBtn];
    }
    
    return _downBtn;
}
@end
