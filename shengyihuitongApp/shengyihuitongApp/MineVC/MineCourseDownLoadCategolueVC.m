//
//  MineCourseDownLoadCategolueVC.m
//  shengyihuitongApp
//
//  Created by 温州轩捷贸易有限公司 on 2020/6/29.
//  Copyright © 2020 温州轩捷贸易有限公司. All rights reserved.
//
#import <PLVVodSDK/PLVVodSDK.h>
#import "MineCourseDownLoadCategolueVC.h"
#import "CatelogueCell.h"
#import "CatelogueTitleView.h"
#import "MineCatalogueCell.h"
#import "CourseManager.h"
#import "AllSelView.h"
#import "TasksDownloaderOperation.h"
@interface MineCourseDownLoadCategolueVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *listTableview;
@property (nonatomic, strong) NSArray *resultArr;
@property (nonatomic, strong) CourseManager *manager;
@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, strong) CourseDetailModel *courseModel;
@property (nonatomic, strong) AllSelView *selView;
@property (nonatomic, strong) NSMutableArray *modelArr;
@property (nonatomic, strong) TasksDownloaderOperation *lastOp;
@property (strong, nonatomic) NSOperationQueue *downloadQueue;
@end

@implementation MineCourseDownLoadCategolueVC

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
    
    [self.view addSubview:self.selView];
    [self.selView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
}





- (void)getData{
    [self.manager getCourseInfoDataWithparameters:self.dic[@"course_id"] withCompletionHandler:^(NSError *error, MessageBody *result) {
        if (result.code == 1) {

            self.courseModel = result.result;
    
            [self.listTableview reloadData];
        }
    }];
}



#pragma mark --- UITableViewDelegate ----

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.courseModel.chapter_list.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    Chapter_list *chapter  = self.courseModel.chapter_list[section];

    return chapter.child_list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    static NSString *cellIde = @"MineCatalogueCell";
    MineCatalogueCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIde];
    if (!cell) {
        cell = [[MineCatalogueCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellIde];
    }
    Chapter_list *chapter  = self.courseModel.chapter_list[indexPath.section];

    cell.detailModel = chapter.child_list[indexPath.row];
    [self courseSel:cell withChapter:chapter.child_list[indexPath.row]];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    Chapter_list *chapter  = self.courseModel.chapter_list[section];
    CatelogueTitleView *titleView = [CatelogueTitleView new];
    titleView.titleLabel.text = chapter.chapter_name;
    return titleView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 55.0f;
}

- (void)courseSel:(MineCatalogueCell *)cell withChapter:(Child_list *)model{
    cell.clickRowBlock = ^(BOOL isClick) {
         model.isSel = !model.isSel;
        if (model.isSel) {
            if ([self.modelArr containsObject:model]) {
                [self.modelArr removeObject:model];
                return ;
            }
            [self.modelArr addObject:model];
        }else{
            if ([self.modelArr containsObject:model]) {
                [self.modelArr removeObject:model];
            }
        }
    };
    
//    [self.listTableview reloadData];
}


- (void)downloadVideo:(PLVVodVideo *)video {
    PLVVodDownloadManager *downloadManager = [PLVVodDownloadManager sharedManager];
    PLVVodDownloadInfo *info = [downloadManager downloadVideo:video];
    
#ifdef PLVSupportDownloadAudio
    // 音频下载测试入口，需要音频下载功能客户，放开注释
    [downloadManager downloadAudio:video];
    
#endif
    
    if (info) NSLog(@"%@ - %zd 已加入下载队列", info.video.vid, info.quality);
}


- (UITableView *)listTableview{
    if (!_listTableview) {
        _listTableview = [[UITableView alloc] init];
        _listTableview.delegate=self;
        _listTableview.dataSource=self;
        _listTableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _listTableview.backgroundColor = UIColorEF;
        [_listTableview registerClass:[MineCatalogueCell class] forCellReuseIdentifier:@"MineCatalogueCell"];
        _listTableview.showsVerticalScrollIndicator = false;
        [_listTableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _listTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listTableview.estimatedRowHeight = 80;
        _listTableview.rowHeight = UITableViewAutomaticDimension;
    }
    
    return _listTableview;
}


- (CourseManager *)manager{
    if (!_manager) {
        _manager = [CourseManager new];
    }
    
    return _manager;
}


- (AllSelView *)selView{
    if (!_selView) {
        _selView = [AllSelView new];
        WeakSelf(self)
        _selView.clickRowBlock = ^(BOOL isClick) {
            StrongSelf(self)
//            if (isClick) {
            [self.modelArr removeAllObjects];
                NSArray *arry = self.courseModel.chapter_list;
                for (int i  = 0; i<arry.count ; i++) {
                    Chapter_list *model = arry[i];
                    for (int j = 0; j < model.child_list.count; j++) {
                        Child_list *childModel = model.child_list[j];
                        childModel.isSel = isClick;
                        if (childModel.isSel) {
                            [self.modelArr addObject:childModel];
                        }else{
                            [self.modelArr removeObject:childModel];
                        }
                    }
                }
                [self.listTableview reloadData];
//            }
        };
        
        _selView.downloadBlock = ^{
            StrongSelf(self)
            if (self.modelArr.count == 0) {
                [JMBManager showBriefAlert:@"请选择你要下载的视频"];
                return ;
            }
            JLog(@"%@",self.modelArr);
            [self.modelArr enumerateObjectsUsingBlock:^(Child_list  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                __block TasksDownloaderOperation *op = [[TasksDownloaderOperation alloc] initWithTask:^{
                    JLog(@"%@",obj.chapter_name);
                    [PLVVodVideo requestVideoPriorityCacheWithVid:obj.video_id completion:^(PLVVodVideo *video, NSError *error) {
                        if (video.available){
                            [self downloadVideo:video];
                        }
                        [op done];
                    }];
                    
                }];
                
                [self.downloadQueue addOperation:op];
                
                [self.lastOp addDependency:op];
                self.lastOp = op;
            }];
            

        };
    }
    
    return _selView;
}

- (NSMutableArray *)modelArr{
    if (!_modelArr) {
        _modelArr = [NSMutableArray array];
    }
    
    return _modelArr;
}

- (NSOperationQueue *)downloadQueue{
    if (!_downloadQueue) {
        _downloadQueue = [NSOperationQueue new];
    }
    
    return _downloadQueue;
}
@end
