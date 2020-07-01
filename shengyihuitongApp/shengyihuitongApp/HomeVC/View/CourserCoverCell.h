//
//  CourserCoverCell.h
//  shengyihuitongApp
//
//  Created by Mac on 2020/6/25.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CourserCoverCell : UITableViewCell
- (void)setupData:(NSDictionary *)dic;
@property (nonatomic, strong) CourseDetailModel *detailModel;
@end

NS_ASSUME_NONNULL_END
