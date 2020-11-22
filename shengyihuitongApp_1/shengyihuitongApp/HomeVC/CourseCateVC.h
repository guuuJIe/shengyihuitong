//
//  CourseCateVC.h
//  shengyihuitongApp
//
//  Created by Mac on 2020/6/26.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CourseCateVC : UIViewController
@property(nonatomic, strong) CourseDetailModel *detailModel;
@property(nonatomic, strong) NSArray *datas;
@end

NS_ASSUME_NONNULL_END
