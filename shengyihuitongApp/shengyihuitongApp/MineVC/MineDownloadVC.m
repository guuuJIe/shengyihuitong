//
//  MineDownloadVC.m
//  shengyihuitongApp
//
//  Created by mac on 2020/6/29.
//  Copyright © 2020 mac. All rights reserved.
//

#import "MineDownloadVC.h"
#import "FSScrollContentView.h"
#import "VideoDownloadProcessingVC.h"
#import "VideoDownloadCompelteVC.h"
#import "MineDownloadCategolueVC.h"
@interface MineDownloadVC ()<FSPageContentViewDelegate,FSPageContentViewDelegate,FSSegmentTitleViewDelegate>
@property (nonatomic, strong) FSSegmentTitleView *titleView;
@property (nonatomic, strong) FSPageContentView *pageContentView;
@end

@implementation MineDownloadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的下载";
    self.view.backgroundColor = UIColorEF;
    [self setui];
}

- (void)setui{
    self.view.backgroundColor = UIColorEF;
    NSArray *titleArr = @[@"下载中",@"已下载"];
    self.titleView = [[FSSegmentTitleView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 45) titles:titleArr delegate:self indicatorType:FSIndicatorTypeCustom];
    self.titleView.titleSelectFont = LabelFont16;
    self.titleView.titleSelectColor = APPColor;
    self.titleView.titleNormalColor = UIColor90;
    self.titleView.indicatorColor = APPColor;
    self.titleView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.titleView];

    
    VideoDownloadProcessingVC *vc = [VideoDownloadProcessingVC new];
//    MineDownloadCategolueVC *vc = [MineDownloadCategolueVC new];
    VideoDownloadCompelteVC *vc2 = [VideoDownloadCompelteVC new];
//    vc2.jobId = self.jobid;
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

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{

    return UIInterfaceOrientationMaskPortrait;

}


@end
