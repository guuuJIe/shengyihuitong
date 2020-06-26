//
//  QuestionVC.m
//  shengyihuitongApp
//
//  Created by mac on 2020/6/23.
//  Copyright © 2020 mac. All rights reserved.
//

#import "QuestionVC.h"
#import "CourseManager.h"
#import "CateTableCell.h"
#import "ItemCollectionCell.h"
#import "MainWebVC.h"
#import "LoginVC.h"
@interface QuestionVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) CourseManager *manager;
@property (nonatomic, strong) UITableView *listTableview;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *typeMuArray;
@property (nonatomic, strong) NSIndexPath *selectIndexPath;

@end

@implementation QuestionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    
    [self getData];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationItem.leftBarButtonItem = nil;
}

- (void)setupUI{
    self.navigationItem.title = @"题库";
    
    [self.view addSubview:self.listTableview];
    [self.listTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(self.view);
        make.width.mas_equalTo(Screen_Width/4 + 40);
    }];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.listTableview.mas_right);
        make.right.mas_equalTo(0);
        make.top.bottom.mas_equalTo(self.view);
    }];
}

- (void)getData{
    [JMBManager showLoading];
    [self.manager getCategoryDatawithCompletionHandler:^(NSError *error, MessageBody *result) {
        if (result.code == 1) {
            self.typeMuArray = (NSArray *)result.result;
            [self.listTableview reloadData];
            [self.collectionView reloadData];
        }
        [JMBManager hideAlert];
    }];
}


#pragma mark --- UITableViewDelegate-----

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.typeMuArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIde = @"CateTableCell";
    CateTableCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIde];
    if (!cell) {
        cell = [[CateTableCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellIde];
    }
    CateModel *model = self.typeMuArray[indexPath.row];
    if (_selectIndexPath.row == indexPath.row) {
        model.isSelected = true;
    }else{
         model.isSelected = false;
    }
    cell.cateModel = model;
   
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CateModel *model = self.typeMuArray[indexPath.row];
//    model.isSelected = !model.isSelected;
    _selectIndexPath = indexPath;
    [self.listTableview reloadData];
    [self.collectionView reloadData];
}


#pragma mark --- UICollectionViewDelegate-----
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    CateModel *model = self.typeMuArray[_selectIndexPath.row];
    
    return model.classInfo.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   ItemCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ItemCollectionCell" forIndexPath:indexPath];
    CateModel *model = self.typeMuArray[_selectIndexPath.row];
    cell.infoModel = model.classInfo[indexPath.row];
    return cell;
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 0, 10);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CateModel *model = self.typeMuArray[_selectIndexPath.row];
    ClassInfo *classModel = model.classInfo[indexPath.row];
    [self.manager jumpToQustionVCWithparameters:[NSString stringWithFormat:@"%ld",(long)classModel.AppID] withCompletionHandler:^(NSError *error, MessageBody *result) {
        if (result.code == 1) {
            MainWebVC *vc = [MainWebVC new];
            vc.urlString = result.result;
            [self.navigationController pushViewController:vc animated:true];
        }else{
//            LoginVC *vc = [LoginVC new];
//            [self presentViewController:vc animated:true completion:nil];
            [XJUtil callUserLogin:self];
        }
    }];
}

- (CourseManager *)manager{
    if (!_manager) {
        _manager = [CourseManager new];
    }
    
    return _manager;
}


- (UITableView *)listTableview{
    if (!_listTableview) {
        _listTableview = [[UITableView alloc] init];
        _listTableview.delegate=self;
        _listTableview.dataSource=self;
        _listTableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _listTableview.backgroundColor = UIColorEF;
        [_listTableview registerClass:[CateTableCell class] forCellReuseIdentifier:@"CateTableCell"];
        _listTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return _listTableview;
}


- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(Screen_Width - Screen_Width/4 - 40 -20, 110/2*AdapterScal);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        
        _collectionView.backgroundColor = UIColor.whiteColor;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[ItemCollectionCell class] forCellWithReuseIdentifier:@"ItemCollectionCell"];

       
    }
    
    return _collectionView;
    
}
@end
