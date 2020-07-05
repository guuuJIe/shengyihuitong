//
//  MineDownloadCateDetailCourseVC.m
//  shengyihuitongApp
//
//  Created by Mac on 2020/7/5.
//  Copyright © 2020 温州轩捷贸易有限公司. All rights reserved.
//

#import "MineDownloadCateDetailCourseVC.h"
#import <PLVVodSDK/PLVVodSDK.h>
#import "UIColor+PLVVod.h"
#import <PLVTimer/PLVTimer.h>
#import "PLVDownloadProcessingCell.h"
#import "PLVDownloadCompleteInfoModel.h"
#import "TasksDownloaderOperation.h"
#import "PLVDownloadCompleteInfoModel.h"
@interface MineDownloadCateDetailCourseVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<DownloadInfo *> *downloadInfos;
//@property (nonatomic, strong) NSMutableArray<PLVVodDownloadInfo *> *downloadInfos;
@property (nonatomic, strong) NSMutableDictionary<NSString *, PLVDownloadProcessingCell *> *downloadItemCellDic;

@property (nonatomic, strong) PLVTimer *timer;

@property (nonatomic, strong) UIButton *queueDownloadButton;
@property (nonatomic, strong) UIButton *cleanDownloadButton;

@property (nonatomic, strong) UIView *emptyView;
@property (nonatomic, strong) PLVVodDownloadManager *downloadManager;
@property (nonatomic, strong) NSOperationQueue *downloadQueue;
@property (nonatomic, strong) TasksDownloaderOperation *lastOp;

//@property (nonatomic, strong) NSArray <DownloadInfo *> *downloadedArr;
@end

static NSInteger downloaded = 0;

@implementation MineDownloadCateDetailCourseVC


- (void)dealloc {
    [self.timer cancel];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
//    PLVVodDownloadManager *downloadManager = [PLVVodDownloadManager sharedManager];

//    self.navigationController.title = self.lastDownModel.course_name;
    
    [self searchCacheData];
    
    // 所有下载完成回调
    self.downloadManager.completeBlock = ^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//            weakSelf.queueDownloadButton.selected = NO;
//        });
//        NSString *where = [NSString stringWithFormat:@"set %@=%@ where %@=%@ and %@=%@",bg_sqlKey(@"stautes"),bg_sqlValue(@1),bg_sqlKey(@"userPhone"),bg_sqlValue(userMobile),bg_sqlKey(@"course_id"),bg_sqlValue(@(weakSelf.lastDownModel.course_id))];
//        [DownloadModel bg_update:mytableName where:where];
    };
//    self.queueDownloadButton.selected = [PLVVodDownloadManager sharedManager].isDownloading;
    self.tableView = [UITableView new];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(0);
    }];
    [self.tableView registerClass:[PLVDownloadProcessingCell class] forCellReuseIdentifier:[PLVDownloadProcessingCell identifier]];
    self.tableView.backgroundColor = [UIColor themeBackgroundColor];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.allowsSelection = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.estimatedRowHeight = 92;
//    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    
   
    
    UILabel *emptyLabel = [[UILabel alloc] init];
    emptyLabel.text = @"暂无缓存视频";
    emptyLabel.textAlignment = NSTextAlignmentCenter;
    self.emptyView = emptyLabel;
    

}


- (void)setLastDownModel:(DownloadModel *)lastDownModel{
    _lastDownModel = lastDownModel;
    self.title = lastDownModel.course_name;
}

- (void)getData{
    
    NSString *where = [NSString stringWithFormat:@"set %@=%@ where %@=%@ and %@=%@",bg_sqlKey(@"isfirst"),bg_sqlValue(@1),bg_sqlKey(@"userPhone"),bg_sqlValue(userMobile),bg_sqlKey(@"course_id"),bg_sqlValue(@(self.lastDownModel.course_id))];
    NSString *updatewhere = @"";
    [DownloadModel bg_update:mytableName where:where];
   
    if (self.downloadInfos.count != 0) {
        //如果下载内容不为空 就查询之前的是否已经缓存过下载的子模型 如果有缓存过就不用再存了
        NSString *isFirstWhere = [NSString stringWithFormat:@"where %@=%@ and %@=%@ and %@=%@",bg_sqlKey(@"userPhone"),bg_sqlValue(userMobile),bg_sqlKey(@"course_id"),bg_sqlValue(@(self.lastDownModel.course_id)),bg_sqlKey(@"isfirst"),bg_sqlValue(@0)];
        NSArray *result = [DownloadModel bg_find:mytableName where:isFirstWhere];
        if (result.count == 0) {
//            for (DownloadInfo *model in self.downloadInfos) {

//            }
            
           updatewhere = [NSString stringWithFormat:@"set %@=%@ where %@=%@ and %@=%@",bg_sqlKey(@"downloading_num"),bg_sqlValue(@(self.downloadInfos.count)),bg_sqlKey(@"userPhone"),bg_sqlValue(userMobile),bg_sqlKey(@"course_id"),bg_sqlValue(@(self.lastDownModel.course_id))];
        }
        
    }else{
        NSString *where2 = [NSString stringWithFormat:@"where %@=%@ and %@=%@",bg_sqlKey(@"courseid"),bg_sqlValue(@(self.lastDownModel.course_id)),bg_sqlKey(@"isDownload"),bg_sqlValue(@0)];
       NSArray<DownloadInfo *> *childs = [DownloadInfo bg_find:childDownloadTable where:where2];
        
        updatewhere = [NSString stringWithFormat:@"set %@=%@ where %@=%@ and %@=%@",bg_sqlKey(@"downloading_num"),bg_sqlValue(@(childs.count)),bg_sqlKey(@"userPhone"),bg_sqlValue(userMobile),bg_sqlKey(@"course_id"),bg_sqlValue(@(self.lastDownModel.course_id))];
        
//        self.downloadInfos = [NSMutableArray arrayWithArray:childs];
//        [self.downloadManager startDownload];
//        [self.tableView reloadData];
        [self lauchActivity:childs];
    }
    
     [DownloadModel bg_update:mytableName where:updatewhere];
}


- (void)lauchActivity:(NSArray *)array{
    WeakSelf(self)
     NSMutableArray<DownloadInfo *> *datas = [NSMutableArray array];
    [self.downloadManager requstDownloadProcessingListWithCompletion:^(NSArray<PLVVodDownloadInfo *> *downloadInfos) {
        dispatch_async(dispatch_get_main_queue(), ^{
            for (DownloadInfo *model in array) {
                for (PLVVodDownloadInfo *info in downloadInfos) {
                    if ([info.identifier isEqualToString: model.identifier]) {
                        DownloadInfo *infoModel = [DownloadInfo new];
                        infoModel.identifier = info.identifier;
                        infoModel.downloadInfo = info;
                        infoModel.vid = info.vid;
                        [datas addObject:infoModel];
                    }
                }
            }
            
            weakself.downloadInfos = datas;
            [weakself.tableView reloadData];
        });
    }];
}

#pragma mark - property

- (void)searchCacheData{
    
    WeakSelf(self);


    
//    bg_setDebug(true);
//    NSString *where = [NSString stringWithFormat:@"where %@=%@ and %@=%@ and %@=%@",bg_sqlKey(@"userPhone"),bg_sqlValue(userMobile),bg_sqlKey(@"stautes"),bg_sqlValue(@0),bg_sqlKey(@"course_id"),bg_sqlValue(@(self.lastDownModel.course_id))];
//    NSMutableArray<DownloadModel *> *datas = [NSMutableArray array];
//    [DownloadModel bg_findAsync:mytableName where:where complete:^(NSArray * _Nullable array) {
//
//    }];
    
    NSString *isFirstWhere = [NSString stringWithFormat:@"where %@=%@ and %@=%@ and %@=%@",bg_sqlKey(@"userPhone"),bg_sqlValue(userMobile),bg_sqlKey(@"course_id"),bg_sqlValue(@(self.lastDownModel.course_id)),bg_sqlKey(@"isfirst"),bg_sqlValue(@0)];
    NSArray *result = [DownloadModel bg_find:mytableName where:isFirstWhere];
    if (result.count == 0) {
        
     [weakself getData];
    }else{
        NSArray *array = self.lastDownModel.downloadingList;
        for (Child_list *info in array) {
            __block TasksDownloaderOperation *op = [[TasksDownloaderOperation alloc] initWithTask:^{
                JLog(@"%@",info.video_id);
                [PLVVodVideo requestVideoPriorityCacheWithVid:info.video_id completion:^(PLVVodVideo *video, NSError *error) {
                    if (video.available){
                        [self downloadVideo:video];
                    }else{
                        
                    }
                    
                    [op done];
                    
                }];
                
            }];
            
            [self.downloadQueue addOperation:op];
            [self.lastOp addDependency:op];
            self.lastOp = op;
        }
        [self.downloadQueue waitUntilAllOperationsAreFinished];
        
        NSMutableArray<DownloadInfo *> *datas = [NSMutableArray array];
        [self.downloadManager requstDownloadProcessingListWithCompletion:^(NSArray<PLVVodDownloadInfo *> *downloadInfos) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                for (Child_list *model in array) {
                    for (PLVVodDownloadInfo *info in downloadInfos) {
                        if ([info.vid isEqualToString: model.video_id]) {
                            DownloadInfo *infoModel = [DownloadInfo new];
                            infoModel.identifier = info.identifier;
                            infoModel.downloadInfo = info;
                            infoModel.vid = info.vid;
                            
                            [datas addObject:infoModel];
                        }
                    }
                }
                
                weakself.downloadInfos = datas;
                [weakself getData];
                [weakself.tableView reloadData];
            });
        }];
        
         
    }
    

//    [PLVDownloadCompleteInfoModel bg_findAsync:mytableName where:where complete:^(NSArray<PLVDownloadCompleteInfoModel *> * _Nullable array) {
//
//
//        [self.downloadManager requstDownloadProcessingListWithCompletion:^(NSArray<PLVVodDownloadInfo *> *downloadInfos) {
//            JLog(@"下载中视频++%@",downloadInfos);
//
//
//            dispatch_async(dispatch_get_main_queue(), ^{
//
//                for (PLVDownloadCompleteInfoModel *model in array) {
//                    for (PLVVodDownloadInfo *info in downloadInfos) {
//                        if ([model.identifier isEqualToString:info.identifier]) {
//                            model.identifier = info.identifier;
//                            model.downloadInfo = info;
//                            [datas addObject:model];
//                        }
//
//                    }
//                }
//
//
//                weakself.downloadInfos = datas;
//
//
//
//                NSLog(@"222++%@",weakself.downloadInfos);
//                 [weakself.tableView reloadData];
//            });
//        }];
//
//
//    }];
    
}



- (void)setDownloadInfos:(NSMutableArray<DownloadInfo *> *)downloadInfos {
    _downloadInfos = downloadInfos;

    // 设置单元格字典
    NSMutableDictionary *downloadItemCellDic = [NSMutableDictionary dictionary];
    for (DownloadInfo *info in downloadInfos) {
        PLVDownloadProcessingCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[PLVDownloadProcessingCell identifier]];
        downloadItemCellDic[info.identifier] = cell;
    }
    self.downloadItemCellDic = downloadItemCellDic;

    // 设置回调
    __weak typeof(self) weakSelf = self;
    for (DownloadInfo *model in downloadInfos) {
        PLVVodDownloadInfo *info = model.downloadInfo;
        // 下载状态改变回调
        info.stateDidChangeBlock = ^(PLVVodDownloadInfo *info) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (info.state == PLVVodDownloadStateSuccess){ //下载成功，从列表中删除
                    [weakSelf handleDownloadSuccess:info];
                }

                [weakSelf updateCellWithDownloadInfo:info];
            });
        };

        // 下载进度回调
        info.progressDidChangeBlock = ^(PLVVodDownloadInfo *info) {
            //NSLog(@"vid: %@, progress: %f", info.vid, info.progress);
            PLVDownloadProcessingCell *cell = weakSelf.downloadItemCellDic[info.identifier];
            float receivedSize = MIN(info.progress, 1) * info.filesize;
            NSString *downloadProgressStr = [NSString stringWithFormat:@"%@/ %@", [weakSelf.class formatFilesize:receivedSize],[weakSelf.class formatFilesize:info.filesize]];

            dispatch_async(dispatch_get_main_queue(), ^{
                cell.videoSizeLabel.text = downloadProgressStr;
            });
        };

        // 下载速率回调
//        info.bytesPerSecondsDidChangeBlock = ^(PLVVodDownloadInfo *info) {
//            PLVDownloadProcessingCell *cell = weakSelf.downloadItemCellDic[info.vid];
//            NSString *speedString = [NSByteCountFormatter stringFromByteCount:info.bytesPerSeconds countStyle:NSByteCountFormatterCountStyleFile];
//            speedString = [speedString stringByAppendingFormat:@"/s"];
//            dispatch_async(dispatch_get_main_queue(), ^{
////                cell.downloadSpeedLabel.text = speedString;
//            });
//        };

        // 解压进度回调
//        info.unzipProgressDidChangeBlock = ^(PLVVodDownloadInfo *info) {
//            NSLog(@"vid: %@ unzipProgress:%f ", info.vid, info.unzipProgress);
//        };
    }
}

//- (void)setDownloadInfos:(NSMutableArray<PLVDownloadCompleteInfoModel *> *)downloadInfos {
//
//     _downloadInfos = downloadInfos;
//
//    // 设置单元格字典
//    NSMutableDictionary *downloadItemCellDic = [NSMutableDictionary dictionary];
//    for (PLVDownloadCompleteInfoModel *downloadModel in downloadInfos) {
//
//        PLVDownloadProcessingCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[PLVDownloadProcessingCell identifier]];
//        downloadItemCellDic[downloadModel.identifier] = cell;
//    }
//    self.downloadItemCellDic = downloadItemCellDic;
//
//    // 设置回调
//    __weak typeof(self) weakSelf = self;
//    for (PLVDownloadCompleteInfoModel *downloadModel in downloadInfos) {
//        PLVVodDownloadInfo *info = downloadModel.downloadInfo;
//        // 下载状态改变回调
//        info.stateDidChangeBlock = ^(PLVVodDownloadInfo *info) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                if (info.state == PLVVodDownloadStateSuccess){ //下载成功，从列表中删除
//                    [weakSelf handleDownloadSuccess:info];
//                }
//
//                [weakSelf updateCellWithDownloadInfo:info];
//            });
//        };
//
//        // 下载进度回调
//        info.progressDidChangeBlock = ^(PLVVodDownloadInfo *info) {
//            //NSLog(@"vid: %@, progress: %f", info.vid, info.progress);
//            PLVDownloadProcessingCell *cell = weakSelf.downloadItemCellDic[info.identifier];
//            float receivedSize = MIN(info.progress, 1) * info.filesize;
//            NSString *downloadProgressStr = [NSString stringWithFormat:@"%@/ %@", [self.class formatFilesize:receivedSize],[self.class formatFilesize:info.filesize]];
//
//            dispatch_async(dispatch_get_main_queue(), ^{
//                cell.videoSizeLabel.text = downloadProgressStr;
//            });
//        };
//
//        // 下载速率回调
////        info.bytesPerSecondsDidChangeBlock = ^(PLVVodDownloadInfo *info) {
////            PLVDownloadProcessingCell *cell = weakSelf.downloadItemCellDic[info.vid];
////            NSString *speedString = [NSByteCountFormatter stringFromByteCount:info.bytesPerSeconds countStyle:NSByteCountFormatterCountStyleFile];
////            speedString = [speedString stringByAppendingFormat:@"/s"];
////            dispatch_async(dispatch_get_main_queue(), ^{
//////                cell.downloadSpeedLabel.text = speedString;
////            });
////        };
//
//        // 解压进度回调
//        info.unzipProgressDidChangeBlock = ^(PLVVodDownloadInfo *info) {
//            JLog(@"vid: %@ unzipProgress:%f ", info.vid, info.unzipProgress);
//        };
//    }
//
////    [self.downloadManager startDownload];
//}

- (void)updateCellWithDownloadInfo:(PLVVodDownloadInfo *)info {
    PLVDownloadProcessingCell *cell = self.downloadItemCellDic[info.identifier];
    
    cell.videoStateLable.text = NSStringFromPLVVodDownloadState(info.state);
    cell.downloadStateImgView.image = [UIImage imageNamed:[self downloadStateImgFromState:info.state]];
    
    switch (info.state) {
        case PLVVodDownloadStatePreparing:
        case PLVVodDownloadStateReady:
        case PLVVodDownloadStateStopped:
        case PLVVodDownloadStateStopping:{
            cell.videoStateLable.textColor = [UIColor colorWithHex:0x666666];
            cell.videoSizeLabel.textColor = [UIColor colorWithHex:0x666666];
        } break;
        case PLVVodDownloadStatePreparingStart:
        case PLVVodDownloadStateRunning:{
            cell.videoStateLable.textColor = [UIColor colorWithHex:0x4A90E2];
            cell.videoSizeLabel.textColor = [UIColor colorWithHex:0x4A90E2];
        } break;
        case PLVVodDownloadStateSuccess:{
            cell.videoStateLable.textColor = [UIColor colorWithHex:0x666666];
            cell.videoSizeLabel.textColor = [UIColor colorWithHex:0x666666];
        } break;
        case PLVVodDownloadStateFailed:{
            cell.videoStateLable.textColor = [UIColor redColor];
            cell.videoSizeLabel.textColor = [UIColor redColor];
        } break;
    }
}

#pragma mark -- handle
- (void)handleDownloadSuccess:(PLVVodDownloadInfo *)downloadModel{
//    downloaded += 1;
    for (DownloadInfo *info in self.downloadInfos) {
        if ([info.identifier isEqualToString:downloadModel.identifier]) {
            [self.downloadInfos removeObject:info];
            break;
        }
    }
    [self.tableView reloadData];
//    [self.downloadInfos removeObject:downloadModel];
    [self.downloadItemCellDic removeObjectForKey:downloadModel.identifier];
    NSString *where = [NSString stringWithFormat:@"set %@=%@ where %@=%@ and %@=%@",bg_sqlKey(@"isDownload"),bg_sqlValue(@1),bg_sqlKey(@"identifier"),bg_sqlValue(downloadModel.identifier),bg_sqlKey(@"course_id"),bg_sqlValue(@(self.lastDownModel.course_id))];
    [DownloadInfo bg_update:childDownloadTable where:where];

    NSString *mainwhere = [NSString stringWithFormat:@"set %@=%@ where %@=%@ and %@=%@",bg_sqlKey(@"downloaded_num"),bg_sqlValue(@1),bg_sqlKey(@"userPhone"),bg_sqlValue(userMobile),bg_sqlKey(@"course_id"),bg_sqlValue(@(self.lastDownModel.course_id))];
    [DownloadModel bg_update:mytableName where:mainwhere];
}

#pragma mark - action

- (void)queueDownloadButtonAction:(UIButton *)sender {
    if (self.downloadInfos.count == 0)
        return;
    
    sender.selected = !sender.selected;
    PLVVodDownloadManager *downloadManager = [PLVVodDownloadManager sharedManager];
    if (sender.selected) {
        // 开始队列下载
        [downloadManager startDownload];
    } else {
        // 停止队列下载
        [downloadManager stopDownload];
    }
}

//- (void)cleanDownloadButtonAction:(UIButton *)sender{
//
//    if (self.downloadInfos.count == 0)
//        return;
//
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
//                                                        message:@"确定删除所有任务?"
//                                                       delegate:self
//                                              cancelButtonTitle:@"取消"
//                                              otherButtonTitles:@"确定", nil];
//    [alertView show];
//}
//
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if (buttonIndex == 1){
//        // 清空下载队列
//        [[PLVVodDownloadManager sharedManager] removeAllDownloadWithComplete:^(void *result) {
//            //
//            [self.downloadInfos removeAllObjects];
//            [self.tableView reloadData];
//        }];
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger number = self.downloadInfos.count;
    self.tableView.backgroundView = number ? nil : self.emptyView;
    return number;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DownloadInfo *model = self.downloadInfos[indexPath.row];
    PLVVodDownloadInfo *info = model.downloadInfo;
//    DownloadInfo *info = self.downloadInfos[indexPath.row];
    PLVDownloadProcessingCell *cell = self.downloadItemCellDic[info.identifier];
    if (!cell) return [UITableViewCell new];
    
    PLVVodVideo *video = info.video;
    if (video){
        cell.thumbnailUrl = video.snapshot;

        float receivedSize = info.progress * info.filesize;
        if (receivedSize >= info.filesize){
            receivedSize = info.filesize;
        }
        NSString *downloadProgressStr = [NSString stringWithFormat:@"%@/ %@", [self.class formatFilesize:receivedSize],[self.class formatFilesize:info.filesize]];
        cell.videoSizeLabel.text = downloadProgressStr;

        if (info.fileType == PLVDownloadFileTypeAudio){
            cell.titleLabel.text = [NSString stringWithFormat:@"[音频] %@", video.title];
        }
        else{
            cell.titleLabel.text = video.title;
        }
    }
    else{
        // 取info数据
        
        cell.thumbnailUrl = info.snapshot;
        cell.titleLabel.text = info.title;
        
        float receivedSize = info.progress * info.filesize;
        if (receivedSize >= info.filesize){
            receivedSize = info.filesize;
        }
        NSString *downloadProgressStr = [NSString stringWithFormat:@"%@/ %@", [self.class formatFilesize:receivedSize],[self.class formatFilesize:info.filesize]];
        cell.videoSizeLabel.text = downloadProgressStr;
    }

    cell.backgroundColor = self.tableView.backgroundColor;
    cell.downloadStateImgView.image = [UIImage imageNamed:[self downloadStateImgFromState:info.state]];

    return cell;
}

#pragma mark -- UITableViewDelegate --
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DownloadInfo *model = self.downloadInfos[indexPath.row];
    PLVVodDownloadInfo *info = model.downloadInfo;
//    DownloadInfo *info = self.downloadInfos[indexPath.row];
    // 播放本地缓存视频
//    PLVVodDownloadInfo *info = self.downloadInfos[indexPath.row];
    if (info.state == PLVVodDownloadStateReady || info.state == PLVVodDownloadStateRunning) {
        // 暂停下载
        [self handleStopDownloadVideo:info];
    } else {
        // 开始下载
        [self handleStartDownloadVideo:info];
    }
}

/// 删除
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return UITableViewCellEditingStyleDelete;
//}
//
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    return YES;
//}


//- (UIButton *)queueDownloadButton {
//    if (!_queueDownloadButton) {
//        UIImage *downloadIcon = [UIImage imageNamed:@"plv_btn_cache"];
//        _queueDownloadButton = [UIButton new];
//        downloadIcon = [downloadIcon imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
////        _queueDownloadButton = [PLVToolbar buttonWithTitle:@"全部开始" image:downloadIcon];
//        [_queueDownloadButton setTitle:@"全部开始" forState:0];
//        [_queueDownloadButton setImage:downloadIcon forState:0];
//        [_queueDownloadButton setTitle:@"全部停止" forState:UIControlStateSelected];
//        [_queueDownloadButton setTitleColor:APPColor forState:UIControlStateNormal];
//        [_queueDownloadButton addTarget:self action:@selector(queueDownloadButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _queueDownloadButton;
//}
//
//- (UIButton *)cleanDownloadButton{
//    if (!_cleanDownloadButton){
////        _cleanDownloadButton = [PLVToolbar buttonWithTitle:@"全部清空" image:[UIImage imageNamed:@"plv_icon_clean_all_download"]];
//        _cleanDownloadButton = [UIButton new];
//        [_cleanDownloadButton setTitle:@"全部清空" forState:0];
//        [_cleanDownloadButton setImage:[UIImage imageNamed:@"plv_icon_clean_all_download"] forState:0];
//        [_cleanDownloadButton setTitleColor:[UIColor colorWithHex:0xE74C3C] forState:UIControlStateNormal];
//        [_cleanDownloadButton addTarget:self action:@selector(cleanDownloadButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    }
//
//    return _cleanDownloadButton;
//}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    PLVVodDownloadManager *downloadManager = [PLVVodDownloadManager sharedManager];
    DownloadInfo *model = self.downloadInfos[indexPath.row];
    PLVVodDownloadInfo *downloadInfo = model.downloadInfo;
//    PLVVodDownloadInfo *downloadInfo = self.downloadInfos[indexPath.row];
    
#ifndef PLVSupportDownloadAudio
    [downloadManager removeDownloadWithVid:downloadInfo.video.vid error:nil];
#else
    // 使用音频下载功能的客户，调用如下方法
    PLVVodVideoParams *params = [PLVVodVideoParams videoParamsWithVid:downloadInfo.vid fileType:downloadInfo.fileType];
    [downloadManager removeDownloadWithVideoParams:params error:nil];
#endif
    
//    [self.downloadInfos removeObject:model];
//    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//    NSString *where = [NSString stringWithFormat:@"where %@=%@",bg_sqlKey(@"identifier"),bg_sqlValue(downloadInfo.identifier)];
//    NSString *where = [NSString stringWithFormat:@"where %@=%@ and %@=%@ and %@=%@",bg_sqlKey(@"userPhone"),bg_sqlValue(userMobile),bg_sqlKey(@"stautes"),bg_sqlValue(@0),bg_sqlKey(@"identifier"),bg_sqlValue(downloadInfo.identifier)];
//    [PLVDownloadCompleteInfoModel bg_delete:mytableName where:where];
}

#pragma mark - util

- (void)downloadVideo:(PLVVodVideo *)video {
    PLVVodDownloadManager *downloadManager = [PLVVodDownloadManager sharedManager];
    PLVVodDownloadInfo *info = [downloadManager downloadVideo:video];
    
#ifdef PLVSupportDownloadAudio
    // 音频下载测试入口，需要音频下载功能客户，放开注释
    [downloadManager downloadAudio:video];
    
#endif
    
    if (info){
      NSLog(@"%@ - %zd 已加入下载队列", info.video.vid, info.quality);
//        PLVDownloadCompleteInfoModel *model = [PLVDownloadCompleteInfoModel new];
//        model.downloadInfo = info;
//        model.userPhone = userMobile;
//
//        [PLVVodDownloadInfo bg_drop:mytableName];
//        [PLVDownloadCompleteInfoModel bg_drop:mytableName];
//        model.bg_tableName = mytableName;
//        model.stautes = 0;
//        model.localVideo = [PLVVodLocalVideo localVideoWithVideo:info.video dir:[PLVVodDownloadManager sharedManager].downloadDir];
//        model.identifier = info.identifier;
//        [model bg_save];
        DownloadInfo  *childModel = [DownloadInfo new];
        childModel.courseid = self.lastDownModel.course_id;
//        childModel.snapshot = model.downloadInfo.snapshot;
//        childModel.title = model.downloadInfo.title;
//        childModel.filesize = model.downloadInfo.filesize;
//        childModel.duration = model.downloadInfo.duration;
        childModel.downloadInfo = info;
        childModel.vid = info.vid;
        childModel.identifier = info.identifier;
       
        childModel.bg_tableName = childDownloadTable;
        [childModel bg_save];
        
    }
}


+ (NSString *)formatFilesize:(NSInteger)filesize {
    return [NSByteCountFormatter stringFromByteCount:filesize countStyle:NSByteCountFormatterCountStyleFile];
}

- (NSString *)downloadStateImgFromState:(PLVVodDownloadState )state{
    //
    NSString *imageName = nil;
    switch (state) {
        case PLVVodDownloadStateReady:
        case PLVVodDownloadStatePreparing:
            imageName = @"plv_icon_download_will";
            break;
        case PLVVodDownloadStateStopped:
        case PLVVodDownloadStateStopping:
            imageName = @"plv_icon_download_stop";
            break;
        case PLVVodDownloadStatePreparingStart:
        case PLVVodDownloadStateRunning:
            imageName = @"plv_icon_download_processing";
            break;
        case PLVVodDownloadStateSuccess:
            imageName = @"plv_icon_download_will";
            break;
        case PLVVodDownloadStateFailed:
            imageName = @"plv_icon_download_fail";
            break;
    }
    
    return imageName;
}

#pragma mark -- handle
- (void)handleStopDownloadVideo:(PLVVodDownloadInfo *)info{
    
#ifndef PLVSupportDownloadAudio
    [[PLVVodDownloadManager sharedManager] stopDownloadWithVid:info.vid];
#else
    // 使用音频下载功能的客户，调用如下方法
    PLVVodVideoParams *params = [PLVVodVideoParams videoParamsWithVid:info.vid fileType:info.fileType];
    [[PLVVodDownloadManager sharedManager] stopDownloadWithVideoParams:params];
#endif
}

- (void)handleStartDownloadVideo:(PLVVodDownloadInfo *)info{
    
#ifndef PLVSupportDownloadAudio
    [[PLVVodDownloadManager sharedManager] startDownloadWithVid:info.vid];
#else
    // 使用音频下载功能的客户，调用如下方法
    PLVVodVideoParams *params = [PLVVodVideoParams videoParamsWithVid:info.vid fileType:info.fileType];
    [[PLVVodDownloadManager sharedManager] startDownloadWithVideoParams:params];
#endif
    
    if ([PLVVodDownloadManager sharedManager].isDownloading){
        //
        self.queueDownloadButton.selected = YES;
    }
}

- (PLVVodDownloadManager *)downloadManager{
    if (!_downloadManager) {
        _downloadManager = [PLVVodDownloadManager sharedManager];
    }
    return _downloadManager;
}

- (NSOperationQueue *)downloadQueue{
    if (!_downloadQueue) {
        _downloadQueue = [NSOperationQueue new];
        _downloadQueue.maxConcurrentOperationCount = 1;
    }
    
    return _downloadQueue;
}

@end
