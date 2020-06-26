//
//  MineCourseVC.m
//  shengyihuitongApp
//
//  Created by Mac on 2020/6/26.
//  Copyright © 2020 温州轩捷贸易有限公司. All rights reserved.
//

#import "MineCourseVC.h"
#import "MineCourseItemCell.h"
#import "MineManager.h"
@interface MineCourseVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *listTableview;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) MineManager *manager;
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
    [self.manager getUserCoursewithCompletionHandler:^(NSError *error, MessageBody *result) {
        if (result.code == 1) {
            NSDictionary *dic = result.result;
            self.dataArr = dic[@"course_list"];
            [self.listTableview reloadData];
        }
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
    return cell;
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
