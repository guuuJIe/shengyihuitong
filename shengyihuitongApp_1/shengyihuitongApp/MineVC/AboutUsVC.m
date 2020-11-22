//
//  AboutUsVC.m
//  shengyihuitongApp
//
//  Created by mac on 2020/6/27.
//  Copyright © 2020 mac. All rights reserved.
//

#import "AboutUsVC.h"
#import "UILabel+FixScreenFont.h"
@interface AboutUsVC ()

@end

@implementation AboutUsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

- (void)setupUI{
    self.view.backgroundColor = UIColorEF;
    self.navigationItem.title = @"关于我们";
    
    UIImageView *icon = [UIImageView new];
    icon.image = [UIImage imageNamed:@"about_bg"];
    [self.view addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    
    UITextView *title = [UITextView new];
    title.textColor = UIColor999;
    title.backgroundColor = UIColor.clearColor;
    title.font = LabelFont16;
    [self.view addSubview:title];

    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.top.mas_equalTo(15);
        make.bottom.mas_equalTo(-15-BottomAreaHeight);
    }];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];

    paragraphStyle.lineSpacing = 10;// 字体的行间距

    NSDictionary *attributes = @{

    NSFontAttributeName:[UIFont systemFontOfSize:15],

    NSParagraphStyleAttributeName:paragraphStyle

    };

  
    title.editable = false;
    
    title.text = @"   南京盛益华通教育咨询有限公司是知名互联网教育品牌，多年来致力于执业药师、执业医师、中医师承、中医技法、心理咨询师、健康管理师培训，是互联网新模式开放后较早从事线上线下医药健康的考试培训机构。自2010年创立以来，秉承立足教育，服务社会的发展定位，聚焦并专注于中国医药健康培训领域的互联网应用和信息服务运营，与时俱进，借助O2O模式形成了“教学平台+行业资源+市场服务”的运营特色。目前业务覆盖范围已达12省40多地市，服务了数以万计的行业人员。南京盛益华通教育咨询有限公司总部位于南京，北京、上海、常州、无锡、淹城、南通、泰州、宿迁、沭阳、连云港、南昌、淮安、台州、扬州、杭州、徐州、漳州、合肥等地有十余家直营服务中心，湖南、重庆、海南、天津、辽宁、黑龙江等地均有合作公司。";
//    [UILabel changeLineSpaceForLabel:title WithSpace:7];
    
    title.attributedText = [[NSAttributedString alloc] initWithString:title.text attributes:attributes];

   
    
}

@end
