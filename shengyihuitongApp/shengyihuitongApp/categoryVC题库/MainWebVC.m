//
//  MainWebVC.m
//  shengyihuitongApp
//
//  Created by mac on 2020/6/24.
//  Copyright © 2020 mac. All rights reserved.
//

#import "MainWebVC.h"
#import <WebKit/WebKit.h>
@interface MainWebVC ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *wkwebView;

@end



@implementation MainWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}


- (void)setupUI{
  
    [self.view addSubview:self.wkwebView];
    [self.wkwebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    UIButton *button = [UIButton new];
    [button setTitle:@"返回" forState:0];
    [button setTitleColor:UIColor333 forState:0];
    [button.titleLabel setFont:LabelFont15];
    button.layer.borderColor = UIColor333.CGColor;
    button.layer.borderWidth = 1;
    button.layer.cornerRadius = 30;
    [self.view addSubview:button];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-65);
        make.right.mas_equalTo(-15);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];

}

- (void)setUrlString:(NSString *)urlString{
    NSURLRequest *url = [[NSURLRequest alloc] initWithURL:URL(urlString)];
    [self.wkwebView loadRequest:url];
}

- (void)click{
    [self.navigationController popViewControllerAnimated:true];
}

- (WKWebView *)wkwebView {
    if (!_wkwebView) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        // 偏好设置
        config.preferences = [[WKPreferences alloc] init];
        config.preferences.minimumFontSize = 10;
        config.preferences.javaScriptEnabled = YES;
        config.preferences.javaScriptCanOpenWindowsAutomatically = NO;


        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
//        WKUserScript *cookieScript = [[WKUserScript alloc] initWithSource:cookie injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
//        [userContentController addUserScript:cookieScript];

//        [userContentController addScriptMessageHandler:self name:@"share"];
//        [userContentController addScriptMessageHandler:self name:@"login"];

        config.userContentController = userContentController;
        config.selectionGranularity = WKSelectionGranularityDynamic;
        config.allowsInlineMediaPlayback = YES;
//        config.mediaTypesRequiringUserActionForPlayback = false;
        
      
        _wkwebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
        
        _wkwebView.navigationDelegate = self;//导航代理
        _wkwebView.UIDelegate = self;//UI代理
        _wkwebView.backgroundColor = [UIColor whiteColor];
        _wkwebView.allowsBackForwardNavigationGestures = YES;
        _wkwebView.scrollView.scrollEnabled = false;
        _wkwebView.scrollView.showsVerticalScrollIndicator = false;
        
       
    }
    return _wkwebView;
}

@end
