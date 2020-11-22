//
//  CateTableCell.m
//  shengyihuitongApp
//
//  Created by mac on 2020/6/24.
//  Copyright © 2020 mac. All rights reserved.
//

#import "CateTableCell.h"
@interface CateTableCell()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;//
@end

@implementation CateTableCell

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
        self.contentView.backgroundColor = UIColorEF;
    }
    
    return self;
}


- (void)setupUI{
    
    [self.contentView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView);
        make.top.mas_equalTo(1);
        make.bottom.mas_equalTo(-1);
        make.width.mas_equalTo(4);
    }];
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.lineView.mas_left).offset(10);
        make.right.mas_equalTo(-10);
    }];
    
}

- (void)setCateModel:(CateModel *)cateModel{
    self.titleLabel.text = cateModel.KsbClassName;
    if (cateModel.isSelected) {
        self.contentView.backgroundColor = UIColor.whiteColor;
        self.lineView.hidden = false;
    }else{
        self.contentView.backgroundColor = UIColorEF;
        self.lineView.hidden = true;
    }
}



-(UILabel *)titleLabel
{
    if(!_titleLabel)
    {
        
        _titleLabel = [UILabel commonLabelWithtext:@"执业药师" color:UIColor333 font:LabelFont14 textAlignment:NSTextAlignmentCenter];

        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = UIColor9BC;
    }
    
    return _lineView;
}

@end
