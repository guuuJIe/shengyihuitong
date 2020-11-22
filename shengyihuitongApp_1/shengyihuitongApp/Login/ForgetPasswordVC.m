//
//  ForgetPasswordVC.m
//  shengyihuitongApp
//
//  Created by Mac on 2020/7/3.
//  Copyright © 2020 mac. All rights reserved.
//

#import "ForgetPasswordVC.h"
#import "CountDownBtn.h"
#import "AccountManager.h"
@interface ForgetPasswordVC ()<UITextFieldDelegate>
@property(nonatomic,strong) UITextField *acctextField;
@property(nonatomic,strong) UITextField *codetextField;
@property(nonatomic,strong) UITextField *pwdtextField;
@property(nonatomic,strong) CountDownBtn *countBtn;
@property(nonatomic,strong) AccountManager *accManager;
@end

@implementation ForgetPasswordVC

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
    
    
    self.view.backgroundColor = UIColor.whiteColor;
    UILabel *title = [UILabel new];
    title.text = @"账号";
    title.textColor = UIColor333;
    title.font = LabelFont14;
    [self.view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topImage.mas_bottom).offset(10);
        make.left.mas_equalTo(32);
    }];
    UITextField  *teltext = [UITextField new];
    teltext.placeholder = @"请输入账号";
    teltext.textColor = UIColor333;
    teltext.font = LabelFont16;
    teltext.returnKeyType = UIReturnKeyDone;
    teltext.keyboardType = UIKeyboardTypeNumberPad;
    teltext.autocapitalizationType = UITextAutocapitalizationTypeNone;
#ifdef DEBUG
    teltext.text = @"";
#else
    
#endif
    
    [self.view addSubview:teltext];
    self.acctextField = teltext;
    [teltext addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [teltext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(title);
        make.right.mas_equalTo(-32);
        make.height.mas_equalTo(22);
        make.top.mas_equalTo(title.mas_bottom).offset(6);
    }];
    UIView *line = [UIView new];
    line.backgroundColor = UIColorED;
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(teltext);
        make.top.mas_equalTo(teltext.mas_bottom).offset(8);
        make.height.mas_equalTo(lineHeihgt);
    }];
    
    
    
    UILabel *title2 = [UILabel new];
    title2.text = @"验证码";
    title2.textColor = UIColor333;
    title2.font = LabelFont14;
    [self.view addSubview:title2];
    [title2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.mas_bottom).offset(12);
        make.left.mas_equalTo(32);
    }];
    UITextField  *teltext2 = [UITextField new];
    teltext2.placeholder = @"请输入验证码";
    teltext2.textColor = UIColor333;
    teltext2.font = LabelFont16;
    teltext2.returnKeyType = UIReturnKeyDone;
    teltext2.keyboardType = UIKeyboardTypeNumberPad;
    teltext2.autocapitalizationType = UITextAutocapitalizationTypeNone;
#ifdef DEBUG
    teltext2.text = @"";
#else
    
#endif
    
    [self.view addSubview:teltext2];
    self.codetextField = teltext2;
    [teltext2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(title);
        make.right.mas_equalTo(-32);
        make.height.mas_equalTo(22);
        make.top.mas_equalTo(title2.mas_bottom).offset(6);
    }];
    
    self.countBtn = [CountDownBtn new];
    [self.view addSubview:self.countBtn];
    [self.countBtn addTarget:self action:@selector(getVerCodeAct) forControlEvents:UIControlEventTouchUpInside];
    [self.countBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).offset(-40);
        make.centerY.mas_equalTo(teltext2);
        make.size.mas_equalTo(CGSizeMake(100*AdapterScal, 30*AdapterScal));
    }];
    
    UIView *line2 = [UIView new];
    line2.backgroundColor = UIColorED;
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(teltext);
        make.top.mas_equalTo(teltext2.mas_bottom).offset(8);
        make.height.mas_equalTo(lineHeihgt);
    }];
    
    
    UILabel *title3 = [UILabel new];
    title3.text = @"密码";
    title3.textColor = UIColor333;
    title3.font = LabelFont14;
    [self.view addSubview:title3];
    [title3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line2.mas_bottom).offset(12);
        make.left.mas_equalTo(32);
    }];
    UITextField  *teltext3 = [UITextField new];
    teltext3.placeholder = @"请输入密码";
    teltext3.textColor = UIColor333;
    teltext3.font = LabelFont16;
    teltext3.returnKeyType = UIReturnKeyDone;
    teltext3.keyboardType = UIKeyboardTypeDefault;
    teltext3.autocapitalizationType = UITextAutocapitalizationTypeNone;
#ifdef DEBUG
    teltext3.text = @"123abc";
#else
    
#endif
    
    [self.view addSubview:teltext3];
    self.pwdtextField = teltext3;
    [teltext3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(title);
        make.right.mas_equalTo(-32);
        make.height.mas_equalTo(22);
        make.top.mas_equalTo(title3.mas_bottom).offset(6);
    }];
    UIView *line3 = [UIView new];
    line3.backgroundColor = UIColorED;
    [self.view addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(teltext);
        make.top.mas_equalTo(teltext3.mas_bottom).offset(8);
        make.height.mas_equalTo(lineHeihgt);
    }];
    
    UIButton *button = [UIButton new];
    [button setTitle:@"重设密码" forState:0];
    [button.titleLabel setFont:LabelFont14];
    [button setTitleColor:[UIColor whiteColor] forState:0];
    button.layer.cornerRadius = 20;
    button.backgroundColor = APPColor;
    button.layer.shadowColor = [UIColor colorWithHexString:@"085BC7"].CGColor;
    button.layer.shadowOffset = CGSizeMake(0, 2);
    button.layer.shadowOpacity = 0.4;
    button.layer.shadowRadius = 2.0;
    
    [self.view addSubview:button];
    button.tag = 100;
    [button addTarget:self action:@selector(resetAct) forControlEvents:UIControlEventTouchUpInside];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line3.mas_bottom).offset(32*AdapterScal);
        make.left.mas_equalTo(32);
        make.right.mas_equalTo(-32);
        make.height.mas_equalTo(40);
    }];
}

-(void)textFieldDidChange :(UITextField *)theTextField{
   
    if (theTextField.text.length >= 11) {
       theTextField.text = [theTextField.text substringToIndex:11];
        self.acctextField.text = theTextField.text;
        JLog( @"text changed: %@", theTextField.text);
        self.countBtn.enabled = true;
    }else{
        self.countBtn.enabled = false;
    }
}

- (void)getVerCodeAct{
    if (self.acctextField.text.length != 11) {
        [JMBManager showBriefAlert:@"请输入手机号"];
        return;
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.acctextField.text forKey:@"mobile"];
    WeakSelf(self)
    [self.accManager getVerCodeWithparameters:dic withCompletionHandler:^(NSError *error, MessageBody *result) {
        if (result.code == 1) {
            [weakself.countBtn startRun];
        }
    }];
}


- (void)resetAct{
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:self.acctextField.text forKey:@"mobile"];
    [dic setValue:self.codetextField.text forKey:@"vcode"];
    [dic setValue:self.pwdtextField.text forKey:@"password"];
    [self.accManager resetPwdWithparameters:dic withCompletionHandler:^(NSError *error, MessageBody *result) {
        if (result.code == 1) {
            
            
            [self.navigationController popViewControllerAnimated:true];
        }
    }];
}

- (AccountManager *)accManager{
    if (!_accManager) {
        _accManager = [AccountManager new];
    }
    
    return _accManager;
}
@end
