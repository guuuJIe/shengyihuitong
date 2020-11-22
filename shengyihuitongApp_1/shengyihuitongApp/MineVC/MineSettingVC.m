//
//  MineSettingVC.m
//  shengyihuitongApp
//
//  Created by mac on 2020/6/30.
//  Copyright © 2020 mac. All rights reserved.
//

#import "MineSettingVC.h"
#import <PLVVodSDK/PLVVodSDK.h>
#import "SubmitFeedbackVC.h"
@interface MineSettingVC ()
@property (weak, nonatomic) IBOutlet UIView *cleanCacheView;

@property (weak, nonatomic) IBOutlet UIView *feedBackView;
@end

@implementation MineSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的设置";
    [self.cleanCacheView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ViewAct:)]];
    [self.feedBackView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ViewAct:)]];
   
}
- (IBAction)switchAct:(UISwitch *)sender {
//    JLog(@"%hhd",sender.on);
    [PLVVodDownloadManager sharedManager].allowsCellularAccess = sender.on;
}

- (void)ViewAct:(UITapGestureRecognizer *)ges{
    switch (ges.view.tag) {
        case 300:
        {
            [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
                [JMBManager showBriefAlert:@"清除成功"];
            }];
        }
            break;
        case 301:
        {
            SubmitFeedbackVC *vc = [[SubmitFeedbackVC alloc] initWithNibName:@"SubmitFeedbackVC" bundle:nil];
            [self.navigationController pushViewController:vc animated:true];
        }
            break;
        default:
            break;
    }
}
- (IBAction)loginOut:(id)sender {
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"accessToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.navigationController popViewControllerAnimated:true];
}

@end
