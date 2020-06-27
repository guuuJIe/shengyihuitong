//
//  AboutUsVC.m
//  shengyihuitongApp
//
//  Created by 温州轩捷贸易有限公司 on 2020/6/27.
//  Copyright © 2020 温州轩捷贸易有限公司. All rights reserved.
//

#import "AboutUsVC.h"

@interface AboutUsVC ()

@end

@implementation AboutUsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

- (void)setupUI{
    self.navigationItem.title = @"关于我们";
    
    UIImageView *icon = [UIImageView new];
    icon.image = [UIImage imageNamed:@"about_bg"];
    [self.view addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
}

@end
