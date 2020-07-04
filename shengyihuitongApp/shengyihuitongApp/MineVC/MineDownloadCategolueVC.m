//
//  MineDownloadCategolueVC.m
//  shengyihuitongApp
//
//  Created by Mac on 2020/7/2.
//  Copyright © 2020 mac. All rights reserved.
//

#import "MineDownloadCategolueVC.h"
#import "CatelogueTitleView.h"
#import "CatelogueCell.h"
@interface MineDownloadCategolueVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *listTableview;
@property (nonatomic, strong) NSArray<CourseDetailModel *> *resultArr;
@end

@implementation MineDownloadCategolueVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    [self getLocalDownLoadData];
}

- (void)setupUI{
    [self.view addSubview:self.listTableview];
    [self.listTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (void)getLocalDownLoadData{
    [CourseDetailModel bg_findAllAsync:mytableName complete:^(NSArray * _Nullable array) {
        self.resultArr = array;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.listTableview reloadData];
        });
        
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.resultArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    CourseDetailModel *model = self.resultArr[section];
//    Chapter_list *chapter  = model.chapter_list;
    return model.chapter_list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    static NSString *cellIde = @"CatelogueCell";
    CatelogueCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIde];
    if (!cell) {
        cell = [[CatelogueCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellIde];
    }
    CourseDetailModel *model = self.resultArr[indexPath.section];
    cell.chapteModel = model.chapter_list[indexPath.row];
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CourseDetailModel *model = self.resultArr[section];
    CatelogueTitleView *titleView = [CatelogueTitleView new];
    titleView.titleLabel.text = model.intro;
    return titleView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 55.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CourseDetailModel *model = self.resultArr[indexPath.section];
    Chapter_list *chapter  = model.chapter_list[indexPath.row];
   
    
}




- (UITableView *)listTableview{
    if (!_listTableview) {
        _listTableview = [[UITableView alloc] init];
        _listTableview.delegate=self;
        _listTableview.dataSource=self;
        _listTableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _listTableview.backgroundColor = UIColorEF;
//        [_listTableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CatelogueCell"];
        _listTableview.showsVerticalScrollIndicator = false;
        [_listTableview registerClass:[CatelogueCell class] forCellReuseIdentifier:@"CatelogueCell"];
        _listTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listTableview.estimatedRowHeight = 80;
        _listTableview.rowHeight = UITableViewAutomaticDimension;
    }
    
    return _listTableview;
}


@end
