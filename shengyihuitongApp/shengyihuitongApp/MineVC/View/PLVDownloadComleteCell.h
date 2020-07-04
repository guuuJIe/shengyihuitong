//
//  PLVDownloadComleteCell.h
//  shengyihuitongApp
//
//  Created by mac on 2020/6/29.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PLVDownloadComleteCell : UITableViewCell
@property (nonatomic, strong) UIImageView *thumbnailView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *downloadStateImgView;
@property (nonatomic, strong) UILabel *videoSizeLabel;
@property (nonatomic, strong) UILabel *videoStateLable;
@property (copy, nonatomic) NSString *thumbnailUrl;

+ (NSString *)identifier;
@end

NS_ASSUME_NONNULL_END
