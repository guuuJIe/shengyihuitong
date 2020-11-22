//
//  MineInfoVC.m
//  shengyihuitongApp
//
//  Created by mac on 2020/6/30.
//  Copyright © 2020 mac. All rights reserved.
//

#import "MineInfoVC.h"

@interface MineInfoVC ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;
@property (weak, nonatomic) IBOutlet UILabel *telText;
@property (weak, nonatomic) IBOutlet UILabel *nickLabel;

@end

@implementation MineInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"个人资料";
    self.avatarImage.layer.cornerRadius = 30;
    self.avatarImage.layer.masksToBounds = true;
    [self setupData];
}


- (void)setupData{
    [self.avatarImage sd_setImageWithURL:URL(self.userDic[@"avatar"]) placeholderImage:[UIImage imageNamed:@"icon_1"]];
    self.telText.text = self.userDic[@"mobile"];
    self.nickLabel.text = self.userDic[@"username"];
}
@end
