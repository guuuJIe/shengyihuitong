//
//  AccLoginView.h
//  shengyihuitongApp
//
//  Created by mac on 2020/6/23.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AccLoginView : UIView
@property (nonatomic,copy) void(^clickBlock)(NSInteger type);
@property(nonatomic,strong) UITextField *acctextField;
@property(nonatomic,strong) UITextField *pwdtextField;
@end

NS_ASSUME_NONNULL_END
