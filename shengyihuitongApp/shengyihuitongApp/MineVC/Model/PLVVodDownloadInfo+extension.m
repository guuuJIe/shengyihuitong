//
//  PLVVodDownloadInfo+extension.m
//  shengyihuitongApp
//
//  Created by Mac on 2020/7/3.
//  Copyright © 2020 mac. All rights reserved.
//

#import "PLVVodDownloadInfo+extension.h"



@implementation PLVVodDownloadInfo (extension)

- (void)setUserPhone:(NSString *)userPhone{
    objc_setAssociatedObject(self, &strKey, userPhone, OBJC_ASSOCIATION_COPY);
}


- (NSString *)userPhone{
    return objc_getAssociatedObject(self, &strKey);  
}

@end
