//
//  HomeViewModel.m
//  shengyihuitongApp
//
//  Created by mac on 2020/6/24.
//  Copyright © 2020 mac. All rights reserved.
//

#import "HomeViewModel.h"
#import "HomeManager.h"

@interface HomeViewModel()
@property (nonatomic, strong) HomeManager *manager;
@end

@implementation HomeViewModel



- (void)refreshDataSource{
    
    
    [self.manager getHomeDatawithCompletionHandler:^(NSError *error, MessageBody *result) {
        
        if (result.code == 1) {
            NSDictionary *dic = result.result;
            
            self.actityArr = dic[@"activity_list"];
            
            self.freeArr = dic[@"free_list"];
            
            self.recommandArr = dic[@"recomm_list"];
        }
        
        
        
        if (self.refreshBlock) {
            self.refreshBlock();
        }
    }];
    
}

- (HomeManager *)manager{
    if (!_manager) {
        _manager = [HomeManager new];
    }
    return _manager;
}
@end
