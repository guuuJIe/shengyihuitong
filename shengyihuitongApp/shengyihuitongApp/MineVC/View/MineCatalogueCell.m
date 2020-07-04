//
//  MineCatalogueCell.m
//  shengyihuitongApp
//
//  Created by mac on 2020/6/29.
//  Copyright © 2020 mac. All rights reserved.
//

#import "MineCatalogueCell.h"
@interface MineCatalogueCell()
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIButton *selBtn;
@end
@implementation MineCatalogueCell

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
    

    
    
//    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.right.mas_equalTo(-12).priority(100);
//        make.centerY.mas_equalTo(self.iconView);
//    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconView.mas_right).offset(12);
        make.centerY.mas_equalTo(self.iconView);
        make.right.mas_equalTo(-90);
         make.bottom.mas_offset(-12);
    }];
    
    [self.selBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-12);
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
    
}

- (void)setDetailModel:(Child_list *)detailModel{

    self.titleLabel.text = detailModel.chapter_name;
    if (detailModel.isSel) {
        self.selBtn.selected = true;
    }else{
        self.selBtn.selected = false;
    }
}

- (void)clickAct:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    if (self.clickRowBlock) {
        self.clickRowBlock(sender.selected);
    }
}



-(UILabel *)titleLabel
{
    if(!_titleLabel)
    {
        _titleLabel = [UILabel commonLabelWithtext:@"标题" color:UIColor999 font:LabelFont14 textAlignment:NSTextAlignmentLeft];
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
        [_selBtn addTarget:self action:@selector(clickAct:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_selBtn];
    }
    
    return _selBtn;
}

@end
