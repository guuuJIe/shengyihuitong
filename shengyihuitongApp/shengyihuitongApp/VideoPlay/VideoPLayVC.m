//
//  VideoPLayVC.m
//  shengyihuitongApp
//
//  Created by 温州轩捷贸易有限公司 on 2020/6/28.
//  Copyright © 2020 温州轩捷贸易有限公司. All rights reserved.
//

#import "VideoPLayVC.h"
#import "PLVVodSkinPlayerController.h"
#import "PLVVodPlayerSkin.h"
#import "AppDelegate.h"
@interface VideoPLayVC ()
@property (nonatomic, strong) PLVVodSkinPlayerController *player;
@property (nonatomic, strong) UIView *playerPlaceholder;

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backAct) name:@"backAct" object:nil];
   
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
     [self.navigationController setNavigationBarHidden:true animated:true];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:true animated:true];
    
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

    
}



- (void)backAct{
    AppDelegate  *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.allowRoation = 0;
    [self.navigationController popViewControllerAnimated:true];

}




- (void)initVideo{
    
    PLVVodSkinPlayerController *player = [[PLVVodSkinPlayerController alloc] init];

    [player addPlayerOnPlaceholderView:self.playerPlaceholder rootViewController:self];
   
    player.rememberLastPosition = YES;
    player.enableBackgroundPlayback = false;
    [player setPlayerFullScreen:true];
    player.videoCaptureProtect = true;

    self.player = player;
   
    if (self.isOffline) {
        // 离线视频播放
        __weak typeof(self) weakSelf = self;
        
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
                [JMBManager showBriefAlert:@"视频加载失败"];
                return ;
            }
            self.player.video = video;
            
            //        [self.player play];
        }];
    }

   
 
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
