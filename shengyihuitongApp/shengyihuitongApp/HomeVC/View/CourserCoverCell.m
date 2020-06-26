//
//  CourserCoverCell.m
//  shengyihuitongApp
//
//  Created by Mac on 2020/6/25.
//  Copyright © 2020 温州轩捷贸易有限公司. All rights reserved.
//

#import "CourserCoverCell.h"
@interface CourserCoverCell()
@property (nonatomic, strong) UIImageView *coverImage;
@end
@implementation CourserCoverCell

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
        make.edges.mas_equalTo(self.contentView);
    }];
}

//- (void)setupData:(NSDictionary *)dic{
//    if (dic) {
//        NSString *url = dic[@"course_img"];
//        [self.coverImage sd_setImageWithURL:URL(url)];
//    }
//}

- (void)setDetailModel:(CourseDetailModel *)detailModel{
    [self.coverImage sd_setImageWithURL:URL(detailModel.course_img)];
}

- (UIImageView *)coverImage{
    if (!_coverImage) {
        _coverImage = [UIImageView new];
//        _coverImage.backgroundColor = UIColor.redColor;
    }
    
    return _coverImage;
}
@end
