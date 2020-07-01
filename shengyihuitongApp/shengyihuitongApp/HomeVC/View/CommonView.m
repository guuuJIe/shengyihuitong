//
//  CommonView.m
//  shengyihuitongApp
//
//  Created by 温州轩捷贸易有限公司 on 2020/6/28.
//  Copyright © 2020 温州轩捷贸易有限公司. All rights reserved.
//

#import "CommonView.h"

@implementation CommonView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorEF;
        [self setupLayout];
    }
    
    return self;
}

- (void)setupLayout{
   
    [self addSubview:self.actButton];
    
   
    
    [self.actButton mas_makeConstraints:^(MASConstraintMaker *make) {
          make.right.top.equalTo(self);
          make.height.equalTo(@50);
          make.width.mas_equalTo(Screen_Width);
      }];
}

- (void)click{
    if (self.actBlock) {
        self.actBlock();
    }
}


-(UIButton *)actButton
{
    if(!_actButton)
    {
        _actButton=[UIButton  new];
        [_actButton setTitle:@"立即学习" forState:UIControlStateNormal];
        _actButton.titleLabel.font = LabelFont14;
        [_actButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_actButton setBackgroundColor:UIColor276];
        [_actButton addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        [_actButton setBackgroundImage:[UIImage imageWithColor:APPColor] forState:UIControlStateDisabled];
        
    }
    return _actButton;
}

@end
