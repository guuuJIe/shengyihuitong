//
//  CourseListVC.m
//  shengyihuitongApp
//
//  Created by Mac on 2020/6/25.
//  Copyright © 2020 mac. All rights reserved.
//

#import "CourseListVC.h"
#import "CourseItemCell.h"
#import "CourseManager.h"
#import "CourseDetailVC.h"
@interface CourseListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *listTableview;
@property (nonatomic, strong) NSArray *typeMuArray;
@property (nonatomic, strong) CourseManager *manager;
@end

@implementation CourseListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    [self getData];
}

- (void)setupUI{
    self.navigationItem.title = @"课程列表";
    [self.view addSubview:self.listTableview];
    [self.listTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (void)getData{
    NSDictionary *dic = @{@"job_id":self.dic[@"job_id"]};
    [self.manager getCourseDataWithparameters:dic withCompletionHandler:^(NSError *error, MessageBody *result) {
        if (result.code == 1) {
            NSDictionary *dic = result.result;
            self.typeMuArray = dic[@"recomm_list"];
            [self.listTableview reloadData];
        }
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.typeMuArray.count;
//    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIde = @"CourseItemCell";
    CourseItemCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIde];
    if (!cell) {
        cell = [[CourseItemCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellIde];
    }
   
    [cell setupData:self.typeMuArray[indexPath.row]];
   
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CourseDetailVC *vc = [CourseDetailVC new];
    vc.dic = self.typeMuArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:true];
}


- (UITableView *)listTableview{
    if (!_listTableview) {
        _listTableview = [[UITableView alloc] init];
        _listTableview.delegate=self;
        _listTableview.dataSource=self;
        _listTableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _listTableview.backgroundColor = UIColorEF;
        [_listTableview registerClass:[CourseItemCell class] forCellReuseIdentifier:@"CourseItemCell"];
        _listTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listTableview.estimatedRowHeight = 80;
        _listTableview.rowHeight = UITableViewAutomaticDimension;
    }
    
    return _listTableview;
}

- (CourseManager *)manager{
    if (!_manager) {
        _manager = [CourseManager new];
    }
    
    return _manager;
}
@end
