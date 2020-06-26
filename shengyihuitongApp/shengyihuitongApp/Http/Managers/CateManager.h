//
//  CateManager.h
//  shengyihuitongApp
//
//  Created by mac on 2020/6/24.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CateManager : NSObject
/**
 获取分类信息
 @param completionHander completionHander description
 */
- (void)getCategoryDatawithCompletionHandler:(MessageBodyNetworkCompletionHandler)completionHander;
@end

NS_ASSUME_NONNULL_END
