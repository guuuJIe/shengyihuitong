//
//  VideoPLayVC.h
//  shengyihuitongApp
//
//  Created by 温州轩捷贸易有限公司 on 2020/6/28.
//  Copyright © 2020 温州轩捷贸易有限公司. All rights reserved.
//

#import <PLVVodSDK/PLVVodSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoPLayVC : BaseViewController
@property (nonatomic, strong) NSString *videoId;
@property (nonatomic, copy) NSString *vid;
@property (nonatomic, assign) BOOL isOffline;
@property (nonatomic, assign) PLVVodPlaybackMode playMode;

@end

NS_ASSUME_NONNULL_END
