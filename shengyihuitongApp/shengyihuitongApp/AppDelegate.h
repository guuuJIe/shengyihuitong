//
//  AppDelegate.h
//  shengyihuitongApp
//
//  Created by mac on 2020/6/23.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYLaunchAnimateViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, assign) BOOL allowRoation;

@property (nonatomic, strong) CYLaunchAnimateViewController *launchCtrl;
@end

