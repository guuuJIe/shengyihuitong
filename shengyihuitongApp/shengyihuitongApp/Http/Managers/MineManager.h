//
//  MineManager.h
//  shengyihuitongApp
//
//  Created by Mac on 2020/6/26.
//  Copyright © 2020 温州轩捷贸易有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineManager : NSObject
/**
 我的课程
 @param completionHander completionHander description
 */
- (void)getUserCoursewithCompletionHandler:(MessageBodyNetworkCompletionHandler)completionHander;

/**
 我的班次
 @param completionHander completionHander description
 */
- (void)getUserSquadwithCompletionHandler:(MessageBodyNetworkCompletionHandler)completionHander;
@end

NS_ASSUME_NONNULL_END
