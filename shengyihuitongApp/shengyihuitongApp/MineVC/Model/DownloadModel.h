//
//  DownloadModel.h
//  shengyihuitongApp
//
//  Created by Mac on 2020/7/4.
//  Copyright © 2020 温州轩捷贸易有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CourseDetailModel.h"
@class PLVVodLocalVideo;
@class PLVVodDownloadInfo;
NS_ASSUME_NONNULL_BEGIN

@interface DownloadModel : NSObject
@property (nonatomic, assign)NSInteger course_id;
@property (nonatomic, strong)NSString *course_name;
@property (nonatomic, strong)NSString *course_img;
@property (nonatomic, strong)NSArray<DownloadInfo *> *downloadingList;
@property (nonatomic, strong)NSMutableArray<DownloadInfo *> *downloadedList;
@property (nonatomic, strong)NSString *userPhone;
@property (nonatomic, assign)NSInteger statues;//0表示下载中 1表示已下载
@property (nonatomic, assign)NSInteger downloading_num;//下载中
@property (nonatomic, assign)NSInteger downloaded_num;//已下载
@property (nonatomic, assign)NSInteger isfirst;//判断是否第一次进来
@property (nonatomic, strong)PLVVodDownloadInfo *downloadInfo;
@end

NS_ASSUME_NONNULL_END
