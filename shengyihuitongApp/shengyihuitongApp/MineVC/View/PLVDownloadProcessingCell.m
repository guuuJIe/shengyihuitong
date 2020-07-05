//
//  PLVDownloadProcessingCell.m
//  shengyihuitongApp
//
//  Created by mac on 2020/6/29.
//  Copyright © 2020 mac. All rights reserved.
//

#import "PLVDownloadProcessingCell.h"
@interface PLVDownloadProcessingCell()

@end

@implementation PLVDownloadProcessingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = UIColor.whiteColor;
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI{
    
    [self.contentView addSubview:self.thumbnailView];
    [self.thumbnailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(15);
        make.bottom.mas_equalTo(-15);
        make.size.mas_equalTo(CGSizeMake(120*AdapterScal, 72*AdapterScal));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.thumbnailView.mas_right).offset(10);
        make.top.mas_equalTo(self.thumbnailView);
        make.right.mas_equalTo(-10);
    }];
    
    [self.contentView addSubview:self.downloadStateImgView];
    [self.downloadStateImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.size.mas_equalTo(CGSizeMake(14, 14));
        make.bottom.mas_equalTo(self.thumbnailView);
    }];
    
    [self.videoStateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.downloadStateImgView.mas_right).offset(7);
        make.centerY.mas_equalTo(self.downloadStateImgView);
    }];
    
    [self.videoSizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(self.videoStateLable);
    }];
}

- (void)setThumbnailUrl:(NSString *)thumbnailUrl {
    _thumbnailUrl = thumbnailUrl;
    [self.thumbnailView sd_setImageWithURL:URL(thumbnailUrl) placeholderImage:[UIImage imageNamed:@"plv_ph_courseCover"]];
}




- (UIImageView *)thumbnailView{
    if (!_thumbnailView) {
        _thumbnailView = [UIImageView new];
    }
    
    return _thumbnailView;
}

- (UIImageView *)downloadStateImgView{
    if (!_downloadStateImgView) {
        _downloadStateImgView = [UIImageView new];
    }
    
    return _downloadStateImgView;
}

-(UILabel *)titleLabel
{
    if(!_titleLabel)
    {
        _titleLabel = [UILabel commonLabelWithtext:@"标题" color:UIColor333 font:LabelFont14 textAlignment:NSTextAlignmentLeft];
        _titleLabel.numberOfLines = 2;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(UILabel *)videoStateLable
{
    if(!_videoStateLable)
    {
        _videoStateLable = [UILabel commonLabelWithtext:@"下载中" color:UIColor333 font:LabelFont14 textAlignment:NSTextAlignmentLeft];
        _videoStateLable.numberOfLines = 2;
        [self.contentView addSubview:_videoStateLable];
    }
    return _videoStateLable;
}

-(UILabel *)videoSizeLabel
{
    if(!_videoSizeLabel)
    {
        _videoSizeLabel = [UILabel commonLabelWithtext:@"1M" color:UIColor333 font:LabelFont14 textAlignment:NSTextAlignmentLeft];
        _videoSizeLabel.numberOfLines = 2;
        [self.contentView addSubview:_videoSizeLabel];
    }
    return _videoSizeLabel;
}

+ (NSString *)identifier{
    return NSStringFromClass([self class]);
}

@end
