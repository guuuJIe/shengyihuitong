//
//  HomeNavCollectionCell.h
//  shengyihuitongApp
//
//  Created by mac on 2020/6/23.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeNavCollectionCell : UICollectionViewCell
@property (nonatomic,copy) void(^clickBlock)(NSString *name);
@end

NS_ASSUME_NONNULL_END
