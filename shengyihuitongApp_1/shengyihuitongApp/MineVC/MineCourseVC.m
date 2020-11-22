//
//  MineCourseVC.m
//  shengyihuitongApp
//
//  Created by Mac on 2020/6/26.
//  Copyright © 2020 mac. All rights reserved.
//

#import "MineCourseVC.h"
#import "MineCourseItemCell.h"
#import "MineManager.h"
#import "CourseDetailVC.h"
#import "MineCourseDownLoadCategolueVC.h"
#import "UIImage+Gradient.h"
@interface MineCourseVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *listTableview;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) MineManager *manager;
@property (nonatomic, strong) NSMutableArray *sizeArray;
@end

@implementation MineCourseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self getData];
}

- (void)setupUI{
    self.navigationItem.title = @"我的课程";
    [self.view addSubview:self.listTableview];
    [self.listTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (void)getData{
    [JMBManager showLoading];
    self.sizeArray = [NSMutableArray arrayWithObject:@{}];

    [self.manager getUserCoursewithCompletionHandler:^(NSError *error, MessageBody *result) {
        if (result.code == 1) {
            NSDictionary *dic = result.result;
            self.dataArr = dic[@"course_list"];
            
//            for (NSDictionary *dic in self.dataArr) {
//                CGSize size = [UIImage getImageSizeWithURL:[NSString stringWithFormat:@"%@",dic[@"course_img"]]];
//                NSMutableDictionary *temp = [NSMutableDictionary dictionary];
//                [temp setValue:@(size.width) forKey:@"width"];
//                [temp setValue:@(size.height) forKey:@"height"];
//                [self.sizeArray addObject:temp];
//            }
            
            
            [self.listTableview reloadData];
        }
        [self.listTableview.mj_header endRefreshing];
        [JMBManager hideAlert];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIde = @"MineCourseItemCell";
    MineCourseItemCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIde];
    if (!cell) {
        cell = [[MineCourseItemCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellIde];
    }
    [cell setupData:self.dataArr[indexPath.row]];
    [self itemDownload:cell AtIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CourseDetailVC *vc = [CourseDetailVC new];
    vc.dic = self.dataArr[indexPath.row];
    [self.navigationController pushViewController:vc animated:true];
}

- (void)itemDownload:(MineCourseItemCell *)cell AtIndexPath:(NSIndexPath *)indexPath{
    WeakSelf(self)
    cell.itemDownLoadBlock = ^{
        MineCourseDownLoadCategolueVC *vc = [MineCourseDownLoadCategolueVC new];
        vc.dic = weakself.dataArr[indexPath.row];
        [weakself.navigationController pushViewController:vc animated:true];
    };
}


- (UITableView *)listTableview{
    if (!_listTableview) {
        _listTableview = [[UITableView alloc] init];
        _listTableview.delegate=self;
        _listTableview.dataSource=self;
        _listTableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _listTableview.backgroundColor = UIColor.whiteColor;

        [_listTableview registerClass:[MineCourseItemCell class] forCellReuseIdentifier:@"MineCourseItemCell"];
        _listTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listTableview.estimatedRowHeight = 44;
        _listTableview.rowHeight = UITableViewAutomaticDimension;
        WeakSelf(self)
        _listTableview.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
            [weakself getData];
        }];
    }
    
    return _listTableview;
}

- (MineManager *)manager{
    if (!_manager) {
        _manager = [MineManager new];
    }
    
    return _manager;
}
@end
