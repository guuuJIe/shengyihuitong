//
//  VideoDownloadProcessingVC.m
//  shengyihuitongApp
//
//  Created by mac on 2020/6/29.
//  Copyright © 2020 mac. All rights reserved.
//

#import "VideoDownloadProcessingVC.h"
#import <PLVVodSDK/PLVVodSDK.h>
#import "UIColor+PLVVod.h"
#import <PLVTimer/PLVTimer.h>
#import "PLVDownloadProcessingCell.h"
#import "PLVDownloadCompleteInfoModel.h"

@interface VideoDownloadProcessingVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<PLVDownloadCompleteInfoModel *> *downloadInfos;
//@property (nonatomic, strong) NSMutableArray<PLVVodDownloadInfo *> *downloadInfos;
@property (nonatomic, strong) NSMutableDictionary<NSString *, PLVDownloadProcessingCell *> *downloadItemCellDic;

@property (nonatomic, strong) PLVTimer *timer;

@property (nonatomic, strong) UIButton *queueDownloadButton;
@property (nonatomic, strong) UIButton *cleanDownloadButton;

@property (nonatomic, strong) UIView *emptyView;
@property (nonatomic, strong) PLVVodDownloadManager *downloadManager;
@end

@implementation VideoDownloadProcessingVC


- (void)dealloc {
    [self.timer cancel];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    __weak typeof(self) weakSelf = self;
//    PLVVodDownloadManager *downloadManager = [PLVVodDownloadManager sharedManager];

    
    
    [self searchCacheData];
    
    // 所有下载完成回调
    self.downloadManager.completeBlock = ^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//            weakSelf.queueDownloadButton.selected = NO;
//        });
    };
//    self.queueDownloadButton.selected = [PLVVodDownloadManager sharedManager].isDownloading;
    self.tableView = [UITableView new];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(-50-StatusBarAndNavigationBarHeight);
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
    
//    [self.view addSubview:self.queueDownloadButton];
//    [self.queueDownloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.view);
//        make.width.mas_equalTo(Screen_Width/2);
//        make.top.mas_equalTo(self.tableView.mas_bottom);
//        make.height.mas_equalTo(50);
//    }];
//
//    [self.view addSubview:self.cleanDownloadButton];
//    [self.cleanDownloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(self.view);
//        make.width.mas_equalTo(Screen_Width/2);
////        make.bottom.mas_equalTo(self.view);
//        make.height.mas_equalTo(50);
//    }];
}



#pragma mark - property

- (void)searchCacheData{
    
    WeakSelf(self);
//    NSMutableArray<PLVDownloadCompleteInfoModel*> *datas = [NSMutableArray array];
//    [self.downloadManager requstDownloadProcessingListWithCompletion:^(NSArray<PLVVodDownloadInfo *> *downloadInfos) {
//        JLog(@"下载中视频++%@",downloadInfos);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            for (PLVVodDownloadInfo *info in downloadInfos) {
//                PLVDownloadCompleteInfoModel *model = [PLVDownloadCompleteInfoModel new];
//                model.downloadInfo = info;
//                model.identifier = info.identifier;
//                [datas addObject:model];
//
//            }
//
//            weakself.downloadInfos = datas;
//
//            //            weakSelf.downloadInfos = downloadInfos.mutableCopy;
//
//            NSLog(@"222++%@",weakself.downloadInfos);
//             [weakself.tableView reloadData];
//        });
//    }];
    
//    bg_setDebug(true);
    NSString *where = [NSString stringWithFormat:@"where %@=%@ and %@=%@",bg_sqlKey(@"userPhone"),bg_sqlValue(userMobile),bg_sqlKey(@"stautes"),bg_sqlValue(@0)];
    NSMutableArray<PLVDownloadCompleteInfoModel*> *datas = [NSMutableArray array];

    [PLVDownloadCompleteInfoModel bg_findAsync:mytableName where:where complete:^(NSArray<PLVDownloadCompleteInfoModel *> * _Nullable array) {

        
        [self.downloadManager requstDownloadProcessingListWithCompletion:^(NSArray<PLVVodDownloadInfo *> *downloadInfos) {
            JLog(@"下载中视频++%@",downloadInfos);
            
            
//            self.downloadInfos = datas;
//             JLog(@"查询出来的结果%@-----%@",array,self.downloadInfos);
//            [self.tableView reloadData];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                for (PLVDownloadCompleteInfoModel *model in array) {
                    for (PLVVodDownloadInfo *info in downloadInfos) {
                        if ([model.identifier isEqualToString:info.identifier]) {
                            model.identifier = info.identifier;
                            model.downloadInfo = info;
                            [datas addObject:model];
                        }

                    }
                }
                
                
                weakself.downloadInfos = datas;
               
             
                
                NSLog(@"222++%@",weakself.downloadInfos);
                 [weakself.tableView reloadData];
            });
        }];


//        dispatch_async(dispatch_get_main_queue(), ^{
//
//
//        });
    }];
    
}

//- (NSMutableArray <PLVDownloadCompleteInfoModel *> *)downloadInfos{
//    if (!_downloadInfos) {
//
//    }
//}

//- (void)setDownloadInfos:(NSMutableArray<PLVVodDownloadInfo *> *)downloadInfos {
//    _downloadInfos = downloadInfos;
//
//    // 设置单元格字典
//    NSMutableDictionary *downloadItemCellDic = [NSMutableDictionary dictionary];
//    for (PLVVodDownloadInfo *info in downloadInfos) {
//        PLVDownloadProcessingCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[PLVDownloadProcessingCell identifier]];
//        downloadItemCellDic[info.identifier] = cell;
//    }
//    self.downloadItemCellDic = downloadItemCellDic;
//
//    // 设置回调
//    __weak typeof(self) weakSelf = self;
//    for (PLVVodDownloadInfo *info in downloadInfos) {
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
////        info.unzipProgressDidChangeBlock = ^(PLVVodDownloadInfo *info) {
////            NSLog(@"vid: %@ unzipProgress:%f ", info.vid, info.unzipProgress);
////        };
//    }
//}

- (void)setDownloadInfos:(NSMutableArray<PLVDownloadCompleteInfoModel *> *)downloadInfos {

     _downloadInfos = downloadInfos;

    // 设置单元格字典
    NSMutableDictionary *downloadItemCellDic = [NSMutableDictionary dictionary];
    for (PLVDownloadCompleteInfoModel *downloadModel in downloadInfos) {

        PLVDownloadProcessingCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[PLVDownloadProcessingCell identifier]];
        downloadItemCellDic[downloadModel.identifier] = cell;
    }
    self.downloadItemCellDic = downloadItemCellDic;

    // 设置回调
    __weak typeof(self) weakSelf = self;
    for (PLVDownloadCompleteInfoModel *downloadModel in downloadInfos) {
        PLVVodDownloadInfo *info = downloadModel.downloadInfo;
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
            NSString *downloadProgressStr = [NSString stringWithFormat:@"%@/ %@", [self.class formatFilesize:receivedSize],[self.class formatFilesize:info.filesize]];

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
        info.unzipProgressDidChangeBlock = ^(PLVVodDownloadInfo *info) {
            JLog(@"vid: %@ unzipProgress:%f ", info.vid, info.unzipProgress);
        };
    }

//    [self.downloadManager startDownload];
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

#pragma mark -- handle
- (void)handleDownloadSuccess:(PLVVodDownloadInfo *)downloadModel{
    
//    [self.downloadInfos removeObject:downloadModel];
    [self.downloadItemCellDic removeObjectForKey:downloadModel.identifier];
    NSString *where = [NSString stringWithFormat:@"set %@=%@ where %@=%@ and %@=%@",bg_sqlKey(@"stautes"),bg_sqlValue(@1),bg_sqlKey(@"userPhone"),bg_sqlValue(userMobile),bg_sqlKey(@"identifier"),bg_sqlValue(downloadModel.identifier)];
    [PLVDownloadCompleteInfoModel bg_update:mytableName where:where];
    [self searchCacheData];
//    [self.tableView reloadData];
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
    PLVDownloadCompleteInfoModel *model = self.downloadInfos[indexPath.row];
    PLVVodDownloadInfo *info = model.downloadInfo;
//    PLVVodDownloadInfo *info = self.downloadInfos[indexPath.row];
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
    PLVDownloadCompleteInfoModel *model = self.downloadInfos[indexPath.row];
    PLVVodDownloadInfo *info = model.downloadInfo;
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
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


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
    PLVDownloadCompleteInfoModel *model = self.downloadInfos[indexPath.row];
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
//    NSString *where = [NSString stringWithFormat:@"where %@=%@",bg_sqlKey(@"identifier"),bg_sqlValue(downloadInfo.identifier)];
    NSString *where = [NSString stringWithFormat:@"where %@=%@ and %@=%@ and %@=%@",bg_sqlKey(@"userPhone"),bg_sqlValue(userMobile),bg_sqlKey(@"stautes"),bg_sqlValue(@0),bg_sqlKey(@"identifier"),bg_sqlValue(downloadInfo.identifier)];
    [PLVDownloadCompleteInfoModel bg_delete:mytableName where:where];
}

#pragma mark - util

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
@end
