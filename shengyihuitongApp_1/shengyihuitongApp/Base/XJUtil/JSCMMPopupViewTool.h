//
//  JSCMMPopupViewTool.h
//  jsojscloud
//
//  Created by chenqiang on 2017/5/12.
//  Copyright © 2017年 qiangchen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMPopupView.h"
#import "MMAlertView.h"
#import "MMSheetView.h"
@interface JSCMMPopupViewTool : NSObject

+(void)showMMPopAlertWithTitle:(NSString *)title message:(NSString *)message withCancelButtonTitle:(NSString *)cancelTitle withSureButton:(NSString *)sureTitle andHandler:(MMPopupItemHandler)handler;

// 一直创建  ， 创建一个好用的


/**
 Alert (title 默认为 酒商提示)
 
 @param message 显示的消息
 @param handler 单个按钮
 */
+(void)showASingleButtonMMPopAlertWithMessage:(NSString *)message;


/**
 Alert (title 默认为 酒商提示)
 
 @param message 显示的消息
 @param handler 操作 确认按钮 取消按钮无事件
 */
+(void)showMMPopAlertWithMessage:(NSString *)message andMakeConfirmHandler:(MMPopupItemHandler)handler;


/**
 Alert (title 默认为 酒商提示)
 
 @param message 显示的消息
 @param handler 操作 确认按钮 取消按钮 有 事件
 */
+(void)showMMPopAlertWithMessage:(NSString *)message andHandler:(MMPopupItemHandler)handler;


/**
 Alert (title 默认为 酒商提示)
 
 @param message 显示的消息
 @param handler 操作 确认按钮 取消按钮 有 事件 并且可以设置 取消按钮 和 确认按钮 的title
 */
+(void)showMMPopAlertWithMessage:(NSString *)message withCancelButtonTitle:(NSString *)cancelTitle withSureButton:(NSString *)sureTitle andHandler:(MMPopupItemHandler)handler;

/**
 Alert (title)
 
 @param message 显示的消息
 @param handler 操作 确认按钮 取消按钮无事件
 */
+(void)showMMPopAlertWithMessage:(NSString *)message withYesButtonTitle:(NSString *)title andMakeConfirmHandler:(MMPopupItemHandler)handler;

/**
 sheet
 //    demo:
 //    NSArray *items =
 //    @[MMItemMake(@"Normal", MMItemTypeNormal, handler),
 //      MMItemMake(@"Highlight", MMItemTypeHighlight, handler),
 //      MMItemMake(@"Disabled", MMItemTypeDisabled, handler)];
 @param title title
 @param items items 所有按钮
 */
+(void)showMMPopSheetWithTitle:(NSString *)title withItemsArray:(NSArray *)items;


+(void)showUpdataAlert:(MMPopupItemHandler)handler;


@end
