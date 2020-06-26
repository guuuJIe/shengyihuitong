//
//  LiveItemCell.m
//  shengyihuitongApp
//
//  Created by Mac on 2020/6/25.
//  Copyright © 2020 温州轩捷贸易有限公司. All rights reserved.
//

#import "LiveItemCell.h"
@interface LiveItemCell()
@property (nonatomic, strong) UILabel *goodsTitleLabel;
@property (nonatomic, strong) UIImageView *goodsImageView;
@property (nonatomic, strong) UIButton *timesBtn;
@property (nonatomic, strong) UILabel *priceLbl;
@end

@implementation LiveItemCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
         self.contentView.backgroundColor = [UIColor whiteColor];
         [self setupLayout];

    }
    return self;
}

- (void)setupLayout
{
    [self.contentView addSubview:self.goodsImageView];
    [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.contentView);
        make.height.mas_equalTo(110);
    }];
    
    [self.contentView addSubview:self.goodsTitleLabel];
    [self.goodsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.goodsImageView);
        make.top.mas_equalTo(self.goodsImageView.mas_bottom).offset(14);
    }];
    
    [self.contentView addSubview:self.timesBtn];
    [self.timesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodsTitleLabel);
        make.bottom.mas_equalTo(-5);
    }];
    
    
    [self.priceLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.timesBtn);
        make.right.mas_equalTo(self.goodsImageView);
    }];
    
    
}

- (void)setupData:(NSDictionary *)dic{
    if (dic) {
        [self.goodsImageView sd_setImageWithURL:URL(dic[@"course_img"])];
        self.goodsTitleLabel.text = dic[@"course_name"];
        [self.timesBtn setTitle:[NSString stringWithFormat:@"%@",dic[@"played"]] forState:0];
        self.priceLbl.text = dic[@"user_price"];
    }
}


-(UILabel *)goodsTitleLabel
{
    if(!_goodsTitleLabel)
    {
        _goodsTitleLabel=[UILabel  new];
        _goodsTitleLabel.font = LabelFont14;
        _goodsTitleLabel.textColor = UIColor999;
        _goodsTitleLabel.numberOfLines = 1;
        _goodsTitleLabel.text = @"执业药师";

    }
    return _goodsTitleLabel;
}

- (UIButton *)timesBtn{
    if (!_timesBtn) {
        _timesBtn = [UIButton new];
        [_timesBtn setTitle:@"192394" forState:0];
        [_timesBtn setTitleColor:UIColor999 forState:0];
        [_timesBtn.titleLabel setFont:LabelFont12];
    }
    
    return _timesBtn;
}
-(UIImageView *)goodsImageView
{
    if(!_goodsImageView)
    {
        _goodsImageView=[UIImageView  new];
//        _goodsImageView.image = [UIImage imageNamed:@"nav_zyys"];
//        _goodsImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _goodsImageView;
}

-(UILabel *)priceLbl
{
    if(!_priceLbl)
    {
        
        _priceLbl = [UILabel commonLabelWithtext:@"880" color:fenseColor font:LabelFont14 textAlignment:NSTextAlignmentCenter];
       
        [self.contentView addSubview:_priceLbl];
    }
    return _priceLbl;
}
@end
