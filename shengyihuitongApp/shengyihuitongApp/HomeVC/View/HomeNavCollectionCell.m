//
//  HomeNavCollectionCell.m
//  shengyihuitongApp
//
//  Created by mac on 2020/6/23.
//  Copyright © 2020 mac. All rights reserved.
//

#import "HomeNavCollectionCell.h"
#import "FuncItemCell.h"
@interface HomeNavCollectionCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic) UICollectionView *colletionView;
@property (nonatomic) NSMutableArray *dataArr;
@end

@implementation HomeNavCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
       
        
        [self setupLayout];
    }
    
    return self;
}

- (void)setupLayout
{
    [self.contentView addSubview:self.colletionView];
    [self.colletionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.contentView);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FuncItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FuncItemCell" forIndexPath:indexPath];

    [cell setupData:self.dataArr[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.dataArr[indexPath.row];
    if (self.clickBlock) {
         self.clickBlock(dic[@"name"]);
    }
}


- (UICollectionView *)colletionView
{
    if (!_colletionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(Screen_Width/4, 85);
        flowLayout.minimumLineSpacing = 0.0;
        flowLayout.minimumInteritemSpacing = 0.0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _colletionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _colletionView.showsVerticalScrollIndicator = NO;
        _colletionView.showsHorizontalScrollIndicator = NO;
        _colletionView.backgroundColor = [UIColor whiteColor];
        _colletionView.delegate = self;
        _colletionView.dataSource = self;
        [_colletionView registerClass:[FuncItemCell class] forCellWithReuseIdentifier:@"FuncItemCell"];
    }
    return _colletionView;
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        
        _dataArr = [NSMutableArray array];
        NSArray *arr = [NSArray arrayWithObjects:
  @{@"name":@"执业药师",@"image":@"nav_zyys"},@{@"name":@"执业医师",@"image":@"nav_zyyis"},@{@"name":@"中医师承",@"image":@"nav_zysc"},@{@"name":@"健康管理",@"image":@"nav_xxms"},@{@"name":@"乡村全科",@"image":@"nav_xcqk"},@{@"name":@"卫生职称",@"image":@"nav_wszc"},@{@"name":@"执业护士",@"image":@"nav_zyhs"},@{@"name":@"全部分类",@"image":@"all"}, nil];
        //@{@"name":@"全车保修",@"image":@"item5"},@{@"name":@"一年保养",@"image":@"item6"},@{@"name":@"随心砍",@"image":@"item7"},
        [_dataArr addObjectsFromArray:arr];
    }
    return _dataArr;
}


@end
