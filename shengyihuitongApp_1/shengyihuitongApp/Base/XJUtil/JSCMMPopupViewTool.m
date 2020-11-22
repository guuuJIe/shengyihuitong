//
//  JSCMMPopupViewTool.m
//  jsojscloud
//
//  Created by chenqiang on 2017/5/12.
//  Copyright © 2017年 qiangchen. All rights reserved.
//

#import "JSCMMPopupViewTool.h"

@implementation JSCMMPopupViewTool



+(void)showMMPopAlertWithTitle:(NSString *)title message:(NSString *)message withCancelButtonTitle:(NSString *)cancelTitle withSureButton:(NSString *)sureTitle andHandler:(MMPopupItemHandler)handler{
    NSArray *items =
    @[MMItemMake(cancelTitle, MMItemTypeNormal, handler),
      MMItemMake(sureTitle, MMItemTypeHighlight, handler),
      ];
    
    MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:title
                                                         detail:message
                                                          items:items];
    alertView.attachedView.mm_dimBackgroundBlurEnabled = NO;
    alertView.attachedView.mm_dimBackgroundBlurEffectStyle = UIBlurEffectStyleLight;
    
    [alertView show];
}

+(void)showMMPopAlertWithMessage:(NSString *)message withCancelButtonTitle:(NSString *)cancelTitle withSureButton:(NSString *)sureTitle andHandler:(MMPopupItemHandler)handler{
    NSArray *items =
    @[MMItemMake(cancelTitle, MMItemTypeNormal, handler),
      MMItemMake(sureTitle, MMItemTypeHighlight, handler),
      ];
    
    MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:@"酒商提示"
                                                         detail:message
                                                          items:items];
    alertView.attachedView.mm_dimBackgroundBlurEnabled = NO;
    alertView.attachedView.mm_dimBackgroundBlurEffectStyle = UIBlurEffectStyleLight;
    
    [alertView show];
}

+(void)showASingleButtonMMPopAlertWithMessage:(NSString *)message{
    
    NSArray *items =
    @[
      MMItemMake(@"确定", MMItemTypeHighlight, nil),
      ];
    
    MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:@"酒商提示"
                                                         detail:message
                                                          items:items];
    alertView.attachedView.mm_dimBackgroundBlurEnabled = NO;
    alertView.attachedView.mm_dimBackgroundBlurEffectStyle = UIBlurEffectStyleLight;
    
    [alertView show];
    
    
    
}

+(void)showMMPopAlertWithMessage:(NSString *)message withYesButtonTitle:(NSString *)title andMakeConfirmHandler:(MMPopupItemHandler)handler{
    
    NSArray *items =
    @[MMItemMake(@"取消", MMItemTypeNormal, nil),
      MMItemMake(title, MMItemTypeHighlight, handler),
      ];
    
    MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:@"提示"
                                                         detail:message
                                                          items:items];
    alertView.attachedView.mm_dimBackgroundBlurEnabled = NO;
    alertView.attachedView.mm_dimBackgroundBlurEffectStyle = UIBlurEffectStyleLight;
    
    [alertView show];
    
    
    
}
+(void)showMMPopAlertWithMessage:(NSString *)message andMakeConfirmHandler:(MMPopupItemHandler)handler{
    
    NSArray *items =
  @[MMItemMake(@"取消", MMItemTypeNormal, nil),
    MMItemMake(@"确定", MMItemTypeHighlight, handler),
    ];
    
    MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:@"提示"
                                                         detail:message
                                                          items:items];
    alertView.attachedView.mm_dimBackgroundBlurEnabled = NO;
    alertView.attachedView.mm_dimBackgroundBlurEffectStyle = UIBlurEffectStyleLight;
    
    [alertView show];
}

+(void)showMMPopAlertWithMessage:(NSString *)message andHandler:(MMPopupItemHandler)handler{
    MMPopupItem *item = MMItemMake(@"确定", MMItemTypeHighlight, handler);
    item.color = APPColor;
    NSArray *items =
    @[MMItemMake(@"取消", MMItemTypeNormal, handler),
      item,
      ];
    
    MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:@"提示"
                                                         detail:message
                                                          items:items];
    alertView.attachedView.mm_dimBackgroundBlurEnabled = NO;
    alertView.attachedView.mm_dimBackgroundBlurEffectStyle = UIBlurEffectStyleLight;
    
    [alertView show];
}

+(void)showMMPopSheetWithTitle:(NSString *)title withItemsArray:(NSArray *)items{
//    demo:
//    NSArray *items =
//    @[MMItemMake(@"Normal", MMItemTypeNormal, handler),
//      MMItemMake(@"Highlight", MMItemTypeHighlight, handler),
//      MMItemMake(@"Disabled", MMItemTypeDisabled, handler)];
//    MMPopupItemHandler mblock = ^(NSInteger index){
//        @strongify(self);
//        JSLog(@"%ld",(long)index);
//        [self actionSheetClickedButtonAtIndex:index];
//    };
    
    MMSheetView *sheetView = [[MMSheetView alloc] initWithTitle:title
                                  items:items] ;
    sheetView.attachedView.mm_dimBackgroundBlurEnabled = NO;
    sheetView.attachedView.mm_dimBackgroundBlurEffectStyle = UIBlurEffectStyleLight;
    [sheetView show];
}

+(void)showUpdataAlert:(MMPopupItemHandler)handler{
    NSArray *items =
    @[MMItemMake(@"更新", MMItemTypeNormal, handler),
      ];
    
    MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:@"提示"
                                                         detail:@"版本有更新，赶紧去升级!"
                                                          items:items];
    alertView.attachedView.mm_dimBackgroundBlurEnabled = NO;
    alertView.attachedView.mm_dimBackgroundBlurEffectStyle = UIBlurEffectStyleLight;
    
    [alertView show];
    
}

@end
