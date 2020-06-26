//
//  ItemCollectionCell.m
//  shengyihuitongApp
//
//  Created by mac on 2020/6/24.
//  Copyright © 2020 mac. All rights reserved.
//

#import "ItemCollectionCell.h"
@interface ItemCollectionCell()


@property (nonatomic , strong) UILabel *goodsTitleLabel;

@end
@implementation ItemCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//         self.contentView.backgroundColor = UIColor.purpleColor;
         [self setupLayout];

    }
    return self;
}

- (void)setupLayout
{
    
    [self.contentView addSubview:self.goodsTitleLabel];
    [self.goodsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
}

- (void)setInfoModel:(ClassInfo *)infoModel{
    self.goodsTitleLabel.text = infoModel.DealName;
}


- (void)setupData:(NSDictionary *)dic{
    if (dic) {
        self.goodsTitleLabel.text = [NSString stringWithFormat:@"%@",dic[@"job_name"]];
    }
}

-(UILabel *)goodsTitleLabel
{
    if(!_goodsTitleLabel)
    {
        _goodsTitleLabel=[UILabel  new];
        _goodsTitleLabel.font = LabelFont12;
        _goodsTitleLabel.textColor = UIColor333;
        _goodsTitleLabel.backgroundColor = UIColorEF;
        _goodsTitleLabel.numberOfLines = 1;
        _goodsTitleLabel.textAlignment = NSTextAlignmentCenter;
        _goodsTitleLabel.text = @"执业药师";

    }
    return _goodsTitleLabel;
}
@end
