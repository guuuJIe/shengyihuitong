//
//  CourseIntroCell.m
//  shengyihuitongApp
//
//  Created by Mac on 2020/6/26.
//  Copyright © 2020 温州轩捷贸易有限公司. All rights reserved.
//

#import "CourseIntroCell.h"
@interface CourseIntroCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;
@property (weak, nonatomic) IBOutlet UILabel *timesLbl;

@end

@implementation CourseIntroCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (void)setupData:(NSDictionary *)dic{
//    if (dic) {
//        self.titleLbl.text = [NSString stringWithFormat:@"%@",dic[@"course_name"]];
//        self.priceLbl.text = dic[@"user_price"];
//        CGFloat played = [dic[@"played"] floatValue];
//        self.timesLbl.text = [NSString stringWithFormat:@"播放%.0f次 评论%@条",played,dic[@"commented"]];
//    }
//}

- (void)setDetailModel:(CourseDetailModel *)detailModel{
    self.titleLbl.text = detailModel.course_name;
    self.priceLbl.text = detailModel.user_price;
//    CGFloat played = [dic[@"played"] floatValue];
    self.timesLbl.text = [NSString stringWithFormat:@"播放%ld次 评论%@条",(long)detailModel.played,detailModel.commented];
}

@end
