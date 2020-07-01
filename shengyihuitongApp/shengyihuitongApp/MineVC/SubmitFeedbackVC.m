//
//  SubmitFeedbackVC.m
//  shengyihuitongApp
//
//  Created by 温州轩捷贸易有限公司 on 2020/6/30.
//  Copyright © 2020 温州轩捷贸易有限公司. All rights reserved.
//

#import "SubmitFeedbackVC.h"

@interface SubmitFeedbackVC ()
@property (weak, nonatomic) IBOutlet UITextView *textContent;
@end

@implementation SubmitFeedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"意见反馈";
    self.view.backgroundColor = UIColorEF;
    [self.textContent becomeFirstResponder];
    
}
- (IBAction)submit:(UIButton *)sender {
    [JMBManager showBriefAlert:@"提交成功"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:true];
    });
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
