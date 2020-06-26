//
//  CateModel.h
//  shengyihuitongApp
//
//  Created by mac on 2020/6/24.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ClassInfo: NSObject
@property (nonatomic, copy) NSString *DealName;
@property (nonatomic, copy) NSString *Name;
@property (nonatomic, copy) NSString *AppEName;
@property (nonatomic, assign) NSInteger AppID;
@end

@interface CateModel : NSObject

@property (nonatomic, strong) NSArray<ClassInfo *> *classInfo;
@property (nonatomic, copy) NSString *KsbClassName;
@property (nonatomic, assign) NSInteger KsbClassID;
@property (nonatomic, assign) BOOL isSelected;
@end





NS_ASSUME_NONNULL_END
