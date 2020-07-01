//
//  NavigateVC.m
//  shengyihuitongApp
//
//  Created by Mac on 2020/6/25.
//  Copyright © 2020 mac. All rights reserved.
//

#import "NavigateVC.h"
#import "FSScrollContentView.h"
#import "JobVC.h"
#import "LiveVC.h"
@interface NavigateVC ()<FSPageContentViewDelegate,FSPageContentViewDelegate,FSSegmentTitleViewDelegate>
@property (nonatomic, strong) FSSegmentTitleView *titleView;
@property (nonatomic, strong) FSPageContentView *pageContentView;
@end

@implementation NavigateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setui];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//     self.view.backgroundColor = UIColorEF;
}

- (void)setui{
//    self.view.backgroundColor = UIColorEF;
    self.navigationItem.title = self.navTitle;
    NSArray *titleArr = @[@"班次",@"直播"];
    self.titleView = [[FSSegmentTitleView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 45) titles:titleArr delegate:self indicatorType:FSIndicatorTypeCustom];
    self.titleView.titleSelectFont = LabelFont16;
    self.titleView.titleSelectColor = APPColor;
    self.titleView.titleNormalColor = UIColor90;
    self.titleView.indicatorColor = APPColor;
    [self.view addSubview:self.titleView];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 43, Screen_Width, 1)];
    line.backgroundColor = UIColorEF;
    [self.view addSubview:line];
    
    JobVC *vc = [JobVC new];
    vc.jobId = self.jobid;
    [vc getData];
    LiveVC *vc2 = [LiveVC new];
    vc2.jobId = self.jobid;
    NSMutableArray *contentVCs = [NSMutableArray array];
    [contentVCs addObject:vc];
    [contentVCs addObject:vc2];
    self.pageContentView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0, 46, Screen_Width, CGRectGetHeight(self.view.bounds)) childVCs:contentVCs parentVC:self delegate:self];
    
    [self.view addSubview:self.pageContentView];
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
@end
