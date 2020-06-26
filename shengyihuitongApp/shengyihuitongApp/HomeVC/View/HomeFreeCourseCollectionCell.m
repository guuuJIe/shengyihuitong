//
//  HomeFreeCourseCollectionCell.m
//  shengyihuitongApp
//
//  Created by mac on 2020/6/23.
//  Copyright © 2020 mac. All rights reserved.
//

#import "HomeFreeCourseCollectionCell.h"
@interface HomeFreeCourseCollectionCell()
@property (nonatomic, strong) UILabel *goodsTitleLabel;
@property (nonatomic, strong) UIImageView *goodsImageView;
@property (nonatomic, strong) UIButton *timesBtn;
@end

@implementation HomeFreeCourseCollectionCell
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
}

- (void)setupData:(NSDictionary *)dic{
    if (dic) {
        [self.goodsImageView sd_setImageWithURL:URL(dic[@"course_img"])];
        self.goodsTitleLabel.text = dic[@"course_name"];
        [self.timesBtn setTitle:[NSString stringWithFormat:@"%@",dic[@"played"]] forState:0];
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
        _goodsImageView.image = [UIImage imageNamed:@"nav_zyys"];
//        _goodsImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _goodsImageView;
}
@end
