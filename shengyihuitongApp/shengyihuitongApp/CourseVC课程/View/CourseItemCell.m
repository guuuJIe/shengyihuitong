//
//  CourseItemCell.m
//  shengyihuitongApp
//
//  Created by Mac on 2020/6/25.
//  Copyright © 2020 mac. All rights reserved.
//

#import "CourseItemCell.h"
@interface CourseItemCell()
@property (nonatomic, strong) UIImageView *coverImage;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLbl;
@property (nonatomic, strong) UILabel *orgPriceLbl;
@property (nonatomic, strong) UIButton *playedBtn;
@end

@implementation CourseItemCell

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
    [self.contentView addSubview:self.coverImage];
    [self.coverImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(12);
        make.size.mas_equalTo(CGSizeMake(140, 100));
        make.bottom.mas_equalTo(-12);
    }];
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.coverImage.mas_right).offset(10);
        make.top.mas_equalTo(self.coverImage);
        make.right.mas_equalTo(-10);
    }];
    
    
    [self.priceLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.bottom.mas_equalTo(self.coverImage);
    }];
    
    [self.orgPriceLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.priceLbl.mas_right).offset(5);
        make.centerY.mas_equalTo(self.priceLbl);
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = UIColorEF;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(lineHeihgt);
    }];
    
    
    [self.contentView addSubview:self.playedBtn];
    [self.playedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-12);
        make.centerY.mas_equalTo(self.orgPriceLbl);
    }];
}

- (void)setupData:(NSDictionary *)dic{
    if (dic) {
        NSString *avartar = dic[@"course_img"];
        [self.coverImage sd_setImageWithURL:URL(avartar)];
        self.titleLabel.text = dic[@"course_name"];
        self.priceLbl.text = dic[@"user_price"];
//         self.orgPriceLbl.text = dic[@"price"];
        NSString *textStr = dic[@"price"];
        //中划线
        NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:textStr attributes:attribtDic];
              
        // 赋值
        self.orgPriceLbl.attributedText = attribtStr;

       
        [self.playedBtn setTitle:[NSString stringWithFormat:@"%@",dic[@"played"]] forState:0];
    }
}

- (UIImageView *)coverImage{
    if (!_coverImage) {
        _coverImage = [UIImageView new];
//        _coverImage.backgroundColor = UIColor.redColor;
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
        
        _priceLbl = [UILabel commonLabelWithtext:@"标题" color:fenseColor font:LabelFont14 textAlignment:NSTextAlignmentCenter];
       
        [self.contentView addSubview:_priceLbl];
    }
    return _priceLbl;
}


-(UILabel *)orgPriceLbl
{
    if(!_orgPriceLbl)
    {
        
        _orgPriceLbl = [UILabel commonLabelWithtext:@"标题" color:UIColor999 font:LabelFont12 textAlignment:NSTextAlignmentCenter];
       
        [self.contentView addSubview:_orgPriceLbl];
    }
    return _orgPriceLbl;
}

- (UIButton *)playedBtn{
    if (!_playedBtn) {
        _playedBtn = [UIButton new];
        [_playedBtn setTitle:@"1234" forState:0];
        [_playedBtn setTitleColor:UIColor999 forState:0];
        [_playedBtn.titleLabel setFont:LabelFont12];
    }
    
    return _playedBtn;
}
@end
