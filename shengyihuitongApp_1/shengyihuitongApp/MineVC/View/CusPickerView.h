//
//  CusPickerView.h
//  MallApp
//
//  Created by Mac on 2020/1/11.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^MybasicBlock)(id result,id result2,NSString *value);
@interface CusPickerView : UIView
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, copy) MybasicBlock selectBlock;

/**
 按钮颜色
 */
@property (nonatomic, strong) UIColor *btnTitleColor;

/**
 背景颜色
 */
@property (nonatomic, strong) UIColor *baseViewColor;


- (void)popPickerView;


@end

NS_ASSUME_NONNULL_END
