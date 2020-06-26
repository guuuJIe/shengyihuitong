//
//  BaseNavigationController.m
//  RebateApp
//
//  Created by Mac on 2019/11/12.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()<UINavigationBarDelegate,UIGestureRecognizerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong) UIPanGestureRecognizer *fullScreenPopPanGesture;
@end

@implementation BaseNavigationController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    
//    self.interactivePopGestureRecognizer.delegate = self;
     [self addFullScreenPopPanGesture];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}

- (void)addFullScreenPopPanGesture{
    
    self.fullScreenPopPanGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    self.fullScreenPopPanGesture.delegate = self;
    [self.view addGestureRecognizer:self.fullScreenPopPanGesture];
    [self.interactivePopGestureRecognizer requireGestureRecognizerToFail:self.fullScreenPopPanGesture];
    self.interactivePopGestureRecognizer.enabled = NO;
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
//    viewController.navigationItem.hidesBackButton=YES;
    if (self.childViewControllers.count>=1) {
//        [UINavigationBar appearance].backItem.hidesBackButton=YES;
//        viewController.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:self.backBtn];
        
//        viewController.hidesBottomBarWhenPushed = YES;
        viewController.tabBarController.tabBar.hidden = NO;
//        viewController.hidesBottomBarWhenPushed = NO;
        viewController.hidesBottomBarWhenPushed = YES;
    }else{
        
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)handleNavigationTransition:(UIPanGestureRecognizer *)ges{
    
    [self popToBack];
    
}

- (void)popToBack
{
    [self popViewControllerAnimated:YES];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer{
    if ([gestureRecognizer isEqual:self.fullScreenPopPanGesture]) {
        //获取手指移动后的相对偏移量
        CGPoint translationPoint = [self.fullScreenPopPanGesture translationInView:self.view];
        
        UIViewController *vc = self.viewControllers.lastObject;
        
//        if ([vc isKindOfClass:[GoodInfoVC class]]) {
//            return NO;
//        }
        //向右滑动 && 不是跟视图控制器
        if (translationPoint.x > 0 && self.childViewControllers.count > 1) {
            return YES;
        }
        return NO;
    }
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
