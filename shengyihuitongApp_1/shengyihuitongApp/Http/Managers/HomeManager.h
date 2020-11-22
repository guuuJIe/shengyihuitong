//
//  HomeManager.h
//  shengyihuitongApp
//
//  Created by mac on 2020/6/24.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeManager : NSObject
/**
 获取首页信息
 @param completionHander completionHander description
 */
- (void)getHomeDatawithCompletionHandler:(MessageBodyNetworkCompletionHandler)completionHander;


/**
 目录课程
 @param parameters parameters description
 @param completionHander completionHander description
 */
- (void)getJobDataWithparameters:(id)parameters withCompletionHandler:(MessageBodyNetworkCompletionHandler)completionHander;

/**
 直播数据
 @param parameters parameters description
 @param completionHander completionHander description
 */
- (void)getLiveDataWithparameters:(id)parameters withCompletionHandler:(MessageBodyNetworkCompletionHandler)completionHander;
@end

NS_ASSUME_NONNULL_END
