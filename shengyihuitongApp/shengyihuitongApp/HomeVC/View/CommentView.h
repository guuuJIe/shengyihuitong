//
//  CommentView.h
//  shengyihuitongApp
//
//  Created by 温州轩捷贸易有限公司 on 2020/6/27.
//  Copyright © 2020 温州轩捷贸易有限公司. All rights reserved.
//

#import <MMPopupView/MMPopupView.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentView : MMPopupView
@property (nonatomic, copy) void (^submitBlock)(NSInteger score,NSString *comment);
@end

NS_ASSUME_NONNULL_END
