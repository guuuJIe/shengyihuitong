//
//  BaseViewController.m
//  RebateApp
//
//  Created by Mac on 2019/11/12.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "BaseViewController.h"
#import "UIImage+Extend.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:false animated:true];
     self.view.backgroundColor = UIColor.whiteColor;
}

- (void)loadView{
    [super loadView];
//    [self.navigationController setNavigationBarHidden:false animated:true];

}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:false animated:true];
    self.view.backgroundColor = UIColor.whiteColor;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
//    self.view.backgroundColor = UIColorF5F7;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    NSDictionary *dic =@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:17 weight:UIFontWeightBold]};
    self.navigationController.navigationBar.titleTextAttributes = dic;
    
    [self.navigationController setNavigationBarHidden:false animated:true];
    // 设置navbar
    self.navigationItem.backBarButtonItem = nil;
//    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:APPColor] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
//    self.navigationController.navigationBar.barTintColor=JSCGlobalThemeColor;
    
    [self.backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
//    self.backBtn.frame = CGRectMake(0, 0, 50, 50);
//    [self.backBtn set]
    self.backBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:self.backBtn];

}

-(void)backBtnClick
{
    if (self.navigationController.childViewControllers.count>1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}


#pragma mark -get
-(UIButton *)backBtn
{
    if (_backBtn==nil) {
        _backBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        [_backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        _backBtn.contentMode = UIViewContentModeCenter;
        [_backBtn.titleLabel setHidden:YES];
        [_backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _backBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        _backBtn.frame=CGRectMake(0, 0, 40, 40);
        [_backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
        
        _backBtn.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _backBtn;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)dealloc{
    JLog(@"%@ dealloc",self);
}

@end
