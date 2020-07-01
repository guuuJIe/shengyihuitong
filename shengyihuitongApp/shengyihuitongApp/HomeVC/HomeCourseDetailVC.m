//
//  HomeCourseDetailVC.m
//  shengyihuitongApp
//
//  Created by Mac on 2020/6/26.
//  Copyright © 2020 mac. All rights reserved.
//

#import "HomeCourseDetailVC.h"
#import "CourseDetailSectionOneCell.h"
#import "CourseListItemCell.h"
#import "CourseTitleView.h"
#import "CourseManager.h"
#import "SquadModel.h"
#import "WebContentCell.h"
#import "CourseTitleView.h"
#import "CourseDetailVC.h"
@interface HomeCourseDetailVC ()<UITableViewDelegate,UITableViewDataSource,WKNavigationDelegate,WKUIDelegate>
@property (nonatomic, strong) UITableView *listTableview;
@property (nonatomic, strong) CourseTitleView *titleView;
@property (nonatomic, strong) CourseManager *manager;
@property (nonatomic, strong) SquadModel *squModel;
@property (nonatomic, strong) NSString *htmlStr;
@property (nonatomic, assign) BOOL isFirstLoad;//只加载一次
@property (nonatomic, assign) CGFloat webViewCellHeight;
@end

@implementation HomeCourseDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self getData];
}


- (void)setupUI{
    self.navigationItem.title = self.dic[@"squad_name"];
    [self.view addSubview:self.listTableview];
    [self.listTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (void)getData{
    self.isFirstLoad = true;
    [JMBManager showLoading];
    [self.manager getSquadListDataWithparameters:self.dic[@"squad_id"] == nil ? self.dic[@"goods_id"] : self.dic[@"squad_id"] withCompletionHandler:^(NSError *error, MessageBody *result) {
        if (result.code == 1) {
            self.squModel = result.result;
            
            [self.listTableview reloadData];
        }
        
        [JMBManager hideAlert];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.typeMuArray.count;
    if (section == 1) {
        return self.squModel.course_list.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *cellIde = @"CourseDetailSectionOneCell";
        CourseDetailSectionOneCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIde];
        if (!cell) {
            cell = [[CourseDetailSectionOneCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellIde];
        }
        cell.sModel = self.squModel;
        return cell;
    }else if (indexPath.section == 1){
        static NSString *cellIde = @"CourseListItemCell";
        CourseListItemCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIde];
        if (!cell) {
            cell = [[CourseListItemCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellIde];
        }
        cell.couserModel = self.squModel.course_list[indexPath.row];
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
        if (self.squModel) {
            [cell.wkwebView loadHTMLString:[NSString stringWithFormat:@"<html><head><meta content=\"width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no;\" name=\"viewport\"><style>img{max-width: 100%%}</style></head><body>%@</body></html>",self.squModel.intro] baseURL:nil];
        }
        return cell;
    }
    
    return nil;
}




- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return self.titleView;
    }
    
    if (section == 2) {
        CourseTitleView *titleView = [CourseTitleView new];
        titleView.titleLabel.text = @"班次简介";
        return titleView;
    }
    
    return UIView.new;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1 || section == 2) {
        return 55.0f;
    }
    
   
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        return self.webViewCellHeight+30;
    }
    
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        CourseDetailVC *vc = CourseDetailVC.new;
        Course_list *course = self.squModel.course_list[indexPath.row];
        vc.dic = course.mj_keyValues;
        [self.navigationController pushViewController:vc animated:true];
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
                [self.listTableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:2],nil] withRowAnimation:UITableViewRowAnimationNone];
            }];
//            [self.listTableView reloadData];
            [JMBManager hideAlert];
        }
        
    }];
    
    
}

- (UITableView *)listTableview{
    if (!_listTableview) {
        _listTableview = [[UITableView alloc] init];
        _listTableview.delegate=self;
        _listTableview.dataSource=self;
        _listTableview.estimatedRowHeight = 80;
        _listTableview.rowHeight = UITableViewAutomaticDimension;
        _listTableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _listTableview.backgroundColor = UIColorEF;
        [_listTableview registerNib:[UINib nibWithNibName:@"CourseDetailSectionOneCell" bundle:nil] forCellReuseIdentifier:@"CourseDetailSectionOneCell"];
        [_listTableview registerClass:[CourseListItemCell class] forCellReuseIdentifier:@"CourseListItemCell"];
        [_listTableview registerClass:[WebContentCell class] forCellReuseIdentifier:@"WebContentCell"];
        [_listTableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _listTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    
    return _listTableview;
}

- (CourseTitleView *)titleView{
    if (!_titleView) {
        _titleView = [CourseTitleView new];
    }
    
    return _titleView;
}

- (CourseManager *)manager{
    if (!_manager) {
        _manager = [CourseManager new];
    }
    
    return _manager;
}
@end
