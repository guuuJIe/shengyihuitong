//
//  HomeManager.m
//  shengyihuitongApp
//
//  Created by mac on 2020/6/24.
//  Copyright © 2020 mac. All rights reserved.
//

#import "HomeManager.h"
@interface HomeManager()

@property (nonatomic , strong) JSHttpClient *client;

@end


@implementation HomeManager

- (void)getHomeDatawithCompletionHandler:(MessageBodyNetworkCompletionHandler)completionHander{
    [self.client get:Homeindex parameters:nil isNeedHeader:NO withCompletionHandler:^(NSError *error, id result) {
        MessageBody *body = [MessageBody instanceWithDataResponseObject:result withTheDataModelClass:nil withError:error isArray:NO];
        completionHander(error,body);
    }];
}

- (void)getJobDataWithparameters:(id)parameters withCompletionHandler:(MessageBodyNetworkCompletionHandler)completionHander{
    [self.client get:getJobCourse parameters:parameters isNeedHeader:NO withCompletionHandler:^(NSError *error, id result) {
        MessageBody *body = [MessageBody instanceWithDataResponseObject:result withTheDataModelClass:nil withError:error isArray:NO];
        completionHander(error,body);
    }];
}


- (void)getLiveDataWithparameters:(id)parameters withCompletionHandler:(MessageBodyNetworkCompletionHandler)completionHander{
    [self.client get:getLiveData parameters:parameters isNeedHeader:NO withCompletionHandler:^(NSError *error, id result) {
        MessageBody *body = [MessageBody instanceWithDataResponseObject:result withTheDataModelClass:nil withError:error isArray:NO];
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
