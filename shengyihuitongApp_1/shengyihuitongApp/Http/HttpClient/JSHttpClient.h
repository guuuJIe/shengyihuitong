//
//  JSHttpClient.h
//  Hacker
//
//  Created by chenqiang on 2018/9/19.
//  Copyright © 2018年 Hacker. All rights reserved.
//

#import <Foundation/Foundation.h>

//NS_ASSUME_NONNULL_BEGIN

//公用block
typedef void(^NetworkCompletionHandler)(NSError *error, id result);
typedef void(^MessageBodyNetworkCompletionHandler)(NSError *error, MessageBody *result);

@interface JSHttpClient : NSObject

+ (JSHttpClient *)shareClient;
/**
 正常请求
 @param isNeed 是否需要Header
 */
- (void)get:(NSString *)URLString parameters:(id)inpParameters isNeedHeader:(bool)isNeed withCompletionHandler:(NetworkCompletionHandler)completionHander;
/**
 正常请求
 */
- (void)post:(NSString *)action parameters:(id)inpParameters isNeedHeader:(bool)isNeed withCompletionHandler:(NetworkCompletionHandler)completionHander;

/**
 上传多张图
 @param images NSArray 放 Dic -  name image
 */
- (void)postUploadWithAction:(NSString *)action parameters:(id)inpParameters uploadImages:(NSArray *)images  withCompletionHandler:(NetworkCompletionHandler)completionHander;
@end

//NS_ASSUME_NONNULL_END
