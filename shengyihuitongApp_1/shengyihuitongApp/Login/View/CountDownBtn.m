//
//  CountDownBtn.m
//  shengyihuitongApp
//
//  Created by mac on 2020/6/27.
//  Copyright © 2020 mac. All rights reserved.
//

#import "CountDownBtn.h"

@interface CountDownBtn()
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,assign)NSInteger count;
@end

@implementation CountDownBtn

- (instancetype)init{
    self = [super init];
    if (self) {
        self.count=60;
        self.backgroundColor = APPColor;
        [self setTitle:@"获取验证码" forState:0];
        [self setBackgroundImage:[XJUtil createImageWithColor:APPColor] forState:0];
        [self setBackgroundImage:[XJUtil createImageWithColor:UIColor00FF] forState:UIControlStateDisabled];
        [self setTitleColor:[UIColor whiteColor] forState:0];
        [self setTitleColor:UIColorB2 forState:UIControlStateDisabled];
//        [self addTarget:self action:@selector(startRun) forControlEvents:UIControlEventTouchUpInside];
        self.layer.cornerRadius = 4;
        [self.titleLabel setFont:LabelFont14];
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        self.layer.masksToBounds = true;
        self.enabled = NO;
    }
    return self;
}

-(void)startRun{
    self.enabled = NO;
    self.timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeRun:) userInfo:nil repeats:YES];
//    [self.timer fire];
//    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}

-(void)timeRun:(NSTimer *)timer
{
    self.count--;
    
    [self setTitle:[NSString stringWithFormat:@"重新获取(%ld)",(long)self.count] forState:UIControlStateNormal];
    if (self.count==0) {
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.timer invalidate];
        self.timer=nil;
        self.count=60;
        //        [self setUserInteractionEnabled:YES];
        self.enabled = YES;
        
    }
    
}

@end
