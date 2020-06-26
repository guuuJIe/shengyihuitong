//
//  JobItemCell.m
//  shengyihuitongApp
//
//  Created by Mac on 2020/6/25.
//  Copyright © 2020 温州轩捷贸易有限公司. All rights reserved.
//

#import "JobItemCell.h"
@interface JobItemCell()
@property (nonatomic, strong) UIImageView *coverImage;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLbl;
@property (nonatomic, strong) UILabel *purchaseLbl;
@property (nonatomic, strong) UIButton *playedBtn;
@end
@implementation JobItemCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        self.contentView.backgroundColor = UIColor.redColor;
        [self setupUI];
    }
    
    return self;
}
- (void)setupUI{
    
    [self.coverImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(150);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.coverImage);
        make.top.mas_equalTo(self.coverImage.mas_bottom).offset(12);
    }];
    
    [self.priceLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(12);
    }];
    
    [self.purchaseLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.coverImage);
        make.centerY.mas_equalTo(self.priceLbl);
    }];
    
    UIView *view = [UIView new];
    view.backgroundColor = UIColorF5F7;
    [self.contentView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(10);
        make.top.mas_equalTo(self.priceLbl.mas_bottom).offset(12);
    }];
}

- (void)setupData:(NSDictionary *)dic{
    if (dic) {
        [self.coverImage sd_setImageWithURL:URL(dic[@"squad_img"])];
        self.titleLabel.text = dic[@"squad_name"];
        self.priceLbl.text = [NSString stringWithFormat:@"%@",dic[@"price"]];
        self.purchaseLbl.text = [NSString stringWithFormat:@"已有%@人购买",dic[@"buyed"]];
    }
}

- (UIImageView *)coverImage{
    if (!_coverImage) {
        _coverImage = [UIImageView new];
//        _coverImage.backgroundColor = UIColor.redColor;
        [self.contentView addSubview:_coverImage];
    }
    
    return _coverImage;
}

-(UILabel *)titleLabel
{
    if(!_titleLabel)
    {
        
        _titleLabel = [UILabel commonLabelWithtext:@"标题" color:UIColor333 font:LabelFont16 textAlignment:NSTextAlignmentLeft];
        _titleLabel.numberOfLines = 2;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}


-(UILabel *)priceLbl
{
    if(!_priceLbl)
    {
        _priceLbl = [UILabel commonLabelWithtext:@"238" color:fenseColor font:LabelFont14 textAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:_priceLbl];
    }
    return _priceLbl;
}

-(UILabel *)purchaseLbl
{
    if(!_purchaseLbl)
    {
        _purchaseLbl = [UILabel commonLabelWithtext:@"已有1人购买" color:fenseColor font:LabelFont14 textAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:_purchaseLbl];
    }
    return _purchaseLbl;
}

@end
