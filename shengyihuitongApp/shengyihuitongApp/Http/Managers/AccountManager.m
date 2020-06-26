//
//  AccountManager.m
//  shengyihuitongApp
//
//  Created by mac on 2020/6/23.
//  Copyright © 2020 mac. All rights reserved.
//

#import "AccountManager.h"
@interface AccountManager()

@property (nonatomic , strong) JSHttpClient *client;

@end
@implementation AccountManager
- (void)accountLoginWithparameters:(id)parameters withCompletionHandler:(MessageBodyNetworkCompletionHandler)completionHander
{
    [self.client post:appLogin parameters:parameters isNeedHeader:NO withCompletionHandler:^(NSError *error, id result) {
        MessageBody *body = [MessageBody instanceWithDataResponseObject:result withTheDataModelClass:nil withError:error isArray:NO];
        completionHander(error,body);
    }];
}



- (void)getUesrInfowithCompletionHandler:(MessageBodyNetworkCompletionHandler)completionHander{
    [self.client get:getUserInfo parameters:nil isNeedHeader:true withCompletionHandler:^(NSError *error, id result) {
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
