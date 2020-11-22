//
//  MainTabarController.m
//  shengyihuitongApp
//
//  Created by mac on 2020/6/23.
//  Copyright © 2020 mac. All rights reserved.
//

#import "MainTabarController.h"
#import "HomeVC.h"
#import "QuestionVC.h"
#import "CourseVC.h"
#import "MineVC.h"
@interface MainTabarController ()<UITabBarControllerDelegate>

@end

@implementation MainTabarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self SetupAllControllers];
    self.tabBar.backgroundColor = [UIColor whiteColor];
}

- (void)SetupAllControllers{
    NSArray *titles = @[@"首页",@"题库",@"课程", @"我的",];
    NSArray *images = @[@"home_un",@"topic_un",@"course_un", @"user_un"];
    NSArray *selectedImages = @[@"home",@"topic",@"course", @"user"];
    HomeVC *main1 = [HomeVC new];
    QuestionVC *main2 = [QuestionVC new];
    CourseVC *main3 = [CourseVC new];
    MineVC *main4 = [MineVC new];
    NSArray *viewControllers = @[main1,main2,main3,main4];
    
    for (int i = 0; i < viewControllers.count; i++) {
        UIViewController *childVc = viewControllers[i];
        [self SetupChildVc:childVc title:titles[i] image:images[i] selectedImage:selectedImages[i]];
    }
}

- (void)SetupChildVc:(UIViewController *)VC title:(NSString *)title image:(NSString *)imageName selectedImage:(NSString *)selectedImageName{
//    [VC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
    VC.tabBarItem.title = title;
    [VC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: APPColor} forState:UIControlStateSelected];
    VC.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    VC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:VC];
    [self addChildViewController:nav];
}


- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    if (!accessToken) {
        self.selectedIndex = 0;
    }
    JLog(@"%@",item.title);
}





@end
