//
//  RegisterVC.m
//  shengyihuitongApp
//
//  Created by mac on 2020/6/27.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RegisterVC.h"
#import "CountDownBtn.h"
#import "CateManager.h"
#import "CusPickerView.h"
#import "NSString+Extend.h"
#import "AccountManager.h"
@interface RegisterVC ()<UITextFieldDelegate>
@property(nonatomic,strong) UITextField *acctextField;
@property(nonatomic,strong) UITextField *codetextField;
@property(nonatomic,strong) UITextField *pwdtextField;
@property(nonatomic,strong) UITextField *recommandTelTextField;
@property(nonatomic,strong) UIView *jobView;
@property(nonatomic,strong) UILabel *titleLbl;
@property(nonatomic,assign) NSInteger job_id;
@property(nonatomic,strong) CountDownBtn *countBtn;
@property(nonatomic,strong) CateManager *manager;
@property(nonatomic,strong) CusPickerView *pickerView;
@property(nonatomic,strong) AccountManager *accManager;
@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self getData];
}

- (void)getData{
    [self.manager getCategoryDatawithCompletionHandler:^(NSError *error, MessageBody *result) {
        if (result.code == 1) {
            NSDictionary *dic = result.result;
            self.pickerView.dataArr = (NSArray *)dic[@"job"];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)setupUI{
    self.navigationItem.title = @"注册";
    self.view.backgroundColor = UIColor.whiteColor;
    UILabel *title = [UILabel new];
    title.text = @"账号";
    title.textColor = UIColor333;
    title.font = LabelFont14;
    [self.view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(32);
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
             teltext.text = @"13901509103";
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
                teltext2.text = @"13901509103";
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
    
    
    UILabel *title4 = [UILabel new];
    title4.text = @"推荐人手机号码";
    title4.textColor = UIColor333;
    title4.font = LabelFont14;
    [self.view addSubview:title4];
    [title4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line3.mas_bottom).offset(12);
        make.left.mas_equalTo(32);
    }];
    
    UITextField  *teltext4 = [UITextField new];
    teltext4.placeholder = @"请输入推荐人手机号码(选填)";
    teltext4.textColor = UIColor333;
    teltext4.font = LabelFont16;
    teltext4.returnKeyType = UIReturnKeyDone;
    teltext4.keyboardType = UIKeyboardTypeDefault;
    teltext4.autocapitalizationType = UITextAutocapitalizationTypeNone;
    #ifdef DEBUG
             teltext4.text = @"123abc";
    #else
            
    #endif
    
    [self.view addSubview:teltext4];
    self.recommandTelTextField = teltext4;
    [teltext4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(title);
        make.right.mas_equalTo(-32);
        make.height.mas_equalTo(22);
        make.top.mas_equalTo(title4.mas_bottom).offset(6);
    }];
    UIView *line4 = [UIView new];
    line4.backgroundColor = UIColorED;
    [self.view addSubview:line4];
    [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(teltext);
        make.top.mas_equalTo(teltext4.mas_bottom).offset(8);
        make.height.mas_equalTo(lineHeihgt);
    }];
    
    self.jobView = [UIView new];
    [self.view addSubview:self.jobView];
    self.jobView.layer.borderWidth = 1;
    self.jobView.layer.borderColor = APPColor.CGColor;
    [self.jobView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showJob)]];
    [self.jobView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line4);
        make.top.mas_equalTo(line4.mas_bottom).offset(8);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    
    [self.jobView addSubview:self.titleLbl];
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.centerY.mas_equalTo(self.jobView);
        
    }];
    
    UIButton *btn = [UIButton new];
    [btn setImage:[UIImage imageNamed:@"triangle"] forState:0];
    [self.jobView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-4);
        make.size.mas_equalTo(CGSizeMake(18, 18));
         make.centerY.mas_equalTo(self.titleLbl);
    }];
    
    
    UIButton *button = [UIButton new];
    [button setTitle:@"注册" forState:0];
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
    [button addTarget:self action:@selector(registerAct) forControlEvents:UIControlEventTouchUpInside];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.jobView.mas_bottom).offset(32*AdapterScal);
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


- (void)registerAct{
    if (self.acctextField.text.length == 0) {
        [JMBManager showBriefAlert:@"请输入手机号"];
        return;
    }
    
    if (self.codetextField.text.length == 0) {
        [JMBManager showBriefAlert:@"请输入验证码"];
        return;
    }
    
    if (self.pwdtextField.text.length == 0) {
        [JMBManager showBriefAlert:@"请输入验证码"];
        return;
    }
    
    if (!self.job_id) {
        [JMBManager showBriefAlert:@"请选择职业"];
        return;
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:self.acctextField.text forKey:@"mobile"];
    [dic setValue:self.codetextField.text forKey:@"vcode"];
    [dic setValue:self.pwdtextField.text forKey:@"password"];
    [dic setValue:self.recommandTelTextField.text forKey:@"icode"];
    [dic setValue:@(self.job_id) forKey:@"job_id"];
    [dic setValue:@0 forKey:@"from"];
    WeakSelf(self)
    [self.accManager userRegisterWithparameters:dic withCompletionHandler:^(NSError *error, MessageBody *result) {
        if (result.code == 1) {
            [JMBManager showBriefAlert:@"注册成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakself.navigationController popViewControllerAnimated:true];
            });
        }else{
            [JMBManager showBriefAlert:result.message];
        }
    }];
}

- (void)showJob{
    [self.pickerView popPickerView];
}

- (UILabel *)titleLbl{
    if (!_titleLbl) {
        _titleLbl = [UILabel new];
        _titleLbl.textColor = UIColor333;
        _titleLbl.font = LabelFont14;
        _titleLbl.text = @"请选择职业";
    }
    
    return _titleLbl;
}

- (CateManager *)manager{
    if (!_manager) {
        _manager = [CateManager new];
        
    }
    
    return _manager;
}

- (AccountManager *)accManager{
    if (!_accManager) {
        _accManager = [AccountManager new];
    }
    
    return _accManager;
}

- (CusPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[CusPickerView alloc] initWithFrame:CGRectMake(0, Screen_Height, Screen_Width, Screen_Height)];
        WeakSelf(self);
        _pickerView.selectBlock = ^(id  _Nonnull result, id  _Nonnull result2, NSString * _Nonnull name) {
            StrongSelf(self);
            self.job_id = [result integerValue];
            NSString *resultdata = result2;
            self.titleLbl.text = resultdata;
            CGSize widthSize = [NSString sizeWithText:resultdata font:LabelFont14 maxSize:Max_Size];
            [self.jobView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(widthSize.width + 30);
            }];
            
            [self.jobView updateConstraintsIfNeeded];
        };
        [self.navigationController.view addSubview:_pickerView];
    }
    return _pickerView;
}
@end
