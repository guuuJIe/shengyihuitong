//
//  MineCourseDownLoadCategolueVC.m
//  shengyihuitongApp
//
//  Created by mac on 2020/6/29.
//  Copyright © 2020 mac. All rights reserved.
//
#import <PLVVodSDK/PLVVodSDK.h>
#import "MineCourseDownLoadCategolueVC.h"
#import "CatelogueCell.h"
#import "CatelogueTitleView.h"
#import "MineCatalogueCell.h"
#import "CourseManager.h"
#import "AllSelView.h"
#import "TasksDownloaderOperation.h"
#import "NSObject+BGModel.h"
#import "MineDownloadVC.h"
#import "PLVVodDownloadInfo+extension.h"
#import "PLVDownloadCompleteInfoModel.h"
#import "DownloadModel.h"
@interface MineCourseDownLoadCategolueVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *listTableview;
@property (nonatomic, strong) NSArray *resultArr;
@property (nonatomic, strong) CourseManager *manager;
@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, strong) CourseDetailModel *courseModel;
@property (nonatomic, strong) AllSelView *selView;
@property (nonatomic, strong) NSMutableArray *modelArr;
@property (nonatomic, strong) TasksDownloaderOperation *lastOp;
@property (nonatomic, strong) NSOperationQueue *downloadQueue;
@property (nonatomic, strong) CourseDetailModel *tempModel;
@property (nonatomic, strong) CourseDetailModel *thirdModel;
@property (nonatomic, strong) dispatch_semaphore_t semaphore;
@property (nonatomic, strong) DownloadModel *loadModel;
@property (nonatomic, strong) NSArray<PLVVodDownloadInfo *> *downloadInfos;
@end

@implementation MineCourseDownLoadCategolueVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];

    [self getData];
    
    [self getDownloadProcessingData];
    
}

- (void)setupUI{
    
    self.navigationItem.title = self.dic[@"course_name"];
    [self.view addSubview:self.listTableview];
    [self.listTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(-50-BottomAreaHeight);
    }];
    
    [self.view addSubview:self.selView];
    [self.selView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(50+BottomAreaHeight);
    }];
}


- (void)getData{
    [self.manager getCourseInfoDataWithparameters:self.dic[@"course_id"] withCompletionHandler:^(NSError *error, MessageBody *result) {
        if (result.code == 1) {
            CourseDetailModel *model = (CourseDetailModel *)result.result;
            self.courseModel =[model mutableCopy] ;
            self.tempModel = [model mutableCopy];
            self.thirdModel = [model mutableCopy];
            self.thirdModel.chapter_list = [NSMutableArray array];
//            self.tempModel.bg_tableName = mytableName;
            [self.listTableview reloadData];
        }
    }];
}

- (void)getDownloadProcessingData{
//    [[PLVVodDownloadManager sharedManager] requstDownloadProcessingListWithCompletion:^(NSArray<PLVVodDownloadInfo *> *downloadInfos) {
//                  if (downloadInfos.count != 0) {
//                      [JMBManager showBriefAlert:@""];
//                      return <#expression#>
//                  }
//              }];
    
//    [PLVVodDownloadInfo bg_drop:mytableName];
//    [PLVDownloadCompleteInfoModel bg_drop:mytableName];
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

    [self courseSel:cell withNSIndexPath:indexPath andCurrentModel:self.tempModel];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    Chapter_list *chapter  = self.courseModel.chapter_list[section];
    CatelogueTitleView *titleView = [CatelogueTitleView new];
    titleView.titleLabel.text = chapter.chapter_name;
    return titleView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return UITableViewAutomaticDimension;
}

- (void)courseSel:(MineCatalogueCell *)cell withNSIndexPath:(NSIndexPath *)indexPath andCurrentModel:(CourseDetailModel *)tempModel{
    
//    CourseDetailModel *selfModel = self.courseModel;
    Chapter_list *chapter  = self.courseModel.chapter_list[indexPath.section];
    Child_list *model = chapter.child_list[indexPath.row];
    
    WeakSelf(self)
    cell.clickRowBlock = ^(BOOL isClick) {
        model.isSel = !model.isSel;
        model.chapter_name = chapter.chapter_name;
        StrongSelf(self)
        if (model.isSel) {
            [self.modelArr addObject:model];
        }else{
            if ([self.modelArr containsObject:model]) {
                [self.modelArr removeObject:model];
            }
        }
        
        
        
        
//        NSMutableArray <Child_list *> *dataArray = [NSMutableArray array];
//        model.isSel = !model.isSel;
//        if (model.isSel) {
//            /*
//             *
//             先遍历选中的课程数组
//             如果有选中 加入新的数组 新的childlist
//             */
//            [chapter.child_list enumerateObjectsUsingBlock:^(Child_list * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                if (obj.isSel) {
//                    [dataArray addObject:obj];
//                    chapter.itemIsSel = true;//标记有子数组选中 把章节设为true
//                }
//
//            }];
//
//            NSMutableArray *tempdata = [NSMutableArray arrayWithArray:self.tempModel.chapter_list];
//            NSArray<Chapter_list *> *deepArray= [[NSArray alloc] initWithArray:tempdata copyItems:true];
//            NSMutableArray *datas = [NSMutableArray arrayWithArray:deepArray];
//
//            [datas replaceObjectAtIndex:indexPath.section withObject:chapter.mutableCopy];
//
//
//            Chapter_list *mychapter = datas[indexPath.section];
//            mychapter.child_list = dataArray;
//
//            //这是遍历记录了选中的章节
//            for (int i = 0; i < self.thirdModel.chapter_list.count; i++) {
//                Chapter_list *subChapter = self.thirdModel.chapter_list[i];
//                if ([subChapter.chapter_name isEqualToString:mychapter.chapter_name]) {
//                    [self.thirdModel.chapter_list replaceObjectAtIndex:i withObject:mychapter];
//                    return ;
//                }
//            }
//            [self.thirdModel.chapter_list addObject:mychapter];
//
//            JLog(@"%lu",(unsigned long)self.thirdModel.chapter_list.count);
//
//        }else{
//            JLog(@"%ld %ld",(long)indexPath.section,indexPath.row);
//            Chapter_list *curChapter = self.thirdModel.chapter_list[indexPath.section];
//            [curChapter.child_list replaceObjectAtIndex:indexPath.row withObject:model];
//            [curChapter.child_list enumerateObjectsUsingBlock:^(Child_list * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                if (obj.isSel) {
//                    [dataArray addObject:obj];
//                    curChapter.itemIsSel = true;//标记有子数组选中 把章节设为true
//                }
//
//            }];
//
//            if (dataArray.count == 0) {
//                curChapter.itemIsSel = false;
//            }
//
//            NSArray<Chapter_list *> *deepArray= [[NSArray alloc] initWithArray:self.tempModel.chapter_list copyItems:true];
//            [deepArray enumerateObjectsUsingBlock:^(Chapter_list * _Nonnull chapterModel, NSUInteger idx, BOOL * _Nonnull stop) {
//                if (!chapterModel.itemIsSel) {
//                    chapterModel.child_list = [NSMutableArray array];
//                }
//            }];
//
//            NSMutableArray *array = [NSMutableArray arrayWithArray:deepArray];
//            for (Chapter_list *model in deepArray) {
//                if (model.child_list.count == 0) {
//                    [array removeObject:model];
//                }
//            }
//
//            self.thirdModel.chapter_list = array;
//
//            CourseDetailModel *modealllll = self.thirdModel;
//            JLog(@"下载的数据%@",modealllll);
//        }
    };

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
                    childModel.chapter_name = model.chapter_name;
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
            
            NSString *where = [NSString stringWithFormat:@"where %@=%@ and %@>%@ and %@=%@",bg_sqlKey(@"userPhone"),bg_sqlValue(userMobile),bg_sqlKey(@"downloading_num"),bg_sqlValue(@0),bg_sqlKey(@"course_id"),bg_sqlValue(@(self.courseModel.course_id))];
            [DownloadModel bg_findAsync:mytableName where:where complete:^(NSArray * _Nullable array) {
                JLog(@"%@",array);
                if (array.count != 0) {
                    [JMBManager showBriefAlert:@"请等待当前课程任务下载完毕"];
                }else{
                    //这是当前科目的title 主表存着子课程
                    DownloadModel *model = [DownloadModel new];
                    model.course_id = self.courseModel.course_id;
                    model.course_img = self.courseModel.course_img;
                    model.course_name = self.courseModel.course_name;
                    model.userPhone =userMobile;
                    model.statues = 0;
                    model.downloading_num = self.modelArr.count;
                    model.downloadingList = self.modelArr; //用来存下载中视频的信息

//                    if (![DownloadModel bg_isExistForTableName:mytableName]) {
                    model.bg_tableName = mytableName;//不知道会不会在创建
//                    }

                    [model bg_save];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        MineDownloadVC *vc = [MineDownloadVC new];
                        [self.navigationController pushViewController:vc animated:true];
                    });

                }
                
            }];

//            [self.modelArr enumerateObjectsUsingBlock:^(Child_list  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                __block TasksDownloaderOperation *op = [[TasksDownloaderOperation alloc] initWithTask:^{
//                    JLog(@"%@",obj.chapter_name);
//                    [PLVVodVideo requestVideoPriorityCacheWithVid:obj.video_id completion:^(PLVVodVideo *video, NSError *error) {
//                        if (video.available){
//                            [self downloadVideo:video];
//                        }
//
//                        [op done];
//
//                    }];
//
//                }];
//
//                [self.downloadQueue addOperation:op];
//                [self.lastOp addDependency:op];
//                self.lastOp = op;
//
//            }];
//            [self.downloadQueue waitUntilAllOperationsAreFinished];
//

        };
    }
    
    return _selView;
}

//- (void)downloadVideo:(PLVVodVideo *)video {
//    PLVVodDownloadManager *downloadManager = [PLVVodDownloadManager sharedManager];
//    PLVVodDownloadInfo *info = [downloadManager downloadVideo:video];
//
//#ifdef PLVSupportDownloadAudio
//    // 音频下载测试入口，需要音频下载功能客户，放开注释
//    [downloadManager downloadAudio:video];
//
//#endif
//
//    if (info){
//      NSLog(@"%@ - %zd 已加入下载队列", info.video.vid, info.quality);
//        PLVDownloadCompleteInfoModel *model = [PLVDownloadCompleteInfoModel new];
//        model.downloadInfo = info;
//        model.userPhone = userMobile;
//
////        [PLVVodDownloadInfo bg_drop:mytableName];
////        [PLVDownloadCompleteInfoModel bg_drop:mytableName];
//        model.bg_tableName = mytableName;
//        model.stautes = 0;
//        model.localVideo = [PLVVodLocalVideo localVideoWithVideo:info.video dir:[PLVVodDownloadManager sharedManager].downloadDir];
//        model.identifier = info.identifier;
//        [model bg_save];
//
//
//    }
//}
//


- (NSMutableArray *)modelArr{
    if (!_modelArr) {
        _modelArr = [NSMutableArray array];
    }
    
    return _modelArr;
}

- (NSOperationQueue *)downloadQueue{
    if (!_downloadQueue) {
        _downloadQueue = [NSOperationQueue new];
        _downloadQueue.maxConcurrentOperationCount = 1;
    }
    
    return _downloadQueue;
}

- (dispatch_semaphore_t)semaphore{
    if (!_semaphore) {
        _semaphore = dispatch_semaphore_create(1);
    }
    
    return _semaphore;
}
@end
