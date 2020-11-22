//
//  CateTableCell.h
//  shengyihuitongApp
//
//  Created by mac on 2020/6/24.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CateModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CateTableCell : UITableViewCell
@property (nonatomic, strong) CateModel *cateModel;
@end

NS_ASSUME_NONNULL_END
