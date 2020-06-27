//
//  MineSquadItemCell.m
//  shengyihuitongApp
//
//  Created by Mac on 2020/6/26.
//  Copyright © 2020 温州轩捷贸易有限公司. All rights reserved.
//

#import "MineSquadItemCell.h"
@interface MineSquadItemCell()
@property (nonatomic, strong) UIImageView *coverImage;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLbl;
@property (nonatomic, strong) UILabel *purchaseLbl;
@property (nonatomic, strong) UIButton *timesBtn;
@end
@implementation MineSquadItemCell

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
        make.bottom.mas_equalTo(self.coverImage).offset(-28);
    }];
    
    
    [self.contentView addSubview:self.timesBtn];
    [self.timesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.priceLbl);
        make.bottom.mas_equalTo(self.coverImage);
        make.right.mas_equalTo(self.contentView);
    }];
}

- (void)setupData:(NSDictionary *)dic{
    if (dic) {
        NSString *image = dic[@"goods_img"];
        [self.coverImage sd_setImageWithURL:URL(image)];
        self.titleLabel.text = dic[@"goods_name"];
        self.priceLbl.text = dic[@"amount"];
        [self.timesBtn setTitle:[NSString stringWithFormat:@"课程码：%@",dic[@"order_sn"]] forState:0];
    }
}
//- (void)setCouserModel:(Course_list *)couserModel{
//    [self.coverImage sd_setImageWithURL:URL(couserModel.course_img)];
//    self.titleLabel.text = couserModel.course_name;
//    self.priceLbl.text = couserModel.price;
//}
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
        [_timesBtn setTitleColor:UIColor333 forState:0];
        [_timesBtn.titleLabel setFont:LabelFont14];
    }
    
    return _timesBtn;
}



@end
