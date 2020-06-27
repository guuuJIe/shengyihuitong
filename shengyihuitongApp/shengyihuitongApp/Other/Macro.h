//
//  Macro.h
//  shengyihuitongApp
//
//  Created by mac on 2020/6/23.
//  Copyright © 2020 mac. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

typedef enum
{
    RefreshTypeNormal,//普通
    RefreshTypeUP,//上拉加载更多
    RefreshTypeDown//下拉刷新
} RefreshType; /* 表格数据更新的类型 */

//常用常量
#define AdapterScal  [UIScreen mainScreen].bounds.size.width/375.0
#define AdapterHeightScal  [UIScreen mainScreen].bounds.size.height/667
#define ViewHeight  CGRectGetHeight(self.view.frame)
//按比例获取宽度   根据375的屏幕
#define  C_WIDTH(WIDTH) WIDTH * [UIScreen mainScreen].bounds.size.width/375.0
#define AdjustsScrollViewInsetNever(controller,view) if(@available(iOS 11.0, *)) {view.contentInsetAdjustmentBehavior = UIApplicationBackgroundFetchIntervalNever;} else if([controller isKindOfClass:[UIViewController class]]) {controller.automaticallyAdjustsScrollViewInsets = false;}
#define Screen_Height [UIScreen mainScreen].bounds.size.height
#define Screen_Width [UIScreen mainScreen].bounds.size.width


#define iPhoneX_Serials Screen_Width > 375.f && Screen_Height >= 812.f
#define StatusBarAndNavigationBarHeight (iPhoneX_Serials ? 88.f : 64.f)
#define StatusBarHeight (Screen_Height < 812.f ? 20 : 44)
#define BottomAreaHeight (Screen_Height >= 812.0f ? 34 : 0)

#define lineHeihgt 1.0/[UIScreen mainScreen].scale
#define TabBarHeight self.tabBarController.tabBar.frame.size.height
#define Max_Size CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)
#define Default_Space 10
#define Default_Line 0.5
#define SOURCE_APPLICATION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
//弱引用
#define WeakSelf(type)__weak typeof(type)weak##type = type;

//强引用
#define StrongSelf(type)__strong typeof(type)type = weak##type;

// NSLog
#ifdef DEBUG
#define JLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define JLog(...)
#endif


#ifndef XJ_LOCK
#define XJ_LOCK(lock) dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
#endif

#ifndef XJ_UNLOCK
#define XJ_UNLOCK(lock) dispatch_semaphore_signal(lock);
#endif

#define IOS_VERSION ([[[UIDevice currentDevice] systemVersion] floatValue])

#define refreshUserInfo @"refreshUserInfo"
#define callLogin @"callLogin"
//颜色
#define APPFourColor [UIColor colorWithHexString:@"363636"]
#define APPColor [UIColor colorWithHexString:@"185399"]
#define LabelTextColor191919 [UIColor colorWithHexString:@"191919"]
#define LabelTextColorff4c4c [UIColor colorWithHexString:@"ff4c4c"]
#define bgColor [UIColor colorWithHexString:@"f7f7f7"]
#define FF3E3E [UIColor colorWithHexString:@"FF3E3E"]
#define UIColorBF [UIColor colorWithHexString:@"BFBFBF"]
#define shawdowColor [UIColor colorWithHexString:@"0A3281"]
#define UIColor999 [UIColor colorWithHexString:@"999999"]
#define UIColor448 [UIColor colorWithHexString:@"4483FF"]
#define UIColor276 [UIColor colorWithHexString:@"276FFF"]
#define UIColor333 [UIColor colorWithHexString:@"333333"]
#define UIColorF5F7 [UIColor colorWithHexString:@"F5F7FA"]
#define fenseColor [UIColor colorWithHexString:@"FF5891"]
#define UIColorEF [UIColor colorWithHexString:@"EFEFEF"]
#define UIColorEE [UIColor colorWithHexString:@"EEEEEE"]
#define UIColorFF3E [UIColor colorWithHexString:@"FF3E3E"]
#define UIColorB6 [UIColor colorWithHexString:@"B6B6B6"]
#define UIColorB2 [UIColor colorWithHexString:@"B2B2B2"]
#define UIColor08 [UIColor colorWithHexString:@"0084FA"]
#define UIColor66 [UIColor colorWithHexString:@"666666"]
#define UIColor70 [UIColor colorWithHexString:@"707070"]
#define UIColorFDC4 [UIColor colorWithHexString:@"FDC45C"]
#define UIColorFDC8 [UIColor colorWithHexString:@"FD486C"]
#define UIColorE9 [UIColor colorWithHexString:@"E9E9E9"]
#define UIColorED [UIColor colorWithHexString:@"EDEDED"]
#define UIColorCC [UIColor colorWithHexString:@"CCCCCC"]
#define UIColorAE [UIColor colorWithHexString:@"AECAEF"]
#define UIColorA8 [UIColor colorWithHexString:@"A8A8A8"]
#define UIColorFFD1 [UIColor colorWithHexString:@"FFD1D1"]
#define UIColor1F85 [UIColor colorWithHexString:@"1F8529"]
#define UIColorFFA1 [UIColor colorWithHexString:@"FFA127"]
#define UIColor60 [UIColor colorWithHexString:@"606266"]
#define UIColor90 [UIColor colorWithHexString:@"909399"]
#define UIColorF0F5 [UIColor colorWithHexString:@"F0F5FF"]
#define UIColorFF9F [UIColor colorWithHexString:@"FF9F33"]
#define UIColorFF65 [UIColor colorWithHexString:@"FF6511"]
#define UIColorFFDA [UIColor colorWithHexString:@"FFDA00"]
#define UIColor9BC [UIColor colorWithHexString:@"9BC65B"]
// label font
#define LabelFont21 [UIFont systemFontOfSize:21]
#define LabelFont20 [UIFont systemFontOfSize:20]
#define LabelFont14 [UIFont systemFontOfSize:14]
#define LabelFont13 [UIFont systemFontOfSize:13]
#define LabelFont15 [UIFont systemFontOfSize:15]
#define LabelFont12 [UIFont systemFontOfSize:12]
#define LabelFont11 [UIFont systemFontOfSize:11]
#define LabelFont10 [UIFont systemFontOfSize:10]
#define LabelFont9  [UIFont systemFontOfSize:9]
#define LabelFont18 [UIFont systemFontOfSize:18]
#define LabelFont16 [UIFont systemFontOfSize:16]
#define LabelFont30 [UIFont systemFontOfSize:30]

#define URL(url) [NSURL URLWithString:url]

#define accessToken [[NSUserDefaults standardUserDefaults]objectForKey:@"accessToken"]

#endif /* Macro_h */
