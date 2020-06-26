//
//  LiveVC.m
//  shengyihuitongApp
//
//  Created by Mac on 2020/6/25.
//  Copyright © 2020 温州轩捷贸易有限公司. All rights reserved.
//

#import "LiveVC.h"
#import "LiveItemCell.h"
#import "LiveTitleView.h"
#import "HomeManager.h"
#import "CourseDetailVC.h"
@interface LiveVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *course_latestArray;
@property (nonatomic, strong) NSArray *course_listArray;
@property (nonatomic, strong) HomeManager *manager;
@end

@implementation LiveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    [self getData];
}

- (void)setupUI{
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(-46-StatusBarAndNavigationBarHeight);
    }];
}


- (void)getData{
    NSDictionary *dic = @{@"job_id":self.jobId};
    [self.manager getLiveDataWithparameters:dic withCompletionHandler:^(NSError *error, MessageBody *result) {
        if (result.code == 1) {
            NSDictionary *dic = result.result;
            self.course_latestArray = dic[@"course_latest"];
            self.course_listArray = dic[@"course_list"];
            [self.collectionView reloadData];
        }
    }];
}

#pragma mark ---UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
       return self.course_latestArray.count;
    }else{
        return self.course_listArray.count;
    }
    
}





-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        LiveItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LiveItemCell" forIndexPath:indexPath];
        [cell setupData:self.course_latestArray[indexPath.row]];
        return cell;
    }else{
        LiveItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LiveItemCell" forIndexPath:indexPath];
        [cell setupData:self.course_listArray[indexPath.row]];
        return cell;
    }
    
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableview = nil;
    if(kind == UICollectionElementKindSectionHeader){

//        if ( indexPath.section == 0){
            
        LiveTitleView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LiveTitleView" forIndexPath:indexPath];
        
        reusableview = headView;
        if (indexPath.section == 0) {
            headView.titleLabel.text = @"最新直播";
        }else{
            headView.titleLabel.text = @"往期直播";
        }
//        }
    }
    if(kind == UICollectionElementKindSectionFooter){
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footView" forIndexPath:indexPath];
        
        footerView.backgroundColor = UIColorF5F7;
        
        reusableview = footerView;
        
    }
    
    return reusableview;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return self.course_latestArray.count > 0 ? CGSizeMake(Screen_Width, 40): CGSizeZero;
    }else{
        return self.course_listArray.count > 0 ? CGSizeMake(Screen_Width, 40): CGSizeZero;
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    if (section == 0) {
        return self.course_latestArray.count > 0 ? CGSizeMake(Screen_Width, 10): CGSizeZero;
    }else{
        return self.course_listArray.count > 0 ? CGSizeMake(Screen_Width, 10): CGSizeZero;
    }
   
}


//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
   
        return UIEdgeInsetsMake(10, 10, 10, 10);
    
   
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
     if (indexPath.section == 0){
        CourseDetailVC *vc = [CourseDetailVC new];
        vc.dic = self.course_latestArray[indexPath.row];
        [self.navigationController pushViewController:vc animated:true];
    }else if (indexPath.section == 1){
        CourseDetailVC *vc = [CourseDetailVC new];
        vc.dic = self.course_listArray[indexPath.row];
        [self.navigationController pushViewController:vc animated:true];
    }
       
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake((Screen_Width-10*3)/2, 340/2);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        
        _collectionView.backgroundColor = UIColor.whiteColor;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;

        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
        [_collectionView registerClass:[LiveTitleView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LiveTitleView"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footView"];
        [_collectionView registerClass:[LiveItemCell class] forCellWithReuseIdentifier:@"LiveItemCell"];

    }
    
    return _collectionView;
    
}


- (HomeManager *)manager{
    if (!_manager) {
        _manager = [HomeManager new];
    }
    
    return _manager;
}

@end
