//
//  CateCell.m
//  shengyihuitongApp
//
//  Created by Mac on 2020/7/4.
//  Copyright © 2020 温州轩捷贸易有限公司. All rights reserved.
//

#import "CateCell.h"
@interface CateCell()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *selBtn;
@end

@implementation CateCell

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
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(-90);
//        make.bottom.mas_offset(-12);
        make.width.mas_equalTo(Screen_Width - 80);
        
    }];
    
    [self.selBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-12);
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = UIColorEF;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(lineHeihgt);
    }];
}

- (void)setLoadModel:(DownloadModel *)loadModel{
    self.titleLabel.text = loadModel.course_name;
}

-(UILabel *)titleLabel
{
    if(!_titleLabel)
    {
        _titleLabel = [UILabel commonLabelWithtext:@"标题" color:UIColor333 font:LabelFont14 textAlignment:NSTextAlignmentLeft];
        _titleLabel.numberOfLines = 0;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}



- (UIButton *)selBtn{
    if (!_selBtn) {
        _selBtn = [UIButton new];
        [_selBtn setImage:[UIImage imageNamed:@"white_arrow"] forState:0];
//        [_selBtn setImage:[UIImage imageNamed:@"sel"] forState:UIControlStateSelected];
        [self.contentView addSubview:_selBtn];
    }
    
    return _selBtn;
}
@end
