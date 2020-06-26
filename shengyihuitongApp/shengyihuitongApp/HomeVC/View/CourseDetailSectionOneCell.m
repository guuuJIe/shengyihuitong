//
//  CourseDetailSectionOneCell.m
//  shengyihuitongApp
//
//  Created by Mac on 2020/6/26.
//  Copyright © 2020 温州轩捷贸易有限公司. All rights reserved.
//

#import "CourseDetailSectionOneCell.h"
@interface CourseDetailSectionOneCell()
@property (weak, nonatomic) IBOutlet UIImageView *coverImge;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;

@end

@implementation CourseDetailSectionOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setSModel:(SquadModel *)sModel{
    [self.coverImge sd_setImageWithURL:URL(sModel.squad_img)];
    self.titleLbl.text = sModel.squad_name;
    self.priceLbl.text = sModel.price;
}

@end
