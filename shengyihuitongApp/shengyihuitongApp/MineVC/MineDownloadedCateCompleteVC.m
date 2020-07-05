//
//  MineDownloadedCateCompleteVC.m
//  shengyihuitongApp
//
//  Created by Mac on 2020/7/5.
//  Copyright © 2020 温州轩捷贸易有限公司. All rights reserved.
//

#import "MineDownloadedCateCompleteVC.h"
#import <PLVVodSDK/PLVVodSDK.h>
#import "UIColor+PLVVod.h"
#import <PLVTimer/PLVTimer.h>
#import "PLVDownloadComleteCell.h"
#import "PLVDownloadCompleteInfoModel.h"
#import "VideoPLayVC.h"
#import "BaseTableView.h"
@interface MineDownloadedCateCompleteVC ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<PLVDownloadCompleteInfoModel *> *downloadInfos;

@property (nonatomic, strong) UIView *emptyView;
@end

@implementation MineDownloadedCateCompleteVC

- (NSMutableArray<PLVDownloadCompleteInfoModel *> *)downloadInfos{
    if (!_downloadInfos){
        _downloadInfos = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _downloadInfos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    __weak typeof(self) weakSelf = self;
   
    [self initVideoList];
    self.tableView = [BaseTableView new];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(0);
    }];
    [self.tableView registerClass:[PLVDownloadComleteCell class] forCellReuseIdentifier:[PLVDownloadComleteCell identifier]];
    self.tableView.backgroundColor = [UIColor themeBackgroundColor];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.allowsSelection = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;

    
    UILabel *emptyLabel = [[UILabel alloc] init];
    emptyLabel.text = @"暂无缓存视频";
    emptyLabel.textAlignment = NSTextAlignmentCenter;
    self.emptyView = emptyLabel;
    
    //
//    [PLVVodDownloadManager sharedManager].downloadCompleteBlock = ^(PLVVodDownloadInfo *info) {
//        // 刷新列表
//        dispatch_async(dispatch_get_main_queue(), ^{
//
//            PLVDownloadCompleteInfoModel *model = [[PLVDownloadCompleteInfoModel alloc] init];
//            model.downloadInfo = info;
//            model.localVideo = [PLVVodLocalVideo localVideoWithVideo:info.video dir:[PLVVodDownloadManager sharedManager].downloadDir];
//            [weakSelf.downloadInfos addObject:model];
//
//            [weakSelf.tableView reloadData];
//        });
//    };
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)initVideoList{
    
    // 从数据库中读取已缓存视频详细信息
    // TODO:也可以从开发者自定义数据库中读取数据,方便扩展
    NSArray<PLVVodDownloadInfo *> *dbInfos = [[PLVVodDownloadManager sharedManager] requestDownloadCompleteList];
    
    JLog(@"下载完成视频++%@",dbInfos);
    
    NSString *where = [NSString stringWithFormat:@"where %@=%@ and %@=%@ and %@=%@",bg_sqlKey(@"userPhone"),bg_sqlValue(userMobile),bg_sqlKey(@"course_id"),bg_sqlValue(@(self.lastDownModel.course_id)),bg_sqlKey(@"isDownload"),bg_sqlValue(@1)];
   NSArray *datas = [DownloadInfo bg_find:childDownloadTable where:where];
   
    
    NSMutableDictionary *dbCachedDics = [[NSMutableDictionary alloc] init];
    [dbInfos enumerateObjectsUsingBlock:^(PLVVodDownloadInfo * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [dbCachedDics setObject:obj forKey:obj.vid];
        
//
       
    
    }];
    
    [datas enumerateObjectsUsingBlock:^(DownloadInfo  * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        for (PLVVodDownloadInfo *model in dbInfos) {
            if ([obj.identifier isEqualToString:model.identifier]) {
                PLVDownloadCompleteInfoModel *model = [[PLVDownloadCompleteInfoModel alloc] init];
                model.downloadInfo = obj.downloadInfo;
                [self.downloadInfos addObject:model];
            }
        }
    }];
    
    [self.tableView reloadData];
}

#pragma mark - property

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
    
    PLVDownloadComleteCell *cell = [tableView dequeueReusableCellWithIdentifier:[PLVDownloadComleteCell identifier]];
    
    PLVVodDownloadInfo *info = [self.downloadInfos objectAtIndex:indexPath.row].downloadInfo;
    
    cell.thumbnailUrl = info.snapshot;
    cell.titleLabel.text = info.title;
    if (info.fileType == PLVDownloadFileTypeAudio){
        //
        cell.titleLabel.text = [NSString stringWithFormat:@"[音频] %@", info.title];
    }
    
    NSInteger filesize = info.filesize;
    cell.videoSizeLabel.text = [self.class formatFilesize:filesize];
    cell.videoStateLable.text = [self.class timeFormatStringWithTime:info.duration];
    
    cell.downloadStateImgView.image = [UIImage imageNamed:@"plv_icon_download_will"];
    
    cell.backgroundColor = self.tableView.backgroundColor;
    
    return cell;
}




#pragma mark -- UITableViewDelegate --
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 播放本地缓存视频
    PLVVodDownloadInfo *info = self.downloadInfos[indexPath.row].downloadInfo;
    
    // 播放本地加密/非加密视频
    PLVVodPlaybackMode playMode;
    if (info.fileType == PLVDownloadFileTypeAudio){
        playMode = PLVVodPlaybackModeAudio;
    }
    else {
        playMode = PLVVodPlaybackModeVideo;
    }
    
#ifndef PLVSupportPPTScreen
//     普通视频播放页面入口
     VideoPLayVC *detailVC = [[VideoPLayVC alloc] init];
     detailVC.vid = info.vid;            // vid
     detailVC.isOffline = YES;           // 离线播放
     detailVC.playMode = playMode;       // 根据本地资源类型设置播放模式
#else
    
    // 三分屏模式视频播放页面入口
//    PLVPPTSimpleDetailController *detailVC = [[PLVPPTSimpleDetailController alloc] init];
//    detailVC.vid = info.vid;
//    detailVC.isOffline = YES;           // 离线播放
//    detailVC.playbackMode = playMode;       // 根据本地资源类型设置播放模式
    
#endif
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationController pushViewController:detailVC animated:YES];
    });
}

/// 删除
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    PLVVodDownloadManager *downloadManager = [PLVVodDownloadManager sharedManager];
    PLVDownloadCompleteInfoModel *localModel = self.downloadInfos[indexPath.row];
    
#ifndef PLVSupportDownloadAudio
    [downloadManager removeDownloadWithVid:localModel.downloadInfo.vid error:nil];
#else
    // 使用音频下载功能的客户，调用如下方法
    PLVVodVideoParams *params = [PLVVodVideoParams videoParamsWithVid:localModel.downloadInfo.vid
                                                             fileType:localModel.downloadInfo.fileType];
    [downloadManager removeDownloadWithVideoParams:params error:nil];
#endif
    
    
    [self.downloadInfos removeObject:localModel];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    NSString *where = [NSString stringWithFormat:@"where %@=%@ and %@=%@ and %@=%@",bg_sqlKey(@"userPhone"),bg_sqlValue(userMobile),bg_sqlKey(@"stautes"),bg_sqlValue(@1),bg_sqlKey(@"identifier"),bg_sqlValue(localModel.downloadInfo.identifier)];
    [PLVDownloadCompleteInfoModel bg_delete:mytableName where:where];
    [self initVideoList];
}


#pragma mark - util

+ (NSString *)formatFilesize:(NSInteger)filesize {
    return [NSByteCountFormatter stringFromByteCount:filesize countStyle:NSByteCountFormatterCountStyleFile];
}

+ (NSString *)timeFormatStringWithTime:(NSTimeInterval )time{
    
    NSInteger hour = time/60/60;
    NSInteger minite = (time - hour*60*60)/60;
    NSInteger second = (time - hour*60*60 - minite*60);
    
    NSString *timeStr =[NSString stringWithFormat:@"%02d:%02d:%02d", (int)hour, (int)minite,(int)second];
    
    return timeStr;
}

@end
