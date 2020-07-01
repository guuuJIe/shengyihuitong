//
//  CommentItemCell.m
//  shengyihuitongApp
//
//  Created by mac on 2020/6/27.
//  Copyright © 2020 mac. All rights reserved.
//

#import "CommentItemCell.h"
#import "JZLStarView.h"
@interface CommentItemCell()
@property (nonatomic, strong) UIImageView *avatarImage;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timesLbl;
@property (nonatomic, strong) UILabel *contentLbl;
@property (nonatomic, strong) JZLStarView *starView;
@end

@implementation CommentItemCell

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
    [self.contentView addSubview:self.avatarImage];
    [self.avatarImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(35, 35));
        
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarImage.mas_right).offset(10);
        make.top.mas_equalTo(self.avatarImage);
    }];
    
    [self.timesLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_equalTo(8);
    }];
    
    [self.contentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.right.mas_equalTo(-12);
        make.top.mas_equalTo(self.timesLbl.mas_bottom).mas_equalTo(8);
        make.bottom.mas_equalTo(-15);
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = UIColorEF;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(lineHeihgt);
    }];
    
}


- (void)setupData:(NSDictionary *)dic{
    if (dic) {
        NSString *url = [NSString stringWithFormat:@"%@",dic[@"avatar"]];
        [self.avatarImage sd_setImageWithURL:URL(url) placeholderImage:[UIImage imageNamed:@"icon_1"]];
        self.titleLabel.text = dic[@"username"];
        self.timesLbl.text = dic[@"add_time"];
        self.contentLbl.text = dic[@"content"];
        
        self.starView.frame = CGRectMake(Screen_Width - 50 - 15, 10, 50, 20);
        
        NSInteger score = [dic[@"score"] integerValue];
        self.starView.currentScore = score;
    }
}

- (UIImageView *)avatarImage{
    if (!_avatarImage) {
        _avatarImage = [UIImageView new];
    }
    
    return _avatarImage;
}

-(UILabel *)titleLabel
{
    if(!_titleLabel)
    {
        
        _titleLabel = [UILabel commonLabelWithtext:@"1233444" color:UIColor333 font:LabelFont14 textAlignment:NSTextAlignmentLeft];

        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(UILabel *)timesLbl
{
    if(!_timesLbl)
    {
        
        _timesLbl = [UILabel commonLabelWithtext:@"1233444" color:UIColor999 font:LabelFont12 textAlignment:NSTextAlignmentLeft];

        [self.contentView addSubview:_timesLbl];
    }
    return _timesLbl;
}

-(UILabel *)contentLbl
{
    if(!_contentLbl)
    {
        
        _contentLbl = [UILabel commonLabelWithtext:@"时间有点长" color:UIColor333 font:LabelFont12 textAlignment:NSTextAlignmentLeft];
        _contentLbl.numberOfLines = 0;
        [self.contentView addSubview:_contentLbl];
    }
    return _contentLbl;
}

- (JZLStarView *)starView {
    if (!_starView) {
        _starView = [[JZLStarView alloc] initWithFrame:CGRectMake(0, 0, 50, 20) starCount:5 starStyle:IncompleteStar isAllowScroe:NO];
//        _starView.currentScore = 3.2;
        
        [self.contentView addSubview:_starView];
    }
    return _starView;
}

@end
