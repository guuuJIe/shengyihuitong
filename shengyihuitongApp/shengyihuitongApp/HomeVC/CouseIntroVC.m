//
//  CouseIntroVC.m
//  shengyihuitongApp
//
//  Created by Mac on 2020/6/26.
//  Copyright © 2020 mac. All rights reserved.
//

#import "CouseIntroVC.h"
#import "CourseIntroCell.h"
#import "WebContentCell.h"
@interface CouseIntroVC ()<UITableViewDelegate,UITableViewDataSource,WKNavigationDelegate,WKUIDelegate>
@property (nonatomic, strong) UITableView *listTableview;
@property (nonatomic, strong) NSString *htmlStr;
@property (nonatomic,assign) BOOL isFirstLoad;//只加载一次
@property (nonatomic,assign) CGFloat webViewCellHeight;
@end

@implementation CouseIntroVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.purpleColor;
    self.isFirstLoad = true;
    [self setupUI];
}

- (void)setupUI{
    [self.view addSubview:self.listTableview];
    [self.listTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}


//- (void)setDataDic:(NSDictionary *)dataDic{
//    _dataDic = dataDic;
//    self.htmlStr = [NSString stringWithFormat:@"%@",dataDic[@"intro"]];
//    [self.listTableview reloadData];
//}

- (void)setDetailModel:(CourseDetailModel *)detailModel{
    _detailModel = detailModel;
    self.htmlStr = detailModel.intro;
    [self.listTableview reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        static NSString *cellIde = @"CourseIntroCell";
        CourseIntroCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIde];
        if (!cell) {
            cell = [[CourseIntroCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellIde];
        }
        

        cell.detailModel = self.detailModel;
        return cell;
    }else{
        static NSString *cellIde = @"WebContentCell";
        WebContentCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIde];
        if (!cell) {
            cell = [[WebContentCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellIde];
        }
        
//        [cell setupData:self.dataDic];
        cell.wkwebView.navigationDelegate = self;//加载webview记得要开启网络
               cell.wkwebView.UIDelegate = self;
        if (self.htmlStr) {
          [cell.wkwebView loadHTMLString:[NSString stringWithFormat:@"<html><head><meta content=\"width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no;\" name=\"viewport\"><style>img{max-width: 100%%}</style></head><body>%@</body></html>",self.htmlStr] baseURL:nil];
        }
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  if (indexPath.row == 1){
        return self.webViewCellHeight + 20;
    }else{
        return UITableViewAutomaticDimension;
    }
}


#pragma mark - UIWebView Delegate Methods


- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    [webView evaluateJavaScript:@"document.body.offsetHeight" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        // 计算webView高度
        if (!self.webViewCellHeight && self.isFirstLoad) {
            self.webViewCellHeight = [result doubleValue];
            // 刷新tableView
            self.isFirstLoad = !self.isFirstLoad;
            [UIView performWithoutAnimation:^{
                [self.listTableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0],nil] withRowAnimation:UITableViewRowAnimationNone];
            }];
//            [self.listTableView reloadData];
            [JMBManager hideAlert];
        }
        
    }];
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
   
    JLog(@"子视图cell的偏移量%f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y <= 0) {

        scrollView.contentOffset = CGPointMake(0, 0);
       [[NSNotificationCenter defaultCenter] postNotificationName:@"leaveTop" object:nil];//到顶通知父视图改变状态
    }else{
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeTop" object:nil userInfo:@{@"yValue":@(scrollView.contentOffset.y)}];
    }

    self.listTableview.showsVerticalScrollIndicator = false;
}


- (UITableView *)listTableview{
    if (!_listTableview) {
        _listTableview = [[UITableView alloc] init];
        _listTableview.delegate=self;
        _listTableview.dataSource=self;
        _listTableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _listTableview.backgroundColor = UIColorEF;
        [_listTableview registerClass:[WebContentCell class] forCellReuseIdentifier:@"WebContentCell"];
        [_listTableview registerNib:[UINib nibWithNibName:@"CourseIntroCell" bundle:nil] forCellReuseIdentifier:@"CourseIntroCell"];
        [_listTableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _listTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listTableview.estimatedRowHeight = 80;
        _listTableview.rowHeight = UITableViewAutomaticDimension;
        _listTableview.showsVerticalScrollIndicator = false;
    }
    
    return _listTableview;
}

@end
