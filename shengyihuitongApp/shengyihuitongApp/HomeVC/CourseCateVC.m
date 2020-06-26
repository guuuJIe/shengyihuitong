//
//  CourseCateVC.m
//  shengyihuitongApp
//
//  Created by Mac on 2020/6/26.
//  Copyright © 2020 温州轩捷贸易有限公司. All rights reserved.
//

#import "CourseCateVC.h"
#import "CatelogueCell.h"
#import "CatelogueTitleView.h"
@interface CourseCateVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *listTableview;
@property (nonatomic, strong) NSArray *resultArr;
@end

@implementation CourseCateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.cyanColor;
    [self setupUI];
}


- (void)setupUI{
    [self.view addSubview:self.listTableview];
    [self.listTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}


- (void)setDataDic:(NSDictionary *)dataDic{
//    _dataDic = dataDic;
//    JLog(@"%@",_dataDic);
//    self.resultArr = dataDic[@"chapter_list"];
//    [self.listTableview reloadData];
}

- (void)setDetailModel:(CourseDetailModel *)detailModel{
    _detailModel = detailModel;
    [self.listTableview reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.detailModel.chapter_list.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    Chapter_list *chapter  = self.detailModel.chapter_list[section];

    return chapter.child_list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    static NSString *cellIde = @"CatelogueCell";
    CatelogueCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIde];
    if (!cell) {
        cell = [[CatelogueCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellIde];
    }
    Chapter_list *chapter  = self.detailModel.chapter_list[indexPath.section];
//    [cell setDetailModel:chapter.child_list[indexPath.row]];
    cell.detailModel = chapter.child_list[indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    Chapter_list *chapter  = self.detailModel.chapter_list[section];
    CatelogueTitleView *titleView = [CatelogueTitleView new];
    titleView.titleLabel.text = chapter.chapter_name;
    return titleView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 55.0f;
}


- (UITableView *)listTableview{
    if (!_listTableview) {
        _listTableview = [[UITableView alloc] init];
        _listTableview.delegate=self;
        _listTableview.dataSource=self;
        _listTableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _listTableview.backgroundColor = UIColorEF;
        [_listTableview registerClass:[CatelogueCell class] forCellReuseIdentifier:@"CatelogueCell"];
        _listTableview.showsVerticalScrollIndicator = false;
        [_listTableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _listTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listTableview.estimatedRowHeight = 80;
        _listTableview.rowHeight = UITableViewAutomaticDimension;
    }
    
    return _listTableview;
}

@end
