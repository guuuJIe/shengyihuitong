//
//  MineCourseItemCell.m
//  shengyihuitongApp
//
//  Created by Mac on 2020/6/26.
//  Copyright © 2020 mac. All rights reserved.
//

#import "MineCourseItemCell.h"
@interface MineCourseItemCell()
@property (nonatomic, strong) UIImageView *coverImage;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLbl;
@property (nonatomic, strong) UILabel *purchaseLbl;
@property (nonatomic, strong) UIButton *timesBtn;

@property (nonatomic, strong) UIButton *downloadBtn;
@end
@implementation MineCourseItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI{
    
    UIView *line = [UIView new];
    line.backgroundColor = UIColorEF;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.contentView);
        make.height.mas_equalTo(lineHeihgt);
    }];
    
    [self.coverImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(12);
        make.bottom.mas_equalTo(-12);
        make.size.mas_equalTo(CGSizeMake(140, 95));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.coverImage.mas_right).offset(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.coverImage);
    }];
    
    [self.priceLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.bottom.mas_equalTo(self.coverImage);
    }];
    
    
    [self.contentView addSubview:self.timesBtn];
    [self.timesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(self.priceLbl);
    }];
    
    [self.contentView addSubview:self.downloadBtn];
    [self.downloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.timesBtn);
        make.bottom.mas_equalTo(self.timesBtn.mas_top).offset(4);
    }];
}

- (void)setupData:(NSDictionary *)dic{
    if (dic) {
        NSString *image = dic[@"course_img"];
        [self.coverImage sd_setImageWithURL:URL(image)];
        self.titleLabel.text = dic[@"course_name"];
        self.priceLbl.text = dic[@"user_price"];
        [self.timesBtn setTitle:[NSString stringWithFormat:@"%@",dic[@"played"]] forState:0];
    }
}
- (void)downlodAct{
    if (self.itemDownLoadBlock) {
        self.itemDownLoadBlock();
    }
}
-(UIImageView *)coverImage{
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

- (UIButton *)timesBtn{
    if (!_timesBtn) {
        _timesBtn = [UIButton new];
        [_timesBtn setTitle:@"192394" forState:0];
        [_timesBtn setTitleColor:UIColor999 forState:0];
        [_timesBtn setImage:[UIImage imageNamed:@"eye"] forState:0];
        [_timesBtn.titleLabel setFont:LabelFont12];
    }
    
    return _timesBtn;
}

- (UIButton *)downloadBtn{
    if (!_downloadBtn) {
        _downloadBtn = [UIButton new];
        [_downloadBtn setTitle:@"下载课程" forState:0];
        [_downloadBtn setTitleColor:APPColor forState:0];
        [_downloadBtn addTarget:self action:@selector(downlodAct) forControlEvents:UIControlEventTouchUpInside];
//        [_downloadBtnn setImage:[UIImage imageNamed:@"eye"] forState:0];
        [_downloadBtn.titleLabel setFont:LabelFont15];
    }
    
    return _downloadBtn;
}


@end
