//
//  CommentVC.m
//  shengyihuitongApp
//
//  Created by Mac on 2020/6/26.
//  Copyright © 2020 温州轩捷贸易有限公司. All rights reserved.
//

#import "CommentVC.h"
#import "CourseTitleView.h"
#import "CommentCell.h"
#import "CommentVC.h"
#import "CourseManager.h"
#import "CommentItemCell.h"
#import "CommentView.h"
@interface CommentVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *listTableview;
@property (nonatomic, strong) CourseManager *manager;
@property (nonatomic, strong) NSArray *datasArray;
@property (nonatomic, strong) CommentView *commentView;
@end

@implementation CommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = UIColor.yellowColor;
    [self setUpUI];
    
    [self getData];
   
}

- (void)setUpUI{
    [self.view addSubview:self.listTableview];
    [self.listTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (void)setDetailModel:(CourseDetailModel *)detailModel{
//    if (detailModel) {

//    }
    _detailModel = detailModel;
    
}

- (void)getData{
    WeakSelf(self)
    [self.manager getCommentListDataWithparameters:@(self.detailModel.course_id) withCompletionHandler:^(NSError *error, MessageBody *result) {
        StrongSelf(self)
        if (result.code == 1) {
            NSDictionary *dic = result.result;
            self.datasArray = dic[@"comment_list"];
            [self.listTableview reloadData];
        }
    }];
}

- (void)publishCommentAct:(NSString *)content withScore:(NSInteger)score{
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:content forKey:@"content"];
    [dic setValue:@(score) forKey:@"score"];
    [dic setValue:@(self.detailModel.course_id) forKey:@"course_id"];
    WeakSelf(self)
    [self.manager publishCommentWithparameters:dic withCompletionHandler:^(NSError *error, MessageBody *result) {
        StrongSelf(self)
        if (result.code == 1) {
            [JMBManager showBriefAlert:@"发布成功"];
            [self getData];
        }
        
        [self.commentView hide];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 1) {
        return self.datasArray.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *cellIde = @"CommentCell";
        CommentCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIde];
        if (!cell) {
            cell = [[CommentCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellIde];
        }
        
        return cell;
    }else{
        static NSString *cellIde = @"CommentItemCell";
        CommentItemCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIde];
        if (!cell) {
            cell = [[CommentItemCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellIde];
        }
        [cell setupData:self.datasArray[indexPath.row]];
        return cell;
    }
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return UITableViewAutomaticDimension;
    }
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGFLOAT_MIN;
    }
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        CourseTitleView *title = [CourseTitleView new];
        title.titleLabel.text = @"全部评论";
        return title;
    }
    
    return UIView.new;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CommentView *view = [CommentView new];
        self.commentView = view;
        view.submitBlock = ^(NSInteger score, NSString * _Nonnull comment) {
            [self publishCommentAct:comment withScore:score];
        };
        [view show];
    }
}



- (UITableView *)listTableview{
    if (!_listTableview) {
        _listTableview = [[UITableView alloc] init];
        _listTableview.delegate=self;
        _listTableview.dataSource=self;
        _listTableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _listTableview.backgroundColor = UIColorEF;
        [_listTableview registerClass:[CommentCell class] forCellReuseIdentifier:@"CommentCell"];
        _listTableview.showsVerticalScrollIndicator = false;
        [_listTableview registerClass:[CommentItemCell class] forCellReuseIdentifier:@"CommentItemCell"];
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
