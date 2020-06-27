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
@interface AppDelegate ()<UITabBarControllerDelegate>

@property (nonatomic,strong) MainTabarController *barContr;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //设置窗口对象
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.barContr = [[MainTabarController alloc]init];
    self.barContr.delegate = self;
    self.window.rootViewController = self.barContr;
    //设置背景色
    self.window.backgroundColor = [UIColor whiteColor];
    
    [[UITabBar appearance] setTranslucent:NO];
    //显示窗口
    [self.window makeKeyAndVisible];
    
    [self registerLogin];
    return YES;
}



- (void)registerLogin{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginAct) name:callLogin object:nil];
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

#pragma mark - UISceneSession lifecycle


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//    JLog(@"111");
   
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
