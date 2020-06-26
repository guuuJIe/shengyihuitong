//
//  CateManager.m
//  shengyihuitongApp
//
//  Created by mac on 2020/6/24.
//  Copyright © 2020 mac. All rights reserved.
//

#import "CateManager.h"

@interface CateManager()

@property (nonatomic , strong) JSHttpClient *client;

@end

@implementation CateManager


- (void)getCategoryDatawithCompletionHandler:(MessageBodyNetworkCompletionHandler)completionHander{
    
    [self.client get:getcateData parameters:nil isNeedHeader:true withCompletionHandler:^(NSError *error, id result) {
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
