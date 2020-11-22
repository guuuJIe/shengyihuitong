//
//  MineDownloadCateVC.m
//  shengyihuitongApp
//
//  Created by Mac on 2020/7/4.
//  Copyright © 2020 mac. All rights reserved.
//

#import "MineDownloadingCateVC.h"
#import "CateCell.h"
#import "DownloadModel.h"
#import "MineDownloadCateDetailCourseVC.h"
#import "MineDownloadedCateCompleteVC.h"
@interface MineDownloadingCateVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *listTableview;
@property (nonatomic, strong) NSArray<DownloadModel *> *dataArray;
@property (nonatomic, strong) DownloadModel *recordModel;
@end

@implementation MineDownloadingCateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
//    [self getData];
    
   
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getData];
}

- (void)getData{
    NSString *where = [NSString stringWithFormat:@"where %@=%@ and %@>%@",bg_sqlKey(@"userPhone"),bg_sqlValue(userMobile),bg_sqlKey(@"downloading_num"),bg_sqlValue(@0)];
     __block NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
    [DownloadModel bg_findAsync:mytableName where:where complete:^(NSArray * _Nullable array) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [array enumerateObjectsUsingBlock:^(DownloadModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [tempDic setValue:obj forKey:[NSString stringWithFormat:@"%ld",(long)obj.course_id]];
            }];
            self.dataArray = [tempDic.allValues mutableCopy];
            [self.listTableview reloadData];
        });
       
        JLog(@"%@",array);
    }];
}

- (void)setupUI{
    
    [self.view addSubview:self.listTableview];
    [self.listTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(-50-StatusBarAndNavigationBarHeight);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    static NSString *cellIde = @"CateCell";
    CateCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIde];
    if (!cell) {
        cell = [[CateCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellIde];
    }
    cell.loadModel = self.dataArray[indexPath.row];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MineDownloadCateDetailCourseVC *vc = [MineDownloadCateDetailCourseVC new];
    vc.lastDownModel = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:true];
}

- (UITableView *)listTableview{
    if (!_listTableview) {
        _listTableview = [[UITableView alloc] init];
        _listTableview.delegate=self;
        _listTableview.dataSource=self;
        _listTableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _listTableview.backgroundColor = UIColorEF;
        _listTableview.showsVerticalScrollIndicator = false;
        [_listTableview registerClass:[CateCell class] forCellReuseIdentifier:@"CateCell"];
        _listTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listTableview.estimatedRowHeight = 80;
        _listTableview.rowHeight = UITableViewAutomaticDimension;
    }
    
    return _listTableview;
}


@end
