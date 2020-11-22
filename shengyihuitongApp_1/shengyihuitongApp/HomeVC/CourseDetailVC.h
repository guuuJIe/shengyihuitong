//
//  CourseDetailVC.h
//  shengyihuitongApp
//
//  Created by Mac on 2020/6/25.
//  Copyright © 2020 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "PLVVodSkinPlayerController.h"
#import "PLVVodPlayerSkin.h"
NS_ASSUME_NONNULL_BEGIN

@interface CourseDetailVC : BaseViewController
@property (nonatomic, strong) NSDictionary *dic;
@property (nonatomic, strong) NSString *videoId;
@property (nonatomic, copy) NSString *vid;
@property (nonatomic, assign) BOOL isOffline;
@property (nonatomic, assign) PLVVodPlaybackMode playMode;
@end

NS_ASSUME_NONNULL_END
