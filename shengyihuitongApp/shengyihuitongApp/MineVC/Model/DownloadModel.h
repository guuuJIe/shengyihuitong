//
//  DownloadModel.h
//  shengyihuitongApp
//
//  Created by Mac on 2020/7/4.
//  Copyright © 2020 温州轩捷贸易有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CourseDetailModel.h"
@class PLVVodDownloadInfo;
NS_ASSUME_NONNULL_BEGIN

@interface DownloadModel : NSObject
@property (nonatomic, assign)NSInteger course_id;
@property (nonatomic, strong)NSString *course_name;
@property (nonatomic, strong)NSString *course_img;
@property (nonatomic, strong)DownloadInfo *child_list;
@property (nonatomic, strong)NSString *userPhone;
@property (nonatomic, assign)NSInteger statues;//0表示下载中 1表示已下载
//@property (nonatomic, strong) PLVVodDownloadInfo *downloadInfo;
@end

NS_ASSUME_NONNULL_END
