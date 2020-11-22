//
//  HomeFreeCourseCollectionCell.m
//  shengyihuitongApp
//
//  Created by mac on 2020/6/23.
//  Copyright © 2020 mac. All rights reserved.
//

#import "HomeFreeCourseCollectionCell.h"
#import "JZLStarView.h"
@interface HomeFreeCourseCollectionCell()
@property (nonatomic, strong) UILabel *goodsTitleLabel;
@property (nonatomic, strong) UIImageView *goodsImageView;
@property (nonatomic, strong) UIButton *timesBtn;
@property (nonatomic, strong) JZLStarView *ratingBar;
@property (nonatomic, strong) UILabel *priceLbl;
@property (nonatomic, strong) UIButton *freeBtn;
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
        make.top.mas_equalTo(self.goodsImageView.mas_bottom).offset(10);
    }];
    
    [self.contentView addSubview:self.timesBtn];
    [self.timesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodsTitleLabel);
        make.bottom.mas_equalTo(-5);
    }];
    [self.contentView addSubview:self.ratingBar];
    
    
    
    [self.priceLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.centerY.mas_equalTo(self.timesBtn);
    }];
    
    [self.contentView addSubview:self.freeBtn];
    [self.freeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.goodsImageView).offset(-1);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
    
    
}

- (void)setupData:(NSDictionary *)dic{
    if (dic) {
        [self.goodsImageView sd_setImageWithURL:URL(dic[@"course_img"])];
        self.goodsTitleLabel.text = dic[@"course_name"];
        [self.timesBtn setTitle:[NSString stringWithFormat:@"%@",dic[@"played"]] forState:0];
        self.priceLbl.text = [NSString stringWithFormat:@"%@",dic[@"user_price"]];
        self.freeBtn.hidden = true;
    }
}

- (void)setupfreeData:(NSDictionary *)dic{
    if (dic) {
        [self.goodsImageView sd_setImageWithURL:URL(dic[@"course_img"])];
        self.goodsTitleLabel.text = dic[@"course_name"];
        [self.timesBtn setTitle:[NSString stringWithFormat:@"%@",dic[@"played"]] forState:0];
        self.priceLbl.text = [NSString stringWithFormat:@"%@",dic[@"user_price"]];
        self.freeBtn.hidden = false;
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
        [_timesBtn setImage:[UIImage imageNamed:@"eye"] forState:0];
        [_timesBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -2, 0, 0)];
//        [_timesBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 3)];
        [_timesBtn.titleLabel setFont:LabelFont12];
    }
    
    return _timesBtn;
}
-(UIImageView *)goodsImageView{
    if (!_goodsImageView) {
        _goodsImageView = [UIImageView new];
        _goodsImageView.contentMode = UIViewContentModeScaleAspectFill;//W>H
        _goodsImageView.clipsToBounds = true;
        [_goodsImageView setContentScaleFactor:[UIScreen mainScreen].scale];
//        _coverImage.contentMode = UIViewContentModeScaleToFill;//H>w
//        _coverImage.backgroundColor = UIColor.redColor;
        [self.contentView addSubview:_goodsImageView];
    }
    
    return _goodsImageView;
}

- (JZLStarView *)ratingBar{
    if (!_ratingBar) {
        _ratingBar = [[JZLStarView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 50, 60, 20) starCount:5 starStyle:WholeStar isAllowScroe:NO];
//        _ratingBar.currentScore = 3.2;
         
    }
    
    return _ratingBar;
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

- (UIButton *)freeBtn{
    if (!_freeBtn) {
        _freeBtn = [UIButton new];
        [_freeBtn setImage:[UIImage imageNamed:@"free"] forState:0];
    }
    
    return _freeBtn;
}
@end
