//
//  HomeBannerCell.m
//  shengyihuitongApp
//
//  Created by mac on 2020/6/23.
//  Copyright © 2020 mac. All rights reserved.
//

#import "HomeBannerCell.h"
#import "SDCycleScrollView.h"
@interface HomeBannerCell()<SDCycleScrollViewDelegate>
@property (nonatomic) SDCycleScrollView *focusHeadView;
@property (nonatomic) UILabel *carLbl;
@property (nonatomic) UILabel *subLbl;
@end
@implementation HomeBannerCell


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        self.contentView.backgroundColor = UIColor.redColor;
        [self setupUI];
        
    }
    
    return self;
}

- (void)setupUI{
    [self.focusHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
}


- (void)setDatas:(NSArray *)datas{
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 0; i<datas.count; i++) {
        NSDictionary *dic = datas[i];
        
        [images addObject:dic[@"act_img"]];
    }
    
    [self.focusHeadView setImageURLStringsGroup:images];
    
}


-(SDCycleScrollView *)focusHeadView{
    if (!_focusHeadView) {
        _focusHeadView = [SDCycleScrollView new];
        _focusHeadView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _focusHeadView.currentPageDotColor = UIColor.whiteColor;
        _focusHeadView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        _focusHeadView.pageControlDotSize = CGSizeMake(12, 2);
        _focusHeadView.delegate = self;

#ifdef DEBUG
        
//                [_focusHeadView setImageURLStringsGroup:@[@"http://cdnimg.jsojs.com/goods_item1/300085/icon.jpg@!414",@"http://cdnimg.jsojs.com/goods_item1/300085/icon06.jpg@!414"]];
        //#else
        
#endif
        
        [self.contentView addSubview:_focusHeadView];
    }
    return _focusHeadView;
}

@end
