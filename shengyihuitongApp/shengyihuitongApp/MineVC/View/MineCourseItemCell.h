//
//  MineCourseItemCell.h
//  shengyihuitongApp
//
//  Created by Mac on 2020/6/26.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineCourseItemCell : UITableViewCell
@property (nonatomic, copy) void (^itemDownLoadBlock)(void);
- (void)setupData:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
