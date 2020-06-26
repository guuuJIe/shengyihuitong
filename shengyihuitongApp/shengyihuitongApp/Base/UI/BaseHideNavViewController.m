//
//  BaseHideNavViewController.m
//  RebateApp
//
//  Created by Mac on 2019/11/12.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "BaseHideNavViewController.h"

@interface BaseHideNavViewController ()

@end

@implementation BaseHideNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = UIColorEF;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
