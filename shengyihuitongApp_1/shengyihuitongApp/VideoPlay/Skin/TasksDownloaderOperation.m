//
//  TasksDownloaderOperation.m
//  MallApp
//
//  Created by mac on 2020/6/3.
//  Copyright © 2020 Mac. All rights reserved.
//



#import "TasksDownloaderOperation.h"


@interface TasksDownloaderOperation()

@property (copy, nonatomic) ExcuteBlock excutedBlock;
@property (assign, nonatomic, getter = isFinished) BOOL finished;

@end

@implementation TasksDownloaderOperation

@synthesize finished = _finished;

- (instancetype)initWithTask:(ExcuteBlock)block{
    if (self = [super init]) {
        _finished = NO;
//        _completedBlock = completionHander;
        _excutedBlock = block;
    }
    
    return self;
}


- (void)start{
    @synchronized (self) {
        if (self.isCancelled) {
            self.finished = true;
            [self reset];
            return;
        }
    }
    
    
    self.excutedBlock();
}

- (void)done {
    
    self.finished = YES;
    self.excutedBlock = nil;

}

- (void)reset{
    self.excutedBlock = nil;
}

- (void)setFinished:(BOOL)finished{
    [self willChangeValueForKey:@"isFinished"];
    _finished = finished;
    [self didChangeValueForKey:@"isFinished"];
}



@end
