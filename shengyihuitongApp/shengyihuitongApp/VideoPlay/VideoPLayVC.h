//
//  VideoPLayVC.h
//  shengyihuitongApp
//
//  Created by mac on 2020/6/28.
//  Copyright © 2020 mac. All rights reserved.
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
