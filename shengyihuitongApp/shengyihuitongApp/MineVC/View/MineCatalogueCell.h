//
//  MineCatalogueCell.h
//  shengyihuitongApp
//
//  Created by 温州轩捷贸易有限公司 on 2020/6/29.
//  Copyright © 2020 温州轩捷贸易有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MineCatalogueCell : UITableViewCell
@property(nonatomic, strong) Child_list *detailModel;
/**
 选中
 */
@property (nonatomic, copy) void (^clickRowBlock)(BOOL isClick);
@end

NS_ASSUME_NONNULL_END
