//
//  TasksDownloaderOperation.h
//  MallApp
//
//  Created by mac on 2020/6/3.
//  Copyright © 2020 Mac. All rights reserved.
//

typedef void(^ExcuteBlock)(void);

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TasksDownloaderOperation : NSOperation
/**
*  Notify TasksCurrent's statues,then achiev
*
*  @*/
@property (copy, nonatomic) ExcuteBlock completedBlock;

/**
*  Initializes a `TasksDownloaderOperation` object
*
*  @*/
- (instancetype)initWithTask:(ExcuteBlock)block;

/**
   tash Done.    Whatever Task Successed or failed
 */

- (void)done;
@end

NS_ASSUME_NONNULL_END
