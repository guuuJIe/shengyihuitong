//
//  MessageBody.m
//  GoodsDetail
//
//  Created by chenqiang on 2017/12/29.
//  Copyright © 2017年 chenqiang. All rights reserved.
//

#import "MessageBody.h"


@implementation MessageBody

+ (instancetype)instanceWithResponseObject:(id)responseObject
                                withError:(NSError *)error
                    withTheDataModelClass:(Class)dataModelClass
                                  isArray:(bool)isArray
                                    isRow:(bool)isRow{
    
    if(!isRow){
        return [self instanceWithListResponseObject:responseObject withTheDataModelClass:dataModelClass withError:error isArray:isArray];
    }else{
        
        return [self instanceWithDataResponseObject:responseObject withTheDataModelClass:dataModelClass withError:error isArray:isArray];
    }
}
+ (instancetype)instanceWithListResponseObject:(id)responseObject withTheDataModelClass:(Class)dataModelClass withError:(NSError *)error isArray:(bool)isArray{
    
    MessageBody *body=[MessageBody new];
    body.datas = [NSMutableArray new];
    if(error){
        if(error.code == 999){
            body.message = error.domain;
            body.code = 999;
            body.error = error;
        }else{
            body.message=@"系统繁忙，请稍后重试!";
            body.code=505;
            body.error=error;
        }
        
    }else{
        NSDictionary *rODic= [NSDictionary dictionaryWithDictionary:responseObject];
       
        // 成功
        if([rODic[@"status"] integerValue] == 1)
        {
            NSDictionary *dict = rODic;
            body.code=[rODic[@"status"] integerValue];
            body.message=rODic[@"msg"];
          
            NSString *resultName;
            NSArray *resultNameArray = @[@"data"];
            for(NSString *rname in resultNameArray){
                if(dict[rname] != nil){
                    resultName = rname;
                    break;
                }
            }
           
            if(dataModelClass)
            {
                if(isArray){
                    body.result = [dataModelClass mj_objectArrayWithKeyValuesArray:dict[resultName]];

                }else{
                    body.result=[dataModelClass mj_objectWithKeyValues:dict[resultName]];
                }
            }else{
                if(isArray){
                    body.result=dict[resultName];
                }else{
                    body.result=dict[resultName];
                }
            }
            
        }else{
            
            // 其他的系统错误
            body.message = rODic[@"msg"];
            body.code = [rODic[@"code"] integerValue];
            body.message = rODic[@"error"];
            [body authen:[rODic[@"code"] integerValue]];
        }
    }
    return body;
    
}

+ (instancetype)instanceWithDataResponseObject:(id)responseObject withTheDataModelClass:(Class)dataModelClass withError:(NSError *)error isArray:(bool)isArray{
    
    MessageBody *body=[MessageBody new];
    
    if(error){
        if(error.code == 999){
            body.message = error.domain;
            body.code = 999;
            body.error = error;
        }else{
            body.message=@"系统繁忙，请稍后重试!";
            body.code=505;
            body.error=error;
            [body authen:204];
        }
        
    }else{
        NSDictionary *rODic= [NSDictionary dictionaryWithDictionary:responseObject];
        
        // 成功
        if([rODic[@"status"] integerValue] == 1)
        {
            NSDictionary *dict = rODic;
            body.code=[dict[@"status"] integerValue];
            body.message=dict[@"msg"];
            body.resultDic = dict;
            
            NSString *resultName;
            NSArray *resultNameArray = @[@"data",@"list",@"goods",@"obj"];
            for(NSString *rname in resultNameArray){
                if(dict[rname] != nil){
                    resultName = rname;
                    break;
                }
            }
     
            if(dataModelClass)
            {
                if(isArray){
                    body.result=[dataModelClass mj_objectArrayWithKeyValuesArray:dict[resultName]];
                }else{
                    body.result=[dataModelClass mj_objectWithKeyValues:dict[resultName]];
                    
                }
            }else
            {
                if(isArray){
                    body.result=dict[resultName];
                }else{
                    body.result=dict[resultName];
                }
            }
        }else{
            // 其他的系统错误
            body.message = rODic[@"msg"];
            body.code = [rODic[@"status"] integerValue];
//            body.message = rODic[@"error"];
            [JMBManager showBriefAlert:rODic[@"msg"]];
            [body authen:[rODic[@"status"] integerValue]];
        }
    }
    return body;
    
}

-(void)authen:(NSInteger)code
{
    if(code== 204)
    {
        self.message = nil;
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"quickLogin" object:nil];
//        [UserInfo sharedUserInfo].userModel = [UserModel new];
//        [[UserInfo sharedUserInfo]saveUserModel];
//        [JMBManager showBriefAlert:@"登录超时,请重新登录"];
//        [XJUtil resetDefaults];
        [JMBManager hideAlert];
        
        return;
    }
}



@end
