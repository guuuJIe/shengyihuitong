//
//  CatelogueCell.h
//  shengyihuitongApp
//
//  Created by Mac on 2020/6/26.
//  Copyright © 2020 温州轩捷贸易有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CatelogueCell : UITableViewCell
@property(nonatomic, strong) Child_list *detailModel;
@end

NS_ASSUME_NONNULL_END
