//
//  MineDownloadCateDetailCourseVC.m
//  shengyihuitongApp
//
//  Created by Mac on 2020/7/5.
//  Copyright © 2020 mac. All rights reserved.
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

@property (nonatomic, strong) NSMutableDictionary<NSString *, PLVDownloadProcessingCell *> *downloadItemCellDic;

@property (nonatomic, strong) PLVTimer *timer;

@property (nonatomic, strong) UIButton *queueDownloadButton;
@property (nonatomic, strong) UIButton *cleanDownloadButton;

@property (nonatomic, strong) UIView *emptyView;
@property (nonatomic, strong) PLVVodDownloadManager *downloadManager;
@property (nonatomic, strong) NSOperationQueue *downloadQueue;
@property (nonatomic, strong) TasksDownloaderOperation *lastOp;
@property (nonatomic, assign) NSInteger downloaded;
//@property (nonatomic, strong) NSArray <DownloadInfo *> *downloadedArr;
@end

@implementation MineDownloadCateDetailCourseVC


- (void)dealloc {
    [self.timer cancel];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

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
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.edges.mas_equalTo(self.view);
    }];
    [self.tableView registerClass:[PLVDownloadProcessingCell class] forCellReuseIdentifier:[PLVDownloadProcessingCell identifier]];
    self.tableView.backgroundColor = [UIColor themeBackgroundColor];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.allowsSelection = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.estimatedRowHeight = 92;

    
   
    
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
    //isfirst是判断每个课程目录是否第一次点进来
    NSString *where = [NSString stringWithFormat:@"set %@=%@ where %@=%@ and %@=%@",bg_sqlKey(@"isfirst"),bg_sqlValue(@1),bg_sqlKey(@"userPhone"),bg_sqlValue(userMobile),bg_sqlKey(@"course_id"),bg_sqlValue(@(self.lastDownModel.course_id))];
    
    [DownloadModel bg_update:mytableName where:where];
    
    NSString *updatewhere = @"";
    if (self.downloadInfos.count != 0) {
        //如果下载内容不为空 就查询之前的是否已经缓存过下载的子模型 如果有缓存过就不用再存了
        NSString *isFirstWhere = [NSString stringWithFormat:@"where %@=%@ and %@=%@ and %@=%@",bg_sqlKey(@"userPhone"),bg_sqlValue(userMobile),bg_sqlKey(@"course_id"),bg_sqlValue(@(self.lastDownModel.course_id)),bg_sqlKey(@"isfirst"),bg_sqlValue(@0)];
        NSArray *result = [DownloadModel bg_find:mytableName where:isFirstWhere];
        if (result.count == 0) {
            
            updatewhere = [NSString stringWithFormat:@"set %@=%@ where %@=%@ and %@=%@",bg_sqlKey(@"downloading_num"),bg_sqlValue(@(self.downloadInfos.count)),bg_sqlKey(@"userPhone"),bg_sqlValue(userMobile),bg_sqlKey(@"course_id"),bg_sqlValue(@(self.lastDownModel.course_id))];
        }
        
    }else{
        //是第一次点进来 根据主课程表查询子课程表
        NSString *where2 = [NSString stringWithFormat:@"where %@=%@ and %@=%@",bg_sqlKey(@"courseid"),bg_sqlValue(@(self.lastDownModel.course_id)),bg_sqlKey(@"isDownload"),bg_sqlValue(@0)];
        NSArray<DownloadInfo *> *childs = [DownloadInfo bg_find:childDownloadTable where:where2];
        
        updatewhere = [NSString stringWithFormat:@"set %@=%@ where %@=%@ and %@=%@",bg_sqlKey(@"downloading_num"),bg_sqlValue(@(childs.count)),bg_sqlKey(@"userPhone"),bg_sqlValue(userMobile),bg_sqlKey(@"course_id"),bg_sqlValue(@(self.lastDownModel.course_id))];
        
        
        [self lauchActivity:childs];
    }
    
     [DownloadModel bg_update:mytableName where:updatewhere];
}

//判断根据chapterid查出来的数据缓存的下载列表数据对比保利威加入到下载队列列表数据 进行对比
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
                        infoModel.chapter_name = model.chapter_name;
                        [datas addObject:infoModel];
                    }
                }
            }
            
            weakself.downloadInfos = datas;
            [weakself.tableView reloadData];
        });
    }];
}

#pragma mark --根据courseId查缓存数据 加入子表--

- (void)searchCacheData{
    
    WeakSelf(self);
    //isfirst 第一次进入根据主表的chapterId 在判断有无数据
    NSString *isFirstWhere = [NSString stringWithFormat:@"where %@=%@ and %@=%@ and %@=%@",bg_sqlKey(@"userPhone"),bg_sqlValue(userMobile),bg_sqlKey(@"course_id"),bg_sqlValue(@(self.lastDownModel.course_id)),bg_sqlKey(@"isfirst"),bg_sqlValue(@0)];
    NSArray *result = [DownloadModel bg_find:mytableName where:isFirstWhere];
    if (result.count == 0) {
        
        [weakself getData];
        
    }else{
        //不是第一次进来的 将数据与加入到保利威的下载队列数据进行比较
        NSArray *array = self.lastDownModel.downloadingList;
        for (Child_list *info in array) {
            __block TasksDownloaderOperation *op = [[TasksDownloaderOperation alloc] initWithTask:^{
                JLog(@"%@",info.video_id);
                [PLVVodVideo requestVideoPriorityCacheWithVid:info.video_id completion:^(PLVVodVideo *video, NSError *error) {
                    if (video.available){
                        [self downloadVideo:video];//添加进保利威的下载队列
                    }

                    [op done];

                }];

            }];

            [self.downloadQueue addOperation:op];
            [self.lastOp addDependency:op];
            self.lastOp = op;
        }
        [self.downloadQueue waitUntilAllOperationsAreFinished];
        //将主表的数据插入到子表
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
                            infoModel.chapter_name = model.chapter_name;
                            infoModel.courseid = self.lastDownModel.course_id;
                            infoModel.snapshot = info.snapshot;
                            infoModel.duration = info.duration;
                            infoModel.title = info.title;
                            infoModel.filesize = info.filesize;
                            infoModel.bg_tableName = childDownloadTable;
                            [infoModel bg_save];
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
                    [self handleDownloadSuccess:info];
                }

                [self updateCellWithDownloadInfo:info];
            });
        };

        // 下载进度回调
        info.progressDidChangeBlock = ^(PLVVodDownloadInfo *info) {
            //NSLog(@"vid: %@, progress: %f", info.vid, info.progress);
            PLVDownloadProcessingCell *cell = weakSelf.downloadItemCellDic[info.identifier];
            float receivedSize = MIN(info.progress, 1) * info.filesize;
            NSString *downloadProgressStr = [NSString stringWithFormat:@"%@/ %@", [weakSelf.class formatFilesize:receivedSize],[self.class formatFilesize:info.filesize]];

            dispatch_async(dispatch_get_main_queue(), ^{
                cell.videoSizeLabel.text = downloadProgressStr;
            });
        };

 
    }
}


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

- (void)refreshDownloadingNum{
    
    NSString *where = [NSString stringWithFormat:@"set %@=%@ where %@=%@ and %@=%@",bg_sqlKey(@"downloading_num"),bg_sqlValue(@(self.downloadInfos.count)),bg_sqlKey(@"userPhone"),bg_sqlValue(userMobile),bg_sqlKey(@"course_id"),bg_sqlValue(@(self.lastDownModel.course_id))];
    
    [DownloadModel bg_update:mytableName where:where];
    
}

#pragma mark ---handle下载成功---
- (void)handleDownloadSuccess:(PLVVodDownloadInfo *)downloadModel{

    for (DownloadInfo *info in self.downloadInfos) {
        if ([info.identifier isEqualToString:downloadModel.identifier]) {

            [self.downloadInfos removeObject:info];
            break;
        }
    }
    
    [self.tableView reloadData];
    [self refreshDownloadingNum];
    self.downloaded += 1;

    //更新子表的该课程的download字段
    [self.downloadItemCellDic removeObjectForKey:downloadModel.identifier];
    NSString *where = [NSString stringWithFormat:@"set %@=%@ where %@=%@ and %@=%@",bg_sqlKey(@"isDownload"),bg_sqlValue(@1),bg_sqlKey(@"courseid"),bg_sqlValue(@(self.lastDownModel.course_id)),bg_sqlKey(@"vid"),bg_sqlValue(downloadModel.vid)];
    [DownloadInfo bg_update:childDownloadTable where:where];

    //更新主表的downloadedNum的字段
    NSString *mainwhere = [NSString stringWithFormat:@"set %@=%@ where %@=%@ and %@=%@",bg_sqlKey(@"downloaded_num"),bg_sqlValue(@(self.downloaded)),bg_sqlKey(@"userPhone"),bg_sqlValue(userMobile),bg_sqlKey(@"course_id"),bg_sqlValue(@(self.lastDownModel.course_id))];
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
        cell.chapterLabel.text = model.chapter_name;
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
        cell.chapterLabel.text = model.chapter_name;
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

// 删除
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
// 修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}





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
    
    [self.downloadInfos removeObject:model];
  

    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    NSString *where = [NSString stringWithFormat:@"where %@=%@ and %@=%@",bg_sqlKey(@"identifier"),bg_sqlValue(downloadInfo.identifier),bg_sqlKey(@"courseid"),bg_sqlValue(@(model.courseid))];
    [DownloadInfo bg_delete:childDownloadTable where:where];
    [self refreshDownloadingNum];
//    NSString *where = [NSString stringWithFormat:@"where %@=%@ and %@=%@ and %@=%@",bg_sqlKey(@"userPhone"),bg_sqlValue(userMobile),bg_sqlKey(@"stautes"),bg_sqlValue(@0),bg_sqlKey(@"identifier"),bg_sqlValue(downloadInfo.identifier)];
//    [PLVDownloadCompleteInfoModel bg_delete:mytableName where:where];
}

#pragma mark - util

- (void)downloadVideo:(PLVVodVideo *)video {
    PLVVodDownloadManager *downloadManager = [PLVVodDownloadManager sharedManager];
//    PLVVodDownloadInfo *info = [downloadManager downloadVideo:video];
    PLVVodDownloadInfo *info = [downloadManager downloadVideo:video quality:PLVVodQualityHigh];
    
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
//        DownloadInfo  *childModel = [DownloadInfo new];
//        childModel.courseid = self.lastDownModel.course_id;
//        childModel.snapshot = model.downloadInfo.snapshot;
//        childModel.title = model.downloadInfo.title;
//        childModel.filesize = model.downloadInfo.filesize;
//        childModel.duration = model.downloadInfo.duration;
//        childModel.downloadInfo = info;
//        childModel.vid = info.vid;
//        childModel.identifier = info.identifier;
//        for (DownloadInfo *item in self.downloadInfos) {
//            if ([info.identifier isEqualToString:item.identifier]) {
//                childModel.chapter_name = item.chapter_name;
//                break;
//            }
//        }
////        childModel.chapter_name = @"";
//        childModel.bg_tableName = childDownloadTable;
//        [childModel bg_save];
        
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
