//
//  MessageBody.h
//  GoodsDetail
//
//  Created by chenqiang on 2017/12/29.
//  Copyright © 2017年 chenqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageBody : NSObject

@property (nonatomic,assign) NSInteger code;
@property (nonatomic,strong)NSError *error;
@property (nonatomic,copy) NSString *message;
@property (nonatomic,strong) NSMutableArray *datas;
@property (nonatomic,strong) NSDictionary *resultDic;/**< 所有的数据 */
@property (nonatomic,strong) id result;/**< 返回数据 */


+(instancetype)instanceWithResponseObject:(id)responseObject
                                withError:(NSError *)error
                    withTheDataModelClass:(Class)dataModelClass
                                  isArray:(bool)isArray
                                    isRow:(bool)isRow;



/**
 第二节 list 中取数据
 
 @param responseObject responseObject description
 @param dataModelClass dataModelClass description
 @param error error description
 @return return value description
 */

+(instancetype)instanceWithListResponseObject:(id)responseObject withTheDataModelClass:(Class)dataModelClass withError:(NSError *)error isArray:(bool)isArray;


/**
 正常获取数据
 
 @param responseObject responseObject description
 @param dataModelClass dataModelClass description
 @param error error description
 @param isArray isArray description
 @return return value description
 */
+(instancetype)instanceWithDataResponseObject:(id)responseObject withTheDataModelClass:(Class)dataModelClass withError:(NSError *)error isArray:(bool)isArray;



@end
