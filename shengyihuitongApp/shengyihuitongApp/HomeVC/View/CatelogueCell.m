//
//  CatelogueCell.m
//  shengyihuitongApp
//
//  Created by Mac on 2020/6/26.
//  Copyright © 2020 mac. All rights reserved.
//

#import "CatelogueCell.h"
@interface CatelogueCell()
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@end

@implementation CatelogueCell

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
    
    self.iconView = [UIImageView new];
    self.iconView.image = [UIImage imageNamed:@"consume"];
    [self.contentView addSubview:self.iconView];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.size.mas_equalTo(CGSizeMake(22, 22));
        make.top.mas_equalTo(12);
       
    }];
    

    
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-12).priority(100);
        make.centerY.mas_equalTo(self.iconView);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconView.mas_right).offset(12);
        make.centerY.mas_equalTo(self.iconView);
        make.right.mas_equalTo(-90);
         make.bottom.mas_offset(-12);
    }];
    
//    [self.selBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(-12);
//        make.centerY.mas_equalTo(self.contentView);
//        make.size.mas_equalTo(CGSizeMake(22, 22));
//    }];
    
}

- (void)setDetailModel:(Child_list *)detailModel{
//    _detailModel = detailModel;
    self.titleLabel.text = detailModel.chapter_name;
    CGFloat times = detailModel.duration/60.0;
    self.timeLabel.text = [NSString stringWithFormat:@"时长:%.2f",times];
    if (detailModel.isSel) {
        self.titleLabel.textColor = [UIColor colorWithHexString:@"00FF7F"];
    }else{
        self.titleLabel.textColor = UIColor999;
    }
}

- (void)setChapteModel:(Chapter_list *)chapteModel{
    self.titleLabel.text = chapteModel.chapter_name;
    self.timeLabel.hidden = true;
}


-(UILabel *)titleLabel
{
    if(!_titleLabel)
    {
        _titleLabel = [UILabel commonLabelWithtext:@"标题" color:[UIColor colorWithHexString:@"00FF7F"] font:LabelFont14 textAlignment:NSTextAlignmentLeft];
        _titleLabel.numberOfLines = 0;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(UILabel *)timeLabel
{
    if(!_timeLabel)
    {
        _timeLabel = [UILabel commonLabelWithtext:@"时长128" color:UIColor999 font:LabelFont14 textAlignment:NSTextAlignmentLeft];
        [self addSubview:_timeLabel];
    }
    return _timeLabel;
}

- (UIButton *)selBtn{
    if (!_selBtn) {
        _selBtn = [UIButton new];
        [_selBtn setImage:[UIImage imageNamed:@"unsel"] forState:0];
        [_selBtn setImage:[UIImage imageNamed:@"sel"] forState:UIControlStateSelected];
        [self.contentView addSubview:_selBtn];
    }
    
    return _selBtn;
}
@end
