//
//  CourseDetailVC.m
//  shengyihuitongApp
//
//  Created by Mac on 2020/6/25.
//  Copyright © 2020 mac. All rights reserved.
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
#import "CommonView.h"
#import "VideoPLayVC.h"

@interface CourseDetailVC ()<UITableViewDelegate,UITableViewDataSource,FSPageContentViewDelegate,FSPageContentViewDelegate,FSSegmentTitleViewDelegate>
@property (nonatomic, strong) FSSegmentTitleView *titleView;
@property (nonatomic, strong) FSPageContentView *pageContentView;
@property (nonatomic, strong) BaseTableView *listTableview;
@property (nonatomic, strong) CourseManager *manager;
@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, strong) CourseDetailModel *courseModel;



@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, assign) BOOL cellScroll;
@property (nonatomic, assign) CGFloat curContentoffset;
@property (nonatomic, strong) CommonView *commView;


@property (nonatomic, strong) PLVVodSkinPlayerController *player;
@property (nonatomic, strong) UIView *playerPlaceholder;
@end

@implementation CourseDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupUI];
    
    [self getData];
    
    
   
//    [self.view addSubview:self.playerPlaceholder];
//    [self initVideo];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh:) name:@"refreshFullScreen" object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     self.view.backgroundColor = UIColor.whiteColor;
}

- (void)setupUI{
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationItem.title = self.dic[@"course_name"];
    [self.view addSubview:self.listTableview];
    [self.listTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(0);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollStatus) name:@"leaveTop" object:nil];
    
    
    [self.view addSubview:self.commView];
    [self.commView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(50+BottomAreaHeight);
    }];
}

- (void)getData{
    [JMBManager showLoading];
    [self.manager getCourseInfoDataWithparameters:self.dic[@"course_id"] withCompletionHandler:^(NSError *error, MessageBody *result) {
        if (result.code == 1) {
//            self.dataDic = result.result;
            self.courseModel = result.result;
            
            
            
            self.commView.hidden = !self.courseModel.hav_buy;
            [self.listTableview reloadData];
//            if (self.courseModel.hav_buy) {
//                self.commView.hidden = false;
//                return ;
//            }
//            
//            if (self.courseModel.is_free) {
//                self.commView.hidden = false;
//                return;
//            }
        }
        
        [JMBManager hideAlert];
    }];
    
   
}


- (void)changeScrollStatus//改变主视图的状态
{
    self.canScroll = YES;

}

//- (void)refresh:(NSNotification *)noti{
//    JLog(@"%@",noti.object);
////
//    NSDictionary *dic = noti.object;
//    [PLVVodVideo requestVideoWithVid:dic[@"video_id"] completion:^(PLVVodVideo *video, NSError *error) {
//        if (!video) {
//            [JMBManager showBriefAlert:@"视频加载失败"];
//            return ;
//        }
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.player.view.hidden = false;
//            [self.player setPlayerFullScreen:true];
//            self.player.video = video;
//        });
//
//
//    }];
//}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
            vc3.detailModel = self.courseModel;
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
        return 55;
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


//- (void)initVideo{
//
//    PLVVodSkinPlayerController *player = [[PLVVodSkinPlayerController alloc] init];
//
//    [player addPlayerOnPlaceholderView:self.playerPlaceholder rootViewController:self];
//    player.view.hidden = true;
//    player.rememberLastPosition = YES;
//    player.enableBackgroundPlayback = false;
////    [player setPlayerFullScreen:true];
//    player.videoCaptureProtect = true;
////    player.autoplay = true;
//    self.player = player;
//
//    if (self.isOffline) {
//        // 离线视频播放
//        WeakSelf(self)
//
//        // 根据资源类型设置默认播放模式。本地音频文件设定音频播放模式，本地视频文件设定视频播放模式
//        // 只针对开通视频转音频服务的用户
//        self.player.playbackMode = self.playMode;
//
//        [PLVVodVideo requestVideoPriorityCacheWithVid:self.vid completion:^(PLVVodVideo *video, NSError *error) {
//            weakself.player.video = video;
//            dispatch_async(dispatch_get_main_queue(), ^{
//                weakself.title = video.title;
//            });
//        }];
//    }else{
////        if (!self.videoId) {
////            [JMBManager showBriefAlert:@"无videoId"];
////            return;
////        }
////
////
//    }
//
//
//
//}




- (BOOL)prefersStatusBarHidden {
    return self.player.prefersStatusBarHidden;
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.player.preferredStatusBarStyle;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{

    return UIInterfaceOrientationMaskPortrait;

}




#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGRect rectsize = [self.listTableview rectForSection:1];
    JLog(@"%f   ---   %f ---   %f",scrollView.contentOffset.y, rectsize.size.height,rectsize.origin.y);
    CGFloat value = scrollView.contentOffset.y;
    CGFloat limit = rectsize.origin.y ;

    
    if (value >= limit) {
        
        scrollView.contentOffset = CGPointMake(0, limit);
        if (self.cellScroll) {
            _curContentoffset = limit;
            _canScroll = false;
            _cellScroll = false;
        }
        
        
    }else{
        
        if (value<=0) {
            scrollView.contentOffset = CGPointMake(0, 0);
            _cellScroll = true;
        }
        
        if (!self.canScroll && _curContentoffset) {
            scrollView.contentOffset = CGPointMake(0, limit);
            
            JLog(@"执行了");
        }
    }

   
}

- (BaseTableView *)listTableview{
    if (!_listTableview) {
        _listTableview = [[BaseTableView alloc] init];
        _listTableview.delegate=self;
        _listTableview.dataSource=self;
        _listTableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _listTableview.backgroundColor = UIColor.whiteColor;
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

- (CommonView *)commView{
    if (!_commView) {
        _commView = [CommonView new];
        WeakSelf(self)
        _commView.actBlock = ^{
            VideoPLayVC *vc = [VideoPLayVC new];
            
            if (weakself.courseModel.last_video_chapter_id == 0) {
                Chapter_list *model = weakself.courseModel.chapter_list.firstObject;
                Child_list *childModle = model.child_list.firstObject;
                vc.videoId = childModle.video_id;
            }else{
                Child_list *tempModel;
                for (Chapter_list *chapter in weakself.courseModel.chapter_list) {
                    for (Child_list *submodel in chapter.child_list) {
                        if (submodel.chapter_id == weakself.courseModel.last_video_chapter_id) {
                            tempModel = submodel;
                        }
                    }
                }
                
                vc.videoId = tempModel.video_id;
            }
            
          

            [weakself.navigationController pushViewController:vc animated:true];
        };
        _commView.hidden = true;
    }
    
    return _commView;
}

@end
