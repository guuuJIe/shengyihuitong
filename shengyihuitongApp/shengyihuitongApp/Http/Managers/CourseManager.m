//
//  CourseManager.m
//  shengyihuitongApp
//
//  Created by mac on 2020/6/24.
//  Copyright © 2020 mac. All rights reserved.
//

#import "CourseManager.h"
@interface CourseManager()

@property (nonatomic , strong) JSHttpClient *client;

@end
@implementation CourseManager


- (void)getCategoryDatawithCompletionHandler:(MessageBodyNetworkCompletionHandler)completionHander{
    
    [self.client get:getthirdClass parameters:nil isNeedHeader:true withCompletionHandler:^(NSError *error, id result) {
           MessageBody *body = [MessageBody instanceWithListResponseObject:result withTheDataModelClass:NSClassFromString(@"CateModel") withError:error isArray:true];
           completionHander(error,body);
       }];
}


- (void)jumpToQustionVCWithparameters:(id)parameters withCompletionHandler:(MessageBodyNetworkCompletionHandler)completionHander{
    NSString *url = [NSString stringWithFormat:@"%@%@",getthirdLink,parameters];
    [self.client get:url parameters:nil isNeedHeader:true withCompletionHandler:^(NSError *error, id result) {
        MessageBody *body = [MessageBody instanceWithDataResponseObject:result withTheDataModelClass:nil withError:error isArray:NO];
        completionHander(error,body);
    }];
}

- (void)getCourseDataWithparameters:(id)parameters withCompletionHandler:(MessageBodyNetworkCompletionHandler)completionHander{
    [self.client get:getcourseData parameters:parameters isNeedHeader:true withCompletionHandler:^(NSError *error, id result) {
        MessageBody *body = [MessageBody instanceWithDataResponseObject:result withTheDataModelClass:nil withError:error isArray:true];
        completionHander(error,body);
    }];
}

- (void)getCourseInfoDataWithparameters:(id)parameters withCompletionHandler:(MessageBodyNetworkCompletionHandler)completionHander{
    NSString *url = [NSString stringWithFormat:@"%@%@",getCourseInfoData,parameters];
    [self.client get:url parameters:nil isNeedHeader:true withCompletionHandler:^(NSError *error, id result) {
        MessageBody *body = [MessageBody instanceWithDataResponseObject:result withTheDataModelClass:NSClassFromString(@"CourseDetailModel") withError:error isArray:false];
        completionHander(error,body);
    }];
}

- (void)getSquadListDataWithparameters:(id)parameters withCompletionHandler:(MessageBodyNetworkCompletionHandler)completionHander{
    NSString *url = [NSString stringWithFormat:@"%@%@",getSquadListData,parameters];
       [self.client get:url parameters:nil isNeedHeader:true withCompletionHandler:^(NSError *error, id result) {
           MessageBody *body = [MessageBody instanceWithDataResponseObject:result withTheDataModelClass:NSClassFromString(@"SquadModel") withError:error isArray:false];
           completionHander(error,body);
       }];
}

- (void)getCommentListDataWithparameters:(id)parameters withCompletionHandler:(MessageBodyNetworkCompletionHandler)completionHander{
    NSString *url = [NSString stringWithFormat:@"%@%@",getCommentList,parameters];
    [self.client get:url parameters:nil isNeedHeader:true withCompletionHandler:^(NSError *error, id result) {
        MessageBody *body = [MessageBody instanceWithDataResponseObject:result withTheDataModelClass:nil withError:error isArray:false];
        completionHander(error,body);
    }];
}

- (void)publishCommentWithparameters:(id)parameters withCompletionHandler:(MessageBodyNetworkCompletionHandler)completionHander{
    [self.client post:publishComment parameters:parameters isNeedHeader:true withCompletionHandler:^(NSError *error, id result) {
        MessageBody *body = [MessageBody instanceWithDataResponseObject:result withTheDataModelClass:nil withError:error isArray:false];
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
