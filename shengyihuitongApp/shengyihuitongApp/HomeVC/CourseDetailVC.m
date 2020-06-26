//
//  CourseDetailVC.m
//  shengyihuitongApp
//
//  Created by Mac on 2020/6/25.
//  Copyright © 2020 温州轩捷贸易有限公司. All rights reserved.
//

#import "CourseDetailVC.h"
#import "CourserCoverCell.h"
#import "FSScrollContentView.h"
#import "CouseIntroVC.h"
#import "CourseCateVC.h"
#import "CommentVC.h"
#import "CourseManager.h"
#import "BaseTableView.h"
#import "CourseDetailModel.h"
@interface CourseDetailVC ()<UITableViewDelegate,UITableViewDataSource,FSPageContentViewDelegate,FSPageContentViewDelegate,FSSegmentTitleViewDelegate>
@property (nonatomic, strong) FSSegmentTitleView *titleView;
@property (nonatomic, strong) FSPageContentView *pageContentView;
@property (nonatomic, strong) BaseTableView *listTableview;
@property (nonatomic, strong) CourseManager *manager;
@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, strong) CourseDetailModel *courseModel;
@end

@implementation CourseDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    
    [self getData];
}

- (void)setupUI{
    
    self.navigationItem.title = self.dic[@"course_name"];
    [self.view addSubview:self.listTableview];
    [self.listTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (void)getData{
    [self.manager getCourseInfoDataWithparameters:self.dic[@"course_id"] withCompletionHandler:^(NSError *error, MessageBody *result) {
        if (result.code == 1) {
//            self.dataDic = result.result;
            self.courseModel = result.result;
            
            [self.listTableview reloadData];
        }
    }];
}


#pragma mark --- UITableViewDelegata---
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.typeMuArray.count;
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *cellIde = @"CourserCoverCell";
        CourserCoverCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIde];
        if (!cell) {
            cell = [[CourserCoverCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellIde];
        }
        
//        [cell setupData:self.dataDic];
        cell.detailModel = self.courseModel;
        return cell;
    }else{
        static NSString *cellIde2 = @"cell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIde2];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellIde2];
            
        }else{
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            CouseIntroVC *vc = [CouseIntroVC new];
        
            CourseCateVC *vc2 = [CourseCateVC new];
            CommentVC *vc3 = [CommentVC new];
            vc.detailModel = self.courseModel;
            vc2.detailModel = self.courseModel;
            NSMutableArray *contentVCs = [NSMutableArray array];
            [contentVCs addObject:vc];
            [contentVCs addObject:vc2];
            [contentVCs addObject:vc3];
            self.pageContentView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, CGRectGetHeight(self.view.bounds)) childVCs:contentVCs parentVC:self delegate:self];
            
            [cell.contentView addSubview:self.pageContentView];
            
        }
        
       
           
            return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 200;
    }
    return CGRectGetHeight(self.view.bounds);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
         return self.titleView;
    }
    return UIView.new;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 45;
    }
    return CGFLOAT_MIN;
}


- (void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{

    self.pageContentView.contentViewCurrentIndex = endIndex;
}


- (void)FSContentViewDidScroll:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex progress:(CGFloat)progress
{

    

    
    [self.titleView setPageTitleViewWithProgress:progress originalIndex:startIndex targetIndex:endIndex];
   
//     _TabelView.scrollEnabled = YES;//此处其实是监测scrollview滚动，pageView滚动结束主tableview可以滑动，或者通过手势监听或者kvo，这里只是提供一种实现方式
}

- (BaseTableView *)listTableview{
    if (!_listTableview) {
        _listTableview = [[BaseTableView alloc] init];
        _listTableview.delegate=self;
        _listTableview.dataSource=self;
        _listTableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _listTableview.backgroundColor = UIColorEF;
        [_listTableview registerClass:[CourserCoverCell class] forCellReuseIdentifier:@"CourserCoverCell"];
        [_listTableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _listTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listTableview.estimatedRowHeight = 80;
        _listTableview.rowHeight = UITableViewAutomaticDimension;
    }
    
    return _listTableview;
}

- (FSSegmentTitleView *)titleView{
    if (!_titleView) {
        NSArray *titleArr = @[@"课程介绍",@"课程目录",@"评价"];
        self.titleView = [[FSSegmentTitleView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 45) titles:titleArr delegate:self indicatorType:FSIndicatorTypeCustom];
        self.titleView.titleSelectFont = LabelFont18;
        self.titleView.titleSelectColor = APPColor;
        self.titleView.titleNormalColor = UIColor90;
        self.titleView.indicatorColor = APPColor;
        self.titleView.backgroundColor = UIColor.whiteColor;
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
