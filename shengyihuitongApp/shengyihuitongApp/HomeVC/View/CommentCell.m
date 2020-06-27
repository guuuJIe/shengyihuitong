//
//  CommentCell.m
//  shengyihuitongApp
//
//  Created by 温州轩捷贸易有限公司 on 2020/6/27.
//  Copyright © 2020 温州轩捷贸易有限公司. All rights reserved.
//

#import "CommentCell.h"
#import "JZLStarView.h"
@interface CommentCell()
@property (nonatomic, strong) JZLStarView *starView;
@end

@implementation CommentCell

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
    
    UIView *line = UIView.new;
    line.backgroundColor = UIColorEF;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.contentView);
        make.height.mas_equalTo(lineHeihgt);
    }];
    [self.contentView addSubview:self.starView];
//    [self.starView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.mas_equalTo(self.contentView);
//    }];
    
    UILabel *title = [UILabel new];
    title.text = @"来说点什么吧～";
    title.textColor = UIColor999;
    title.font = LabelFont15;
    [self.contentView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.starView.mas_bottom).offset(10);
    }];
}


- (JZLStarView *)starView {
    if (!_starView) {
        _starView = [[JZLStarView alloc] initWithFrame:CGRectMake(Screen_Width/2 - 50, 30, 100, 20) starCount:5 starStyle:IncompleteStar isAllowScroe:NO];
        _starView.currentScore = 5;
        _starView.userInteractionEnabled = false;
    }
    return _starView;
}

@end
