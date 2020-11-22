//
//  CommentView.h
//  shengyihuitongApp
//
//  Created by mac on 2020/6/27.
//  Copyright © 2020 mac. All rights reserved.
//

#import <MMPopupView/MMPopupView.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentView : MMPopupView
@property (nonatomic, copy) void (^submitBlock)(NSInteger score,NSString *comment);
@end

NS_ASSUME_NONNULL_END
