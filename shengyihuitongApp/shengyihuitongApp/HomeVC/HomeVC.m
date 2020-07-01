//
//  HomeVC.m
//  shengyihuitongApp
//
//  Created by mac on 2020/6/23.
//  Copyright © 2020 mac. All rights reserved.
//

#import "HomeVC.h"
#import "HomeTitleView.h"
#import "HomeBannerCell.h"
#import "HomeNavCollectionCell.h"
#import "HomeFreeCourseCollectionCell.h"
#import "HomeViewModel.h"
#import "NavigateVC.h"
#import "CourseDetailVC.h"
#import "DelegatePopView.h"
#import "MainWebVC.h"
@interface HomeVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UITextViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) HomeViewModel *viewModel;
@property (nonatomic, strong) DelegatePopView *popView;
@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"盛益华通在线课堂";
    [self setUpUI];
    [self getHomeData];
    
    NSInteger isAgree =  [[[NSUserDefaults standardUserDefaults] objectForKey:@"isAgree"] integerValue];
    
    if (isAgree != 1) {
        DelegatePopView *popView = [DelegatePopView new];
        self.popView = popView;
        popView.textView.delegate = self;
        [popView show];
    }
    
   
}






- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationItem.leftBarButtonItem = nil;
}
- (void)setUpUI{
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    AdjustsScrollViewInsetNever(self, self.collectionView)
}

- (void)getHomeData{
    
    
    [self.viewModel refreshDataSource];
    
    WeakSelf(self)
    self.viewModel.refreshBlock = ^{
        [weakself.collectionView reloadData];
        [weakself.collectionView.mj_header endRefreshing];
    };
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 4;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return self.viewModel.freeArr.count;
            
            break;
            
        case 3:
             return self.viewModel.recommandArr.count;
            break;
        default:
            return 0;
            break;
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize zeroSize = CGSizeMake(Screen_Width, 0);
    CGSize headSize = CGSizeMake(Screen_Width, 45*AdapterScal);
    if (section == 4){
        return zeroSize;
    }else if (section == 3){
         return self.viewModel.recommandArr.count > 0 ? headSize : zeroSize;
    }else if (section == 2){
        return self.viewModel.freeArr.count > 0 ? headSize : zeroSize;
    }else{
         return CGSizeZero;
    }
   
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    return CGSizeZero;
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableview = nil;
    if(kind == UICollectionElementKindSectionHeader){

        if ( indexPath.section == 2){
            
            HomeTitleView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomeTitleView" forIndexPath:indexPath];
            
            headView.titleLabel.text = @"免费课堂";
            reusableview = headView;
        }else if (indexPath.section == 3){
            HomeTitleView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomeTitleView" forIndexPath:indexPath];
             headView.titleLabel.text = @"推荐课堂";
            reusableview = headView;
        }
    }
    if(kind == UICollectionElementKindSectionFooter){
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footView" forIndexPath:indexPath];
        
        footerView.backgroundColor = UIColorF5F7;
        
        reusableview = footerView;
        
    }
    
    return reusableview;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
        {
            return CGSizeMake(Screen_Width, 170);
        }
            break;
        case 1:
        {
            return CGSizeMake(Screen_Width, 180);
        }
            break;
        case 2:
        {
            return CGSizeMake((Screen_Width-10*3)/2, 190);
        }
            break;
        case 3:
        {
            return CGSizeMake((Screen_Width-10*3)/2, 190);
        }
            break;
        default:
        {
            return CGSizeMake(Screen_Width, 0);
        }
            break;
    }
    
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            HomeBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeBannerCell" forIndexPath:indexPath];
            cell.datas = self.viewModel.actityArr;
            return cell;
        }
            break;
        case 1:
        {
            HomeNavCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeNavCollectionCell" forIndexPath:indexPath];
            WeakSelf(self)
            cell.clickBlock = ^(NSString * _Nonnull name) {
                NavigateVC *vc = [NavigateVC new];
                if ([name isEqualToString:@"执业药师"]) {
                    vc.jobid = @"12,13";
                }else if ([name isEqualToString:@"执业医师"]){
                    vc.jobid = @"14,15,16,17";
                }else if ([name isEqualToString:@"中医师承"]){
                    vc.jobid = @"20,21,22";
                }else if ([name isEqualToString:@"健康管理"]){
                    vc.jobid = @"32";
                }else if ([name isEqualToString:@"乡村全科"]){
                    vc.jobid = @"18";
                }else if ([name isEqualToString:@"卫生职称"]){
                    vc.jobid = @"25,26,27,28,29,30,31";
                }else if ([name isEqualToString:@"执业护士"]){
                    vc.jobid = @"19";
                }else if ([name isEqualToString:@"全部分类"]){
                    self.tabBarController.selectedIndex = 2;
                    return ;
                }
                vc.navTitle = name;
                [weakself.navigationController pushViewController:vc animated:true];
            };
            return cell;
        }
            break;
            
        case 2:
        {
            HomeFreeCourseCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeFreeCourseCollectionCell" forIndexPath:indexPath];
            [cell setupData:self.viewModel.freeArr[indexPath.row]];
            return cell;
        }
            break;
        case 3:
        {
            HomeFreeCourseCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeFreeCourseCollectionCell" forIndexPath:indexPath];
            [cell setupData:self.viewModel.recommandArr[indexPath.row]];
            return cell;
        }
            break;
        default:
        {
            UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
            cell.backgroundColor = [UIColor blackColor];
            return cell;
        }
            
            break;
    }
    
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 2 || section == 3) {
        return UIEdgeInsetsMake(10, 10, 0, 10);
    }
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2 ) {
        CourseDetailVC *vc = [CourseDetailVC new];
        vc.dic = self.viewModel.freeArr[indexPath.row];
        [self.navigationController pushViewController:vc animated:true];
    }else if (indexPath.section == 3){
        CourseDetailVC *vc = [CourseDetailVC new];
        vc.dic = self.viewModel.recommandArr[indexPath.row];
        [self.navigationController pushViewController:vc animated:true];
    }
   
}

#pragma mark ---UITextViewDelegate---
- (BOOL)textView:(UITextView*)textView shouldInteractWithURL:(NSURL*)URL inRange:(NSRange)characterRange {
    
    NSLog(@"点击响应--------------- %@",URL);
    MainWebVC *vc = [MainWebVC new];
    vc.urlString = [NSString stringWithFormat:@"%@",URL];
    [self.navigationController pushViewController:vc animated:true];
    [self.popView hide];
    return YES;
    
}


- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(340/2*AdapterScal, 140/2*AdapterScal);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        
        _collectionView.backgroundColor = UIColor.whiteColor;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;

        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
        [_collectionView registerClass:[HomeTitleView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomeTitleView"];

        [_collectionView registerClass:[HomeBannerCell class] forCellWithReuseIdentifier:@"HomeBannerCell"];
        [_collectionView registerClass:[HomeNavCollectionCell class] forCellWithReuseIdentifier:@"HomeNavCollectionCell"];
        [_collectionView registerClass:[HomeFreeCourseCollectionCell class] forCellWithReuseIdentifier:@"HomeFreeCourseCollectionCell"];


        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getHomeData)];

        
        
//        WeakSelf(self);
        _collectionView.mj_header = header;
        
//        AdjustsScrollViewInsetNever(self, self.collectionView)
    }
    
    return _collectionView;
    
}

- (HomeViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [HomeViewModel new];
    }
    
    return _viewModel;
}



@end
