//
//  MineVC.m
//  shengyihuitongApp
//
//  Created by mac on 2020/6/23.
//  Copyright © 2020 mac. All rights reserved.
//

#import "MineVC.h"
#import "MineInfoCell.h"
#import "LineItemTableCell.h"
#import "AccountManager.h"
@interface MineVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *listTableview;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) AccountManager *manager;
@property (nonatomic, strong) NSDictionary *userDic;
@end

@implementation MineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self getData];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getData) name:refreshUserInfo object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self getData];
}


- (void)setupUI{
    [self.view addSubview:self.listTableview];
    [self.listTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    AdjustsScrollViewInsetNever(self, self.listTableview)
}

- (void)getData{
   
    [self.manager getUesrInfowithCompletionHandler:^(NSError *error, MessageBody *result) {
        if (result.code == 1) {
            NSDictionary *dic = result.result;
            self.userDic = dic;
            [self.listTableview reloadData];
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return self.dataArr.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        static NSString *cellIde = @"MineInfoCell";
        MineInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIde];
        if (!cell) {
            cell = [[MineInfoCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellIde];
        }
        [cell setupdata:self.userDic];
        return cell;
    }else{
        static NSString *cellIde = @"LineItemTableCell";
        LineItemTableCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIde];
        if (!cell) {
            cell = [[LineItemTableCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellIde];
        }
        [cell setupData:self.dataArr[indexPath.row]];
        return cell;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 140+StatusBarHeight;
    }
    
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
            {
                [self.navigationController pushViewController:[NSClassFromString(@"MineCourseVC") new] animated:true];
            }
                break;
            case 1:
            {
                [self.navigationController pushViewController:[NSClassFromString(@"MineSquadVC") new] animated:true];
            }
                break;
            case 2:
            {
//                [self.navigationController pushViewController:[NSClassFromString(@"MineSquadVC") new] animated:true];
            }
                break;
            case 3:
            {
                [self.navigationController pushViewController:[NSClassFromString(@"AboutUsVC") new] animated:true];
            }
                break;
            default:
                break;
        }
    }else if (indexPath.section == 0){
        if (!accessToken) {
            [XJUtil callUserLogin:self];
        }else{
            [self getData];
        }
    }
}

- (UITableView *)listTableview{
    if (!_listTableview) {
        _listTableview = [[UITableView alloc] init];
        _listTableview.delegate=self;
        _listTableview.dataSource=self;
        _listTableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _listTableview.backgroundColor = UIColor.whiteColor;

        [_listTableview registerNib:[UINib nibWithNibName:@"MineInfoCell" bundle:nil] forCellReuseIdentifier:@"MineInfoCell"];
        [_listTableview registerNib:[UINib nibWithNibName:@"LineItemTableCell" bundle:nil] forCellReuseIdentifier:@"LineItemTableCell"];
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

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        
        _dataArr = [NSMutableArray array];
        NSArray *arr = [NSArray arrayWithObjects:
  @{@"name":@"我的课程",@"image":@"course"},
  @{@"name":@"我的班次",@"image":@"squad"},@{@"name":@"我的下载",@"image":@"downicon"},
  @{@"name":@"关于我们",@"image":@"account"},@{@"name":@"我的设置",@"image":@"setting"}, nil];
        //@{@"name":@"全车保修",@"image":@"item5"},@{@"name":@"一年保养",@"image":@"item6"},@{@"name":@"随心砍",@"image":@"item7"},
        [_dataArr addObjectsFromArray:arr];
    }
    return _dataArr;
}

- (AccountManager *)manager{
    if (!_manager) {
        _manager = [AccountManager new];
    }
    
    return _manager;
}

@end
