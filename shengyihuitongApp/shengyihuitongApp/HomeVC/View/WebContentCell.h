//
//  WebContentCell.h
//  shengyihuitongApp
//
//  Created by Mac on 2020/6/26.
//  Copyright © 2020 温州轩捷贸易有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface WebContentCell : UITableViewCell
@property(nonatomic,strong)WKWebView * wkwebView;
- (void)setupData:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
