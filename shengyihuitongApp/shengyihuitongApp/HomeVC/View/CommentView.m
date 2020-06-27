//
//  CommentView.m
//  shengyihuitongApp
//
//  Created by 温州轩捷贸易有限公司 on 2020/6/27.
//  Copyright © 2020 温州轩捷贸易有限公司. All rights reserved.
//

#import "CommentView.h"
#import "JZLStarView.h"

@interface CommentView()
@property (nonatomic, strong) JZLStarView *starView;
@property (nonatomic, strong) UITextView *textView;
@end

@implementation CommentView

- (instancetype)init{
    self = [super init];
    if (self) {
        self.type = MMPopupTypeCustom;
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(Screen_Width, Screen_Height));
        }];
        
        
        UIView *bgView = [UIView new];
        [self addSubview:bgView];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.layer.cornerRadius = 10;
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(20);
            make.right.mas_equalTo(-20);
            make.height.mas_equalTo(371*AdapterScal);
            make.center.mas_equalTo(self);
        }];
        
        UILabel *title = [UILabel new];
        title.text = @"请给课程评分";
        title.textColor = UIColor333;
        title.font = LabelFont14;
        [bgView addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.centerX.mas_equalTo(bgView);
        }];
        
        [bgView addSubview:self.starView];
        
        
        self.textView = [UITextView new];
        self.textView.backgroundColor = UIColorEF;
        [bgView addSubview:self.textView];
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(30);
            make.right.mas_equalTo(-30);
            make.bottom.mas_equalTo(-55);
            make.top.mas_equalTo(self.starView.mas_bottom).offset(12);
        }];
        
        
        UIButton *button = [UIButton new];
        [button setTitle:@"取消" forState:0];
        [button setTitleColor:UIColor999 forState:0];
        [button.titleLabel setFont:LabelFont14];
        button.tag = 100;
        [bgView addSubview:button];
        [button addTarget:self action:@selector(clickAct:) forControlEvents:UIControlEventTouchUpInside];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.width.mas_equalTo((Screen_Width - 40)/2);
            make.bottom.mas_equalTo(bgView).offset(-4);
            make.height.mas_equalTo(44);
        }];
        
        
        UIButton *button2 = [UIButton new];
        [button2 setTitle:@"确定" forState:0];
        [button2 setTitleColor:APPColor forState:0];
        [button2.titleLabel setFont:LabelFont14];
        [bgView addSubview:button2];
        
        button2.tag = 101;
        [button2 addTarget:self action:@selector(clickAct:) forControlEvents:UIControlEventTouchUpInside];
        [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.width.mas_equalTo((Screen_Width - 40)/2);
            make.bottom.mas_equalTo(bgView).offset(-4);
            make.height.mas_equalTo(44);
        }];
        
    }
    
    return self;
}

- (void)clickAct:(UIButton *)sender{
    if (sender.tag == 100) {
        [self hide];
    }else if (sender.tag == 101){
//        if (self.starView.currentScore == 0) {
//
//            [JMBManager showBriefAlert:@"请"];
//            return;
//        }
        JLog(@"%f",self.starView.currentScore);
        if (self.textView.text.length == 0) {
            
            [JMBManager showBriefAlert:@"请输入评论"];
            return;
        }
        
        if (self.submitBlock) {
            self.submitBlock(self.starView.currentScore, self.textView.text);
        }
        
    }
}

- (JZLStarView *)starView{
    if (!_starView) {
        _starView = [[JZLStarView alloc] initWithFrame:CGRectMake(Screen_Width/2 - 50 - 20, 30, 100, 40) starCount:5 starStyle:WholeStar isAllowScroe:true];
        _starView.currentScore = 5;
    }
    
    return _starView;
}
@end
