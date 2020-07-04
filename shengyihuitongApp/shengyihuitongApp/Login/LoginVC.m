//
//  LoginVC.m
//  shengyihuitongApp
//
//  Created by mac on 2020/6/23.
//  Copyright © 2020 mac. All rights reserved.
//

#import "LoginVC.h"
#import "AccLoginView.h"
#import "AccountManager.h"
@interface LoginVC ()
@property(nonatomic,strong) AccLoginView *accLoginView;
@property(nonatomic,strong) AccountManager *manager;
@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    NSDictionary *dic =@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:17 weight:UIFontWeightBold]};
    self.navigationController.navigationBar.titleTextAttributes = dic;
    [self.backBtn setImage:[UIImage imageNamed:@"cha"] forState:0];
    self.backBtn.tintColor = [UIColor blackColor];
     self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setupUI{
    UIImageView *topImage = [UIImageView new];
    topImage.image = [UIImage imageNamed:@"passport"];
    [self.view addSubview:topImage];
    [topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(200, 150));
    }];
    
    self.accLoginView = [AccLoginView new];
    [self.view addSubview:self.accLoginView];
    [self.accLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(topImage.mas_bottom).offset(10*AdapterScal);
        make.right.mas_equalTo(0);
        
    }];
    
    WeakSelf(self)
    self.accLoginView.clickBlock = ^(NSInteger type) {
        if (type == 100) {
            
            [weakself accLogin];
            
        }else if (type == 101){
            [weakself.navigationController pushViewController:[NSClassFromString(@"RegisterVC") new] animated:true];
        }else if (type == 102){
            [weakself.navigationController pushViewController:[NSClassFromString(@"ForgetPasswordVC") new] animated:true];
        }
    };
}

- (void)accLogin{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.accLoginView.acctextField.text forKey:@"mobile"];
    [dic setValue:self.accLoginView.pwdtextField.text forKey:@"password"];
    [self.manager accountLoginWithparameters:dic withCompletionHandler:^(NSError *error, MessageBody *result) {
        if (result.code == 1) {
            JLog(@"%@",result.result);
            [[NSUserDefaults standardUserDefaults] setObject:result.result forKey:@"accessToken"];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:refreshUserInfo object:nil];
            [self dismissViewControllerAnimated:true completion:nil];
        }
    }];
}

- (AccountManager *)manager{
    if (!_manager) {
        _manager = [AccountManager new];
    }
    
    return _manager;
}

@end
