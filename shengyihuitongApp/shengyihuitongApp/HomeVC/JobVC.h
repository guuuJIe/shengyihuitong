//
//  JobVC.h
//  shengyihuitongApp
//
//  Created by Mac on 2020/6/25.
//  Copyright © 2020 温州轩捷贸易有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JobVC : UIViewController
@property (nonatomic, strong) NSString *jobId;
- (void)getData;
@end

NS_ASSUME_NONNULL_END
