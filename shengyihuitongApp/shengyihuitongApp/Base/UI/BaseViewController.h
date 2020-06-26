//
//  BaseViewController.h
//  RebateApp
//
//  Created by Mac on 2019/11/12.
//  Copyright © 2019 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController
@property (nonatomic,strong)UIButton *backBtn;
-(void)backBtnClick;
@end

NS_ASSUME_NONNULL_END
