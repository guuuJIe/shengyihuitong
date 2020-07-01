//
//  PLVDownloadCompleteInfoModel.h
//  shengyihuitongApp
//
//  Created by 温州轩捷贸易有限公司 on 2020/6/29.
//  Copyright © 2020 温州轩捷贸易有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PLVVodLocalVideo;
@class PLVVodDownloadInfo;
NS_ASSUME_NONNULL_BEGIN

@interface PLVDownloadCompleteInfoModel : NSObject
@property (nonatomic, strong) PLVVodLocalVideo *localVideo;

@property (nonatomic, strong) PLVVodDownloadInfo *downloadInfo;
@end

NS_ASSUME_NONNULL_END
