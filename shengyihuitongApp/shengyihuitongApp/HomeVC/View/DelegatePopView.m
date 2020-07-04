//
//  DelegatePopView.m
//  shengyihuitongApp
//
//  Created by mac on 2020/6/28.
//  Copyright © 2020 mac. All rights reserved.
//

#import "DelegatePopView.h"
#import "AppDelegate.h"
@interface DelegatePopView()

@end
@implementation DelegatePopView

- (instancetype)init{
    self = [super init];
    if (self) {
        self.type = MMPopupTypeCustom;
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(Screen_Width, Screen_Height));
        }];
        
        
        UIView *bgView = [UIView new];
        [self addSubview:bgView];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.layer.cornerRadius = 10;
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(30);
            make.right.mas_equalTo(-30);
            make.height.mas_equalTo(281*AdapterScal);
            make.center.mas_equalTo(self);
        }];
        
        UILabel *title = [UILabel new];
        title.text = @"个人信息保护指引";
        title.textColor = UIColor333;
        title.font = LabelFont14;
        [bgView addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.centerX.mas_equalTo(bgView);
        }];
        
      
        
        self.textView = [UITextView new];
        self.textView.backgroundColor = UIColor.whiteColor;
        [bgView addSubview:self.textView];
        self.textView.text = @"请充分阅读并理解\n《教学系统用户服务及隐私协议》\n\n 1.申请系统设备权限收集设备信息，用于信息推送，并申请存储权限，用户下载及缓存相关文件.\n\n 2.为帮助你在APP中拨打电话或其他咨询热线，我们可能会申请拨打电话权限，该权限不会收集隐私信息，且仅在你使用前述功能时使用.\n\n 3.上述权限以及摄像头、相册、存储空间等敏感权限均不会默认开启收集信息.";
        NSMutableAttributedString *atbs =[[NSMutableAttributedString alloc] initWithAttributedString: self.textView.attributedText];

        NSRange range = [[atbs string] rangeOfString:@"《教学系统用户服务及隐私协议》"];

        [atbs addAttributes:@{NSLinkAttributeName:@"http://syhtedu.com/yinsi.html"} range:range];
        self.textView.attributedText= atbs;

//        self.textView.delegate=self;

        self.textView.editable=NO;
       
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(30);
            make.right.mas_equalTo(-30);
            make.bottom.mas_equalTo(-65);
            make.top.mas_equalTo(title.mas_bottom).offset(12);
        }];
        
        
        UIButton *button = [UIButton new];
        [button setTitle:@"暂不使用" forState:0];
        [button setTitleColor:UIColor999 forState:0];
        [button.titleLabel setFont:LabelFont14];
        button.tag = 100;
        [bgView addSubview:button];
        [button addTarget:self action:@selector(clickAct:) forControlEvents:UIControlEventTouchUpInside];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.width.mas_equalTo((Screen_Width - 40)/2);
            make.bottom.mas_equalTo(bgView).offset(-4);
            make.height.mas_equalTo(44);
        }];
        
        
        UIButton *button2 = [UIButton new];
        [button2 setTitle:@"同意" forState:0];
        [button2 setTitleColor:APPColor forState:0];
        [button2.titleLabel setFont:LabelFont14];
        [bgView addSubview:button2];
        
        button2.tag = 101;
        [button2 addTarget:self action:@selector(clickAct:) forControlEvents:UIControlEventTouchUpInside];
        [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.width.mas_equalTo((Screen_Width - 40)/2);
            make.bottom.mas_equalTo(bgView).offset(-4);
            make.height.mas_equalTo(44);
        }];
        
    }
    
    return self;
}

- (void)clickAct:(UIButton *)sender{
    if (sender.tag == 100) {
        exit(0);
        return;
    }else if (sender.tag == 101){
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"isAgree"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appDelegate.launchCtrl dismissAtOnce];
        [self hide];
    }
    
    
}


@end
