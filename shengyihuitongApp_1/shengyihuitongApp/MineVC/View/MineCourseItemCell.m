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
        make.size.mas_equalTo(CGSizeMake(100*AdapterScal, 65*AdapterScal));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.coverImage.mas_right).offset(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.coverImage);
    }];
    
    [self.priceLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.bottom.mas_equalTo(-11);
    }];
    
    
    [self.contentView addSubview:self.timesBtn];
    [self.timesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(self.priceLbl);
    }];
    
    [self.contentView addSubview:self.downloadBtn];
    [self.downloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.timesBtn);
        make.bottom.mas_equalTo(self.timesBtn.mas_top).offset(2);
    }];
}

- (void)setupData:(NSDictionary *)dic withsizeDic:(NSDictionary *)sizedic{
    if (dic) {
        NSString *image = dic[@"course_img"];
        [self.coverImage sd_setImageWithURL:URL(image)];
        self.titleLabel.text = dic[@"course_name"];
        self.priceLbl.text = dic[@"user_price"];
        [self.timesBtn setTitle:[NSString stringWithFormat:@"%@",dic[@"played"]] forState:0];
//        CGFloat hegit = [sizedic[@"height"] floatValue];
//        CGFloat width = [sizedic[@"width"] floatValue];
//        if (hegit>width) {
//            self.coverImage.contentMode = UIViewContentModeScaleToFill;
//        }else if (width>hegit){
//             self.coverImage.contentMode = UIViewContentModeScaleAspectFit;//W>H
//        }
    }
}
- (void)setupData:(NSDictionary *)dic{
    if (dic) {
        NSString *image = dic[@"course_img"];
        [self.coverImage sd_setImageWithURL:URL(image)];
        self.titleLabel.text = dic[@"course_name"];
        self.priceLbl.text = dic[@"user_price"];
        [self.timesBtn setTitle:[NSString stringWithFormat:@"%@",dic[@"played"]] forState:0];
//        CGFloat hegit = [sizedic[@"height"] floatValue];
//        CGFloat width = [sizedic[@"width"] floatValue];
//        if (hegit>width) {
//            self.coverImage.contentMode = UIViewContentModeScaleAspectFit;//正方形
//        }else if (width>hegit){
//             self.coverImage.contentMode = UIViewContentModeCenter;//W>H
//        }
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
        _coverImage.contentMode = UIViewContentModeScaleAspectFill;//W>H
        _coverImage.clipsToBounds = true;
        [_coverImage setContentScaleFactor:[UIScreen mainScreen].scale];
//        _coverImage.contentMode = UIViewContentModeScaleToFill;//H>w
//        _coverImage.backgroundColor = UIColor.redColor;
        [self.contentView addSubview:_coverImage];
    }
    
    return _coverImage;
}

-(UILabel *)titleLabel
{
    if(!_titleLabel)
    {
        
        _titleLabel = [UILabel commonLabelWithtext:@"标题" color:UIColor333 font:LabelFont13 textAlignment:NSTextAlignmentLeft];
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
        [_downloadBtn.titleLabel setFont:LabelFont13];
    }
    
    return _downloadBtn;
}


@end
