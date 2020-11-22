//
//  CatelogueCell.h
//  shengyihuitongApp
//
//  Created by Mac on 2020/6/26.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CatelogueCell : UITableViewCell
@property(nonatomic, strong) Child_list *detailModel;
@property(nonatomic, strong) UIButton *selBtn;
@property(nonatomic, strong) Chapter_list *chapteModel;
@end

NS_ASSUME_NONNULL_END
