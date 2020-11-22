//
//  PLVDownloadCompleteInfoModel.h
//  shengyihuitongApp
//
//  Created by mac on 2020/6/29.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PLVVodLocalVideo;
@class PLVVodDownloadInfo;
NS_ASSUME_NONNULL_BEGIN

@interface PLVDownloadCompleteInfoModel : NSObject
@property (nonatomic, strong) PLVVodLocalVideo *localVideo;

@property (nonatomic, strong) PLVVodDownloadInfo *downloadInfo;
@property (nonatomic, strong) NSString *userPhone;
@property (nonatomic, assign) NSInteger stautes;
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, assign) NSInteger courseid;
@property (nonatomic, strong) NSString *vid;
@property (nonatomic, strong) NSString *chapter_name;
@end

NS_ASSUME_NONNULL_END
