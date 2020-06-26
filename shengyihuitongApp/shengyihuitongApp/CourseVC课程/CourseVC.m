//
//  CourseVC.m
//  shengyihuitongApp
//
//  Created by mac on 2020/6/23.
//  Copyright © 2020 mac. All rights reserved.
//

#import "CourseVC.h"
#import "ItemCollectionCell.h"
#import "CateManager.h"
#import "CourseListVC.h"
@interface CourseVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) CateManager *manager;
@property (nonatomic, strong) NSArray *datas;
@end

@implementation CourseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    
    [self getdata];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationItem.leftBarButtonItem = nil;
}

- (void)setupUI{
    self.navigationItem.title = @"课程";
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (void)getdata{
    [JMBManager showLoading];
    [self.manager getCategoryDatawithCompletionHandler:^(NSError *error, MessageBody *result) {
        if (result.code == 1) {
            NSDictionary *dic = result.result;
            self.datas = (NSArray *)dic[@"job"];
            [self.collectionView reloadData];
        }
        [JMBManager hideAlert];
    }];
}



#pragma mark --- UICollectionViewDelegate-----
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datas.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   ItemCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ItemCollectionCell" forIndexPath:indexPath];
    [cell setupData:self.datas[indexPath.row]];
    return cell;
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 0, 10);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CourseListVC *vc = [CourseListVC new];
    vc.dic = self.datas[indexPath.row];
    [self.navigationController pushViewController:vc animated:true];
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake((Screen_Width - 30)/2, 120/2*AdapterScal);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        
        _collectionView.backgroundColor = UIColor.whiteColor;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;

        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
        [_collectionView registerClass:[ItemCollectionCell class] forCellWithReuseIdentifier:@"ItemCollectionCell"];


//        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getHomeData)];

        
        
//        WeakSelf(self);
//        _collectionView.mj_header = header;
        
//        AdjustsScrollViewInsetNever(self, self.collectionView)
    }
    
    return _collectionView;
    
}


- (CateManager *)manager{
    if (!_manager) {
        _manager = [CateManager new];
    }
    
    return _manager;
}

@end
