//
//  WebContentCell.m
//  shengyihuitongApp
//
//  Created by Mac on 2020/6/26.
//  Copyright © 2020 温州轩捷贸易有限公司. All rights reserved.
//

#import "WebContentCell.h"

@implementation WebContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.backgroundColor = [UIColor purpleColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupLayout];
    }
    return self;
}

- (void)setupLayout{
    
    [self.contentView addSubview:self.wkwebView];
    [self.wkwebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    
}

//- (void)setupData:(NSDictionary *)dic{
//    if (dic) {
//        NSString *html = [NSString stringWithFormat:@"%@",dic[@"intro"]];
//        [self.wkwebView loadHTMLString:html baseURL:nil];
//    }
//}

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
        
      
        _wkwebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 1)];
        
//        _wkwebView.navigationDelegate = self;//导航代理
//        _wkwebView.UIDelegate = self;//UI代理
        _wkwebView.backgroundColor = [UIColor whiteColor];
        _wkwebView.allowsBackForwardNavigationGestures = YES;
        _wkwebView.scrollView.scrollEnabled = false;
       
    }
    return _wkwebView;
}

@end
