//
//  MineInfoCell.m
//  shengyihuitongApp
//
//  Created by mac on 2020/6/24.
//  Copyright © 2020 mac. All rights reserved.
//

#import "MineInfoCell.h"
@interface MineInfoCell()
@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation MineInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.backgroundColor = APPColor;
    UIView *line = [UIView new];
    [self.contentView addSubview:line];
    line.backgroundColor = UIColor.whiteColor;
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(20);
//        make.right.mas_equalTo(-5);
        make.width.mas_equalTo(Screen_Width);
    }];
    
    
    [self.contentView layoutIfNeeded];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:line.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(18, 18)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = line.bounds;
    maskLayer.path = maskPath.CGPath;
    line.layer.mask = maskLayer;
    self.loginBtn.layer.cornerRadius = 13;
    self.avatarImage.layer.cornerRadius = 40;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupdata:(NSDictionary *)dic{
    if (dic) {
        self.nameLbl.text = dic[@"username"];
        self.loginBtn.hidden = true;
        NSString *avatar = [NSString stringWithFormat:@"%@",dic[@"avatar"]];
        [self.avatarImage sd_setImageWithURL:URL(avatar)];
    }
}

@end
