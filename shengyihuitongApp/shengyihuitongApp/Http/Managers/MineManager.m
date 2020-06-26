//
//  MineManager.m
//  shengyihuitongApp
//
//  Created by Mac on 2020/6/26.
//  Copyright © 2020 温州轩捷贸易有限公司. All rights reserved.
//

#import "MineManager.h"
@interface MineManager()

@property (nonatomic , strong) JSHttpClient *client;

@end
@implementation MineManager

- (void)getUserCoursewithCompletionHandler:(MessageBodyNetworkCompletionHandler)completionHander{
    [self.client get:getUserCourse parameters:nil isNeedHeader:true withCompletionHandler:^(NSError *error, id result) {
        MessageBody *body = [MessageBody instanceWithListResponseObject:result withTheDataModelClass:nil withError:error isArray:false];
        completionHander(error,body);
    }];
}

- (void)getUserSquadwithCompletionHandler:(MessageBodyNetworkCompletionHandler)completionHander{
    [self.client get:getUserSquad parameters:nil isNeedHeader:true withCompletionHandler:^(NSError *error, id result) {
        MessageBody *body = [MessageBody instanceWithListResponseObject:result withTheDataModelClass:nil withError:error isArray:false];
        completionHander(error,body);
    }];
}

- (JSHttpClient *)client
{
    if (!_client) {
        _client = [JSHttpClient shareClient];
    }
    return _client;
}
@end
