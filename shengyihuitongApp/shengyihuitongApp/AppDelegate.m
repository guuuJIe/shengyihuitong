//
//  AppDelegate.m
//  shengyihuitongApp
//
//  Created by mac on 2020/6/23.
//  Copyright © 2020 mac. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabarController.h"
#import "LoginVC.h"
#import <PLVVodSDK/PLVVodSDK.h>
#import "PLVVodAccount.h"


static NSString * const PLVVodKeySettingKey = @"vodKey_preference";
static NSString * const PLVSdkVersionSettingKey = @"sdkVersion_preference";
static NSString * const PLVApplySettingKey = @"apply_preference";

@interface AppDelegate ()<UITabBarControllerDelegate>

@property (nonatomic,strong) MainTabarController *barContr;
@property (strong, nonatomic) UIView *launchView;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    

    
//    //设置窗口对象
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.barContr = [[MainTabarController alloc]init];
    self.barContr.delegate = self;
    self.window.rootViewController = self.barContr;
    //设置背景色
    self.window.backgroundColor = [UIColor whiteColor];

    [[UITabBar appearance] setTranslucent:NO];
    //显示窗口
    [self.window makeKeyAndVisible];

    
    // init launch view
    UIView *launchView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    launchView.backgroundColor = [UIColor yellowColor];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    imageView.image = [UIImage imageNamed:@"launchimage .jpg"];
    imageView.center = launchView.center;
    [launchView addSubview:imageView];
    
    
    NSInteger isAgree =  [[[NSUserDefaults standardUserDefaults] objectForKey:@"isAgree"] integerValue];
    
    if (isAgree != 1) {
        // init CYLaunchAnimateViewController
        CYLaunchAnimateViewController *launchCtrl = [[CYLaunchAnimateViewController alloc]initWithContentView:launchView animateType:CYLaunchAnimateTypeNone showSkipButton:false];
        self.launchCtrl = launchCtrl;
        
        [launchCtrl show];
    }
    
   
    
    [self registerLogin];

    [self settingConfig];

    [self downloadSetting];
    
    [self clearLaunchScreenCache];
    return YES;
}



- (void)registerLogin{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginAct) name:callLogin object:nil];
}

- (void)clearLaunchScreenCache {
    NSError *error;
    [NSFileManager.defaultManager removeItemAtPath:[NSString stringWithFormat:@"%@/Library/SplashBoard",NSHomeDirectory()] error:&error];
    if (error) {
        NSLog(@"Failed to delete launch screen cache: %@",error);
    }
}


- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if (tabBarController.selectedIndex == 1) {
        //判断用户是否登录
//
        if (!accessToken) {
            
            self.barContr.selectedIndex = 0;
            
            [self loginAct];
        }
         
    }
      
}

- (void)loginAct{
    LoginVC *VC = [LoginVC new];
    BaseNavigationController *vc = [[BaseNavigationController alloc] initWithRootViewController:VC];
    vc.modalPresentationStyle = 0;
    //            BaseViewController *vc = self.barContr.viewControllers[self.barContr.selectedIndex].childViewControllers.lastObject;
    [self.window.rootViewController presentViewController:vc animated:true completion:nil];
}


- (NSString *)getPreviousDownlaodDir{
    // SDK 默认存储路径,如果用户自定义存储路径，需要获取之前自定义的存储路径
    // /Library/Cache/PolyvVodCache
    NSString *downloadDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"PolyvVodCache"];
    return downloadDir;
}

- (void)settingConfig{
    
    NSError *error = nil;
    
    PLVVodSettings *settings = [PLVVodSettings settingsWithConfigString:PLVVodConfigString
                                                                    key:PLVVodDecodeKey
                                                                     iv:PLVVodDecodeIv
                                                                  error:&error];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:PLVApplySettingKey]) {
        // 读取并替换设置项。出于安全考虑，不建议从 plist 读取加密串，直接在代码中写入加密串更为安全。
        NSString *userVodKey = [[NSUserDefaults standardUserDefaults] stringForKey:PLVVodKeySettingKey];
        userVodKey = [userVodKey stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if (userVodKey.length) {
            settings = [PLVVodSettings settingsWithConfigString:userVodKey error:&error];
        }
    }
    
    NSLog(@"settings: %@", settings);
    if (error) {
        NSLog(@"account settings error: %@", error);
    }
}

- (void)downloadSetting {
     [PLVVodDownloadManager sharedManager].allowsCellularAccess = NO;
    // 下载配置参数
    [PLVVodDownloadManager sharedManager].autoStart = YES;
    [PLVVodDownloadManager sharedManager].maxRuningCount = 3;
    
    // 下载错误统一回调
    [PLVVodDownloadManager sharedManager].downloadErrorHandler = ^(PLVVodVideo *video, NSError *error) {
        NSLog(@"download error: %@\n%@", video.vid, error);
    };
    
    
    // 若需兼容 1.x.x 版本 SDK 视频，则需解注以下代码
    // 首先需确保 `[PLVVodDownloadManager sharedManager].downloadDir` 与之前版本的下载目录一致，然后调用兼容 1.x.x 离线视频方法
    //[PLVVodDownloadManager sharedManager].downloadDir = <#1.x.x版本的下载目录#>
    //[[PLVVodDownloadManager sharedManager] compatibleWithPreviousVideos];
    
#ifdef PLVSupportMultiAccount
    //  多账号配置,用于app多账号登入场景，一般用户可以不考虑
    //  升级到多账号下载模式
    //  开启多账号下载开关
    [PLVVodDownloadManager sharedManager].isMultiAccount = YES;
    
    // 设置前一个版本单帐号模式下的下载路径，用于数据迁移
    // 否则已缓存数据丢失
    NSString *previousDownloadDir = [self getPreviousDownlaodDir];
    [PLVVodDownloadManager sharedManager].previousDownloadDir = previousDownloadDir;
    
    // 登入到具体帐号,如果不调用，sdk使用默认帐号
    // 学员的用户id
    NSString *userId = @"111111";
    [[PLVVodDownloadManager sharedManager] switchDownloadAccount:userId];
#endif
}


#pragma mark - UIApplication lifecycle --

- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(nonnull NSString *)identifier completionHandler:(nonnull void (^)(void))completionHandler{
    [[PLVVodDownloadManager sharedManager] handleEventsForBackgroundURLSession:identifier completionHandler:completionHandler];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

    
    [[PLVVodDownloadManager sharedManager] applicationDidEnterBackground];
   
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
    
    [[PLVVodDownloadManager sharedManager] applicationWillEnterForeground];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[PLVVodDownloadManager sharedManager] applicationWillTerminate];
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    if (self.allowRoation == 1) {
        return UIInterfaceOrientationMaskLandscapeRight;
    }else{
        return (UIInterfaceOrientationMaskPortrait);
    }
}

// 支持设备自动旋转
- (BOOL)shouldAutorotate
{
//    if (self.allowRoation == 1) {
//        return YES;
//    }
    return NO;
}


@end
