//
//  FuncItemCell.m
//  shengyihuitongApp
//
//  Created by mac on 2020/6/23.
//  Copyright © 2020 mac. All rights reserved.
//

#import "FuncItemCell.h"
@interface FuncItemCell()

@property (nonatomic , strong) UIImageView *goodsImageView;
@property (nonatomic , strong) UILabel *goodsTitleLabel;

@end
@implementation FuncItemCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//         self.contentView.backgroundColor = UIColor.purpleColor;
         [self setupLayout];

    }
    return self;
}

- (void)setupLayout
{
    [self addSubview:self.goodsTitleLabel];
    [self addSubview:self.goodsImageView];
    [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.mas_equalTo(15*AdapterScal);
        make.size.mas_equalTo(CGSizeMake(40*AdapterScal, 40*AdapterScal));
    }];
    
    [self.goodsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goodsImageView.mas_bottom).offset(10*AdapterScal);
        make.centerX.equalTo(self);
    }];
}

- (void)setupData:(NSDictionary *)dic{
    self.goodsImageView.image = [UIImage imageNamed:dic[@"image"]];
    self.goodsTitleLabel.text = dic[@"name"];
}

-(UILabel *)goodsTitleLabel
{
    if(!_goodsTitleLabel)
    {
        _goodsTitleLabel=[UILabel  new];
        _goodsTitleLabel.font = LabelFont12;
        _goodsTitleLabel.textColor = [UIColor colorWithHexString:@"666666"];
        _goodsTitleLabel.numberOfLines = 1;
        _goodsTitleLabel.text = @"执业药师";

    }
    return _goodsTitleLabel;
}
-(UIImageView *)goodsImageView
{
    if(!_goodsImageView)
    {
        _goodsImageView=[UIImageView  new];
        _goodsImageView.image = [UIImage imageNamed:@"nav_zyys"];
//        _goodsImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _goodsImageView;
}

@end
