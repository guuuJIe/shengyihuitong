//
//  MineSquadVC.m
//  shengyihuitongApp
//
//  Created by Mac on 2020/6/26.
//  Copyright © 2020 mac. All rights reserved.
//

#import "MineSquadVC.h"
#import "MineManager.h"
#import "MineSquadItemCell.h"
#import "HomeCourseDetailVC.h"
@interface MineSquadVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *listTableview;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) MineManager *manager;

@end

@implementation MineSquadVC

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
    [self.manager getUserSquadwithCompletionHandler:^(NSError *error, MessageBody *result) {
        if (result.code == 1) {
            NSDictionary *dic = result.result;
            self.dataArr = dic[@"squad_list"];
            [self.listTableview reloadData];
            [self.listTableview.mj_header endRefreshing];
        }
        [JMBManager hideAlert];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIde = @"MineSquadItemCell";
    MineSquadItemCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIde];
    if (!cell) {
        cell = [[MineSquadItemCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellIde];
    }
    [cell setupData:self.dataArr[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeCourseDetailVC *vc = [HomeCourseDetailVC new];
    vc.dic = self.dataArr[indexPath.row];
    [self.navigationController pushViewController:vc animated:true];
}


- (UITableView *)listTableview{
    if (!_listTableview) {
        _listTableview = [[UITableView alloc] init];
        _listTableview.delegate=self;
        _listTableview.dataSource=self;
        _listTableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _listTableview.backgroundColor = UIColor.whiteColor;

        [_listTableview registerClass:[MineSquadItemCell class] forCellReuseIdentifier:@"MineSquadItemCell"];
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
