//
//  AccountManager.h
//  shengyihuitongApp
//
//  Created by mac on 2020/6/23.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AccountManager : NSObject
/**
 账号密码登录
 @param parameters parameters description
 @param completionHander completionHander description
 */
- (void)accountLoginWithparameters:(id)parameters withCompletionHandler:(MessageBodyNetworkCompletionHandler)completionHander;



/**
 获取用户信息
 @param completionHander completionHander description
 */
- (void)getUesrInfowithCompletionHandler:(MessageBodyNetworkCompletionHandler)completionHander;

/**
 用户注册
 @param parameters parameters description
 @param completionHander completionHander description
 */
- (void)userRegisterWithparameters:(id)parameters withCompletionHandler:(MessageBodyNetworkCompletionHandler)completionHander;


/**
 获取验证码
 @param parameters parameters description
 @param completionHander completionHander description
 */
- (void)getVerCodeWithparameters:(id)parameters withCompletionHandler:(MessageBodyNetworkCompletionHandler)completionHander;

/**
 忘记密码
 @param parameters parameters description
 @param completionHander completionHander description
 */
- (void)resetPwdWithparameters:(id)parameters withCompletionHandler:(MessageBodyNetworkCompletionHandler)completionHander;
@end

NS_ASSUME_NONNULL_END
