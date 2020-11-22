//
//  VideoPLayVC.m
//  shengyihuitongApp
//
//  Created by mac on 2020/6/28.
//  Copyright © 2020 mac. All rights reserved.
//

#import "VideoPLayVC.h"
#import "PLVVodSkinPlayerController.h"
#import "PLVVodPlayerSkin.h"
#import "AppDelegate.h"
#import "PLVDownloadCompleteInfoModel.h"
#import "CourseManager.h"
@interface VideoPLayVC ()
@property (nonatomic, strong) PLVVodSkinPlayerController *player;
@property (nonatomic, strong) UIView *playerPlaceholder;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) CourseManager *manager;
@end

@implementation VideoPLayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    appDelegate.allowRoation = 1;
    [self.navigationController setNavigationBarHidden:true animated:true];
    [self.view addSubview:self.playerPlaceholder];
    [self initVideo];
    [self findIndex];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backAct) name:@"backAct" object:nil];
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playBack) name:@"videoPlayBack" object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playNext) name:@"videoPlayNext" object:nil];
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:true animated:true];
    self.navigationController.interactivePopGestureRecognizer.enabled = false;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:true animated:true];
     self.navigationController.interactivePopGestureRecognizer.enabled = false;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    AppDelegate  *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.allowRoation = 0;
}


- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    AppDelegate  *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.allowRoation = 0;
    self.navigationController.interactivePopGestureRecognizer.enabled = true;

    
}



- (void)backAct{
    AppDelegate  *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.allowRoation = 0;
    [self.navigationController popViewControllerAnimated:false];
    if (self.player) {
        self.player = nil;

    }
}


- (void)playBack{
    
    WeakSelf(self)
    if (!self.isOffline) {
        self.index--;
        JLog(@"%ld",(long)self.index);
        if (self.index < 0) {
            self.index = 0;
            return;
        }
        
        NSDictionary *dic = self.datas[self.index];
        NSString *vid = [NSString stringWithFormat:@"%@",dic[@"video_id"]];
        NSString *chapter = [NSString stringWithFormat:@"%@",dic[@"chapter_id"]];
       
        [PLVVodVideo requestVideoWithVid:vid completion:^(PLVVodVideo *video, NSError *error) {
            if (!video) {
//                [JMBManager showBriefAlert:@"视频加载失败"];
                weakself.player.vid = vid; // 用于播放重试
                if (weakself.player.playerErrorHandler) {
                    weakself.player.playerErrorHandler(weakself.player, error);
                };
                self.index++;
                return ;
            }
            weakself.player.video = video;
            [self uploadLearnCourse:[chapter integerValue] withblock:^(NSError *error, MessageBody *result) {
                
            }];
        }];
    }else{
        self.indexpath--;
        if (self.indexpath < 0) {
            self.indexpath = 0;
            return;
        }
        self.player.playbackMode = self.playMode;
        PLVDownloadCompleteInfoModel *model = self.competeArray[self.indexpath];
        [PLVVodVideo requestVideoPriorityCacheWithVid:model.vid completion:^(PLVVodVideo *video, NSError *error) {
            weakself.player.video = video;
            dispatch_async(dispatch_get_main_queue(), ^{
                weakself.title = video.title;
            });
        }];
    }
    
}

- (void)dealloc{
    JLog(@"dealloc");
}

- (void)playNext{
   
   WeakSelf(self)
    if (!self.isOffline) {
        self.index++;
        JLog(@"%ld",(long)self.index);
        if (self.index>self.datas.count - 1) {
            self.index--;
//            [JMBManager showBriefAlert:@"您已经学完该课程啦"];
            return;
        }
        
        NSDictionary *dic = self.datas[self.index];
        NSString *vid = [NSString stringWithFormat:@"%@",dic[@"video_id"]];
        NSString *chapter = [NSString stringWithFormat:@"%@",dic[@"chapter_id"]];
        
        [PLVVodVideo requestVideoWithVid:vid completion:^(PLVVodVideo *video, NSError *error) {
            if (!video) {
//                [JMBManager showBriefAlert:@"视频加载失败"];
                weakself.player.vid = vid; // 用于播放重试
                if (weakself.player.playerErrorHandler) {
                    weakself.player.playerErrorHandler(weakself.player, error);
                };
                self.index--;
                return ;
            }
            
            [self uploadLearnCourse:[chapter integerValue] withblock:^(NSError *error, MessageBody *result) {
                
            }];
            weakself.player.video = video;
        }];
    }else{
        self.indexpath++;
        if (self.indexpath > self.competeArray.count - 1) {
            self.indexpath--;
            return;
        }
        
        self.player.playbackMode = self.playMode;
        PLVDownloadCompleteInfoModel *model = self.competeArray[self.indexpath];
        [PLVVodVideo requestVideoPriorityCacheWithVid:model.vid completion:^(PLVVodVideo *video, NSError *error) {
            weakself.player.video = video;
            dispatch_async(dispatch_get_main_queue(), ^{
                weakself.title = video.title;
            });
        }];
    }
}

- (void)findIndex{
    for (NSDictionary *dic in self.datas) {
        NSString *vid = [NSString stringWithFormat:@"%@",dic[@"video_id"]];
        if ([vid isEqualToString:self.videoId]) {
            
            self.index = [dic[@"index"] integerValue];
            break;
        }
    }
}


- (void)initVideo{
    
    PLVVodSkinPlayerController *player = [[PLVVodSkinPlayerController alloc] init];
 __weak typeof(self) weakSelf = self;
    [player addPlayerOnPlaceholderView:self.playerPlaceholder rootViewController:self];
    player.playbackRate = 1.0;
    player.rememberLastPosition = YES;
    player.enableBackgroundPlayback = false;
    [player setPlayerFullScreen:true];
    player.videoCaptureProtect = true;
//    player.quality = PLVVodQualityStandard;
    player.reachEndHandler = ^(PLVVodPlayerViewController *player) {
       
        [weakSelf playNext];
    };
    
//    player.playerErrorHandler = ^(PLVVodPlayerViewController *player, NSError *error) {
//        if (error) {
//             weakSelf.player.playerErrorHandler(weakSelf.player, error);
//        }
//    };
    self.player = player;
   
    if (self.isOffline) {
        // 离线视频播放
       
        
        // 根据资源类型设置默认播放模式。本地音频文件设定音频播放模式，本地视频文件设定视频播放模式
        // 只针对开通视频转音频服务的用户
        self.player.playbackMode = self.playMode;
        
        [PLVVodVideo requestVideoPriorityCacheWithVid:self.vid completion:^(PLVVodVideo *video, NSError *error) {
            
            weakSelf.player.video = video;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.title = video.title;
            });
        }];
    }else{
        if (!self.videoId) {
            [JMBManager showBriefAlert:@"无videoId"];
            return;
        }
        
        [PLVVodVideo requestVideoWithVid:self.videoId completion:^(PLVVodVideo *video, NSError *error) {
            if (!video) {
//                [JMBManager showBriefAlert:@"视频加载失败"];
                weakSelf.player.vid = self.videoId; // 用于播放重试
                if (weakSelf.player.playerErrorHandler) {
                    weakSelf.player.playerErrorHandler(weakSelf.player, error);
                };
                return ;
            }
            
            weakSelf.player.video = video;
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.title = video.title;
            });
            //        [self.player play];
        }];
    }

   
 
}


- (void)uploadLearnCourse:(NSInteger)chapter_id withblock:(MessageBodyNetworkCompletionHandler)completionHander{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:@(chapter_id) forKey:@"chapter_id"];
    [dic setValue:@"1" forKey:@"duration"];
    [dic setValue:@"1" forKey:@"last_video"];
    [self.manager courseRecordWithparameters:dic withCompletionHandler:^(NSError *error, MessageBody *result) {
        if (result.code == 1) {
            completionHander(error,result);
        }
        
    }];
}

- (CourseManager *)manager{
    if (!_manager) {
        _manager = [CourseManager new];
    }
    
    return _manager;
}


- (BOOL)prefersStatusBarHidden {
    return self.player.prefersStatusBarHidden;
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.player.preferredStatusBarStyle;
}

- (UIView *)playerPlaceholder {
    if (!_playerPlaceholder) {

        _playerPlaceholder = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width,200)];
    }
    return _playerPlaceholder;
}






@end
