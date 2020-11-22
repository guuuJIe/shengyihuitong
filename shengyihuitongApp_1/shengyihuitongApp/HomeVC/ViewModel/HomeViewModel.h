//
//  HomeViewModel.h
//  shengyihuitongApp
//
//  Created by mac on 2020/6/24.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewModel : NSObject
@property (nonatomic, strong) NSArray *actityArr;
@property (nonatomic, strong) NSArray *freeArr;
@property (nonatomic, strong) NSArray *recommandArr;
@property (nonatomic,copy) void(^refreshBlock)(void);
- (void)refreshDataSource;
@end

NS_ASSUME_NONNULL_END
