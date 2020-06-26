//
//  JobVC.m
//  shengyihuitongApp
//
//  Created by Mac on 2020/6/25.
//  Copyright © 2020 温州轩捷贸易有限公司. All rights reserved.
//

#import "JobVC.h"
#import "JobItemCell.h"
#import "HomeManager.h"
#import "LiveItemCell.h"
#import "LiveTitleView.h"
#import "HomeCourseDetailVC.h"
#import "CourseDetailVC.h"
@interface JobVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *squad_listArray;
@property (nonatomic, strong) NSArray *video_listArray;
@property (nonatomic, strong) NSArray *recomm_listArray;
@property (nonatomic, strong) HomeManager *manager;
@end

@implementation JobVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = UIColor.redColor;
    [self setupUI];

}

- (void)setupUI{
    [self.view addSubview:self.collectionView];
//    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.mas_equalTo(self.view);
//        make.bottom.mas_equalTo(-46);
//    }];
}

- (void)getData{
    NSDictionary *dic = @{@"job_id":self.jobId};
    [self.manager getJobDataWithparameters:dic withCompletionHandler:^(NSError *error, MessageBody *result) {
        if (result.code == 1) {
            NSDictionary *dic = result.result;
            self.squad_listArray = dic[@"squad_list"];
            self.video_listArray = dic[@"video_list"];
            self.recomm_listArray = dic[@"recomm_list"];
            [self.collectionView reloadData];
        }
    }];
}

#pragma mark ---UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
       return self.squad_listArray.count;
    }else if(section == 1){
        return self.video_listArray.count;
    }else{
        return self.recomm_listArray.count;
    }
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        JobItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JobItemCell" forIndexPath:indexPath];
        [cell setupData:self.squad_listArray[indexPath.row]];
        return cell;
    }else if(indexPath.section == 1){
        LiveItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LiveItemCell" forIndexPath:indexPath];
        [cell setupData:self.video_listArray[indexPath.row]];
        return cell;
    }else if(indexPath.section == 2){
        LiveItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LiveItemCell" forIndexPath:indexPath];
        [cell setupData:self.recomm_listArray[indexPath.row]];
        return cell;
    }
    
    return nil;
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
       return  CGSizeMake(Screen_Width,250);
    }else{
        return CGSizeMake((Screen_Width-10*3)/2, 340/2);
    }
    
    return CGSizeZero;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableview = nil;
    if(kind == UICollectionElementKindSectionHeader){

//        if ( indexPath.section == 0){
            
        LiveTitleView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LiveTitleView" forIndexPath:indexPath];
        
        reusableview = headView;
        if (indexPath.section == 0) {
            headView.titleLabel.text = @"最新直播";
        }else if(indexPath.section == 1){
            headView.titleLabel.text = @"视频课程";
        }else{
            headView.titleLabel.text = @"推荐课程";
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
        return CGSizeZero;
    }else if(section == 1){
        return self.video_listArray.count > 0 ? CGSizeMake(Screen_Width, 40): CGSizeZero;
    }else{
        return self.recomm_listArray.count > 0 ? CGSizeMake(Screen_Width, 40): CGSizeZero;
    }
    
    return CGSizeZero;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    if (section == 0) {
        return CGSizeZero;
    }else if (section == 1){
        return self.video_listArray.count > 0 ? CGSizeMake(Screen_Width, 10): CGSizeZero;
    }else if (section == 2){
        return self.recomm_listArray.count > 0 ? CGSizeMake(Screen_Width, 10): CGSizeZero;
    }
    return CGSizeZero;
}


//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
   if(section != 0){
        return UIEdgeInsetsMake(10, 10, 10, 10);
    }
    
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
   
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        HomeCourseDetailVC *vc = [HomeCourseDetailVC new];
        vc.dic = self.squad_listArray[indexPath.row];
        [self.navigationController pushViewController:vc animated:true];
    }else if (indexPath.section == 1){
        CourseDetailVC *vc = [CourseDetailVC new];
        vc.dic = self.video_listArray[indexPath.row];
        [self.navigationController pushViewController:vc animated:true];
    }else if (indexPath.section == 2){
        CourseDetailVC *vc = [CourseDetailVC new];
        vc.dic = self.recomm_listArray[indexPath.row];
        [self.navigationController pushViewController:vc animated:true];
    }
   
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake((Screen_Width-10*3)/2, 340/2);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, CGRectGetHeight(self.view.bounds) - 46 - StatusBarAndNavigationBarHeight) collectionViewLayout:flowLayout];
        
        _collectionView.backgroundColor = UIColor.whiteColor;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;

        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
        [_collectionView registerClass:[LiveTitleView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LiveTitleView"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footView"];
        [_collectionView registerClass:[LiveItemCell class] forCellWithReuseIdentifier:@"LiveItemCell"];
         [_collectionView registerClass:[JobItemCell class] forCellWithReuseIdentifier:@"JobItemCell"];
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
