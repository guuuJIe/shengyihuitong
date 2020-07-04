//
//  CourseManager.h
//  shengyihuitongApp
//
//  Created by mac on 2020/6/24.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CourseManager : NSObject
/**
 获取首页信息
 @param completionHander completionHander description
 */
- (void)getCategoryDatawithCompletionHandler:(MessageBodyNetworkCompletionHandler)completionHander;


/**
 跳转答题
 @param parameters parameters description
 @param completionHander completionHander description
 */
- (void)jumpToQustionVCWithparameters:(id)parameters withCompletionHandler:(MessageBodyNetworkCompletionHandler)completionHander;


/**
 目录课程
 @param parameters parameters description
 @param completionHander completionHander description
 */
- (void)getCourseDataWithparameters:(id)parameters withCompletionHandler:(MessageBodyNetworkCompletionHandler)completionHander;

/**
 课程详情
 @param parameters parameters description
 @param completionHander completionHander description
 */
- (void)getCourseInfoDataWithparameters:(id)parameters withCompletionHandler:(MessageBodyNetworkCompletionHandler)completionHander;

/**
 课程列表
 @param parameters parameters description
 @param completionHander completionHander description
 */
- (void)getSquadListDataWithparameters:(id)parameters withCompletionHandler:(MessageBodyNetworkCompletionHandler)completionHander;

/**
 评论列表
 @param parameters parameters description
 @param completionHander completionHander description
 */
- (void)getCommentListDataWithparameters:(id)parameters withCompletionHandler:(MessageBodyNetworkCompletionHandler)completionHander;

/**
 发布评论
 @param parameters parameters description
 @param completionHander completionHander description
 */
- (void)publishCommentWithparameters:(id)parameters withCompletionHandler:(MessageBodyNetworkCompletionHandler)completionHander;


/**
 课程记录学习
 @param parameters parameters description
 @param completionHander completionHander description
 */
- (void)courseRecordWithparameters:(id)parameters withCompletionHandler:(MessageBodyNetworkCompletionHandler)completionHander;
@end

NS_ASSUME_NONNULL_END
