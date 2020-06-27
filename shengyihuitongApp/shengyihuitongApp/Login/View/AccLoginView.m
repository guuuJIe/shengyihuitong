//
//  AccLoginView.m
//  shengyihuitongApp
//
//  Created by mac on 2020/6/23.
//  Copyright © 2020 mac. All rights reserved.
//

#import "AccLoginView.h"

@interface AccLoginView()<UITextFieldDelegate>
@property(nonatomic,strong) UIButton *dxdlSendSMSBtn;
@property(nonatomic,strong) UIButton *loginBtn;
@end

@implementation AccLoginView

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI{
    
    UILabel *title = [UILabel new];
    title.text = @"账号";
    title.textColor = UIColor60;
    title.font = LabelFont14;
    [self addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(32);
    }];
    UITextField  *teltext = [UITextField new];
    teltext.placeholder = @"请输入账号";
    teltext.textColor = UIColor333;
    teltext.font = LabelFont16;
    teltext.returnKeyType = UIReturnKeyDone;
    teltext.keyboardType = UIKeyboardTypeDefault;
    teltext.autocapitalizationType = UITextAutocapitalizationTypeNone;
    teltext.text = @"13901509103";
    
    [self addSubview:teltext];
    self.acctextField = teltext;
    [teltext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(title);
        make.right.mas_equalTo(-32);
        make.height.mas_equalTo(22);
        make.top.mas_equalTo(title.mas_bottom).offset(6);
    }];
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor colorWithHexString:@"EDEFF2"];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(teltext);
        make.top.mas_equalTo(teltext.mas_bottom).offset(8);
        make.height.mas_equalTo(lineHeihgt);
    }];
    
    
    
    UILabel *title2 = [UILabel new];
    title2.text = @"密码";
    title2.textColor = UIColor60;
    title2.font = LabelFont14;
    [self addSubview:title2];
    [title2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.mas_bottom).offset(8*AdapterScal);
        make.left.mas_equalTo(32);
    }];
    UITextField  *codetext = [UITextField new];
    codetext.placeholder = @"请输入密码";
    codetext.textColor = UIColor333;
    codetext.font = LabelFont16;
    codetext.text = @"qweqwe";
    codetext.delegate = self;
    self.pwdtextField = codetext;
    self.pwdtextField.secureTextEntry = true;
    [self addSubview:codetext];
    [codetext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(title);
        make.width.mas_equalTo(170);
        make.height.mas_equalTo(22);
        make.top.mas_equalTo(title2.mas_bottom).offset(6);
    }];
    UIView *line2 = [UIView new];
    line2.backgroundColor = [UIColor colorWithHexString:@"EDEFF2"];
    [self addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(teltext);
        make.top.mas_equalTo(codetext.mas_bottom).offset(8);
        make.height.mas_equalTo(lineHeihgt);
    }];
    
    
    
    self.dxdlSendSMSBtn=[UIButton new];
    
    [self.dxdlSendSMSBtn setImage:[UIImage imageNamed:@"L_icon7"] forState:0];
    [self.dxdlSendSMSBtn setImage:[UIImage imageNamed:@"L_icon6"] forState:UIControlStateSelected];
    [self.dxdlSendSMSBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.dxdlSendSMSBtn];
    [self.dxdlSendSMSBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-32);
        make.size.mas_equalTo(CGSizeMake(22 , 22));
        make.centerY.mas_equalTo(codetext);
    }];
    
    
    UIButton *button = [UIButton new];
    [button setTitle:@"登录" forState:0];
    [button.titleLabel setFont:LabelFont14];
    [button setTitleColor:[UIColor whiteColor] forState:0];
    button.layer.cornerRadius = 20;
    button.backgroundColor = APPColor;
    button.layer.shadowColor = [UIColor colorWithHexString:@"085BC7"].CGColor;
    button.layer.shadowOffset = CGSizeMake(0, 2);
    button.layer.shadowOpacity = 0.4;
    button.layer.shadowRadius = 2.0;
//    button.alpha = 0.5;
    [self addSubview:button];
    button.tag = 100;
    self.loginBtn = button;
    [button addTarget:self action:@selector(clickType:) forControlEvents:UIControlEventTouchUpInside];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line2.mas_bottom).offset(32*AdapterScal);
        make.left.mas_equalTo(32);
        make.right.mas_equalTo(-32);
        make.height.mas_equalTo(40);
    }];
    
    
    UIButton *btn = [UIButton new];
    [btn setTitle:@"立即注册" forState:0];
    [btn setImage:[UIImage imageNamed:@"more"] forState:0];
    [btn.titleLabel setFont:LabelFont14];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 80, 0, 0)];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -60, 0, 0)];
    [btn setTitleColor:UIColor90 forState:0];
    btn.tag = 101;
    [self addSubview:btn];
    [btn addTarget:self action:@selector(clickType:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(button);
        make.top.mas_equalTo(button.mas_bottom).offset(16*AdapterScal);
        make.width.mas_equalTo(120);
    }];
    
    
    UIButton *btn2 = [UIButton new];
    [btn2 setTitle:@"忘记密码" forState:0];
 
    [btn2.titleLabel setFont:LabelFont14];
    [btn2 setTitleColor:UIColor90 forState:0];
    btn2.tag = 102;
    [self addSubview:btn2];
    [btn2 addTarget:self action:@selector(clickType:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(button);
        make.top.mas_equalTo(button.mas_bottom).offset(16*AdapterScal);
        make.bottom.mas_equalTo(self);
    }];
    
    

}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.text.length != 0) {
        self.loginBtn.alpha = 1;
    }
}
- (void)click:(UIButton *)sender{
    sender.selected = !sender.selected;
    
    self.pwdtextField.secureTextEntry = !sender.selected;
    
}

- (void)clickType:(UIButton *)sender{
    if (self.clickBlock) {
        self.clickBlock(sender.tag);
    }
}
@end
