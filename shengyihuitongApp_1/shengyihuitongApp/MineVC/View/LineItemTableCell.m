//
//  LineItemTableCell.m
//  shengyihuitongApp
//
//  Created by mac on 2020/6/24.
//  Copyright © 2020 mac. All rights reserved.
//

#import "LineItemTableCell.h"
@interface LineItemTableCell()
@property (weak, nonatomic) IBOutlet UIImageView *TImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@end

@implementation LineItemTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setupData:(NSDictionary *)dic{
    self.TImageView.image = [UIImage imageNamed:dic[@"image"]];
    self.titleLbl.text = dic[@"name"];
}

@end
