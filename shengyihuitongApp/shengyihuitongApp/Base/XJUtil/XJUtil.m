//
//  XJUtil.m
//  MallApp
//
//  Created by mac on 2020/1/7.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "XJUtil.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#import "LoginVC.h"

@implementation XJUtil

+ (NSString * _Nonnull)achieveImageNameWithCurrentTime
{
    //获取当前时间
    NSDate* today = [NSDate date];
    //转换时间格式
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyyMMddHHmmss"];
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    NSString *s1 = [df stringFromDate:today];
    NSString *s2 = [NSString stringWithFormat:@"%@.jpg",s1];
    return s2;
}

+ (id _Nonnull)insertStringWithNotNullObject:(id _Nonnull)obj
                              andDefailtInfo:(nonnull id)defailInfo
{
    if (!obj || [obj isEqual:[NSNull null]])
    {
        return defailInfo;
    }
    if ([obj isKindOfClass:[NSString class]])
    {
        if ([obj isEqualToString:@""])
        {
            return defailInfo;
        }
    }
    return obj;
}

+(NSMutableArray *)removeNavViewController:(NSArray *)array withArrayClassName:(NSArray *)classNames{
    NSMutableArray *marr = [[NSMutableArray alloc]initWithArray:array];
    for(NSString *className in classNames){
        
        NSMutableArray *larr = [NSMutableArray new];
        for(int i = 0 ; i<marr.count; i ++){
            if(i != marr.count-1){
                UIViewController *vc = marr[i];
                if ([vc isMemberOfClass:[NSClassFromString(className) class]]) {
                    [larr addObject:vc];
                }
            }
        }
        
        [marr removeObjectsInArray:larr];
    }
    
    
    return marr;
}


+(void)callTelNoCommAlert:(NSString *)phone{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]]];
}



+(NSString *)filterImage:(NSString *)html

{
    
//    NSMutableArray *resultArray = [NSMutableArray array];
    ///src=([\'\"]?([^\'\"]*)[\'\"]?)/ig   <img\\s*([^>]*)\\s*src=\\\"(.*?)\\\"\\s*([^>]*)>
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<img\\s*([^>]*)\\s*src=\\\"(.*?)\\\"\\s*([^>]*)>" options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSArray *result = [regex matchesInString:html options:NSMatchingReportCompletion range:NSMakeRange(0, html.length)];
    
    

    
    NSString *resultStrString  = html;
    for (NSTextCheckingResult *item in result) {
//
//        NSString *imgHtml = [html substringWithRange:[item rangeAtIndex:0]];
//
//
//
//        NSArray *tmpArray = nil;
//
//        if ([imgHtml rangeOfString:@"src=\""].location != NSNotFound) {
//
//            tmpArray = [imgHtml componentsSeparatedByString:@"src=\""];
//
//        } else if ([imgHtml rangeOfString:@"src="].location != NSNotFound) {
//
//            tmpArray = [imgHtml componentsSeparatedByString:@"src="];
//
//        }
//
//
//
//        if (tmpArray.count >= 2) {
//
//            NSString *src = tmpArray[1];
//
//
//
//            NSUInteger loc = [src rangeOfString:@"\""].location;
//
//            if (loc != NSNotFound) {
//
//                src = [src substringToIndex:loc];
//
//                [resultArray addObject:src];
//
//            }
//
//        }
       
        NSString *imgHtml = [html substringWithRange:[item rangeAtIndex:2]];
        NSLog(@"imgHtml---%@",imgHtml);
        NSString *imgHtml2 = [html substringWithRange:[item rangeAtIndex:0]];
        NSLog(@"imgHtml2---%@",imgHtml2);
        NSString *imgHtml3 = [html substringWithRange:[item rangeAtIndex:0]];
        
        NSString *replaceStr = @"";
        if (![imgHtml hasPrefix:@"http"]) {
            
            #ifdef DEBUG
                   replaceStr = [NSString stringWithFormat:@"http://192.168.1.3:8015%@",imgHtml];
            #else
                   replaceStr = [NSString stringWithFormat:@"%@%@",@"https://resources.ocsawz.com",imgHtml];
            #endif

            imgHtml2 = [imgHtml2 stringByReplacingOccurrencesOfString:imgHtml withString:replaceStr];
            NSLog(@"imgHtml3---%@",imgHtml2);
            resultStrString = [resultStrString stringByReplacingOccurrencesOfString:imgHtml3 withString:imgHtml2];
        }
    }
    
    
    
    return resultStrString;

}

+(NSString *)filterHtmlGoodsImageArr:(NSString *)html

{
    
//    NSMutableArray *resultArray = [NSMutableArray array];
  
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<img\\s*([^>]*)\\s*src=\\\"(.*?)\\\"\\s*([^>]*)>" options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSArray *result = [regex matchesInString:html options:NSMatchingReportCompletion range:NSMakeRange(0, html.length)];
    
    

    
    NSMutableString *resultStrString  =  [NSMutableString string];
    for (NSTextCheckingResult *item in result) {
//
//        NSString *imgHtml = [html substringWithRange:[item rangeAtIndex:2]];
//        NSString *imgHtml2 = [html substringWithRange:[item rangeAtIndex:0]];
//        NSLog(@"imgHtml----%@ \n\n %@",imgHtml,imgHtml2);

//
        NSString *imgHtml = [html substringWithRange:[item rangeAtIndex:2]];
//        NSLog(@"imgHtml---%@",imgHtml);
        NSString *imgHtml2 = [html substringWithRange:[item rangeAtIndex:0]];
//        NSLog(@"imgHtml2---%@",imgHtml2);
//        NSString *imgHtml3 = [html substringWithRange:[item rangeAtIndex:0]];

        NSString *replaceStr = @"";
        if (![imgHtml hasPrefix:@"http"]) {
#ifdef DEBUG
            replaceStr = [NSString stringWithFormat:@"http://192.168.1.3:8015%@",imgHtml];
#else
            replaceStr = [NSString stringWithFormat:@"%@%@",@"https://resources.ocsawz.com",imgHtml];
#endif
            imgHtml2 = [imgHtml2 stringByReplacingOccurrencesOfString:imgHtml withString:replaceStr];
            
//            resultStrString = imgHtml2;

            
        }
        
        [resultStrString appendString:imgHtml2];
    }
    
    
    
    return resultStrString;

}

+(void)popToVC:(NSString *)VC inViewControllers:(NSArray<__kindof UIViewController *> *)ViewController InCurNav:(UINavigationController *)rootVC{
    NSLog(@"%@",VC);
    for (UIViewController *temp in ViewController) {
         NSLog(@"%@",temp);
        if ([temp isKindOfClass:NSClassFromString(VC)]) {
//            BaseNavigationController *vc = [[BaseNavigationController alloc] initWithRootViewController:temp];
            [rootVC popToViewController:temp animated:YES];
        }
    }
}

//返回值格式:1555642454
+ (NSInteger)timeSwitchTimestamp:(NSString *)formatTime{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    
    NSLog(@"将某个时间转化成 时间戳timeSp:%ld",(long)timeSp); //时间戳的值
    
    return timeSp;
    
}

+(NSString *)getNowTimeStamp {

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;

    [formatter setDateStyle:NSDateFormatterMediumStyle];

    [formatter setTimeStyle:NSDateFormatterShortStyle];

    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // 设置想要的格式，hh与HH的区别:分别表示12小时制,24小时制

    //设置时区,这一点对时间的处理很重要

    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];

    [formatter setTimeZone:timeZone];

    NSDate *dateNow = [NSDate date];

    NSString *timeStamp = [NSString stringWithFormat:@"%ld", (long)[dateNow timeIntervalSince1970]];

    return timeStamp;

}

+ (NSString * _Nonnull)getNowTime
{
    //获取当前时间
    NSDate* today = [NSDate date];
    //转换时间格式
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    NSString *s1 = [df stringFromDate:today];
    return s1;
}

+ (NSMutableArray *)dealData:(NSArray *)array withRefreshType:(RefreshType)type withListView:(UITableView *)listTable AndCurDataArray:(NSMutableArray *)dataArr withNum:(NSInteger)num{
    if (type == RefreshTypeDown) {
        if (array.count <20) {
            [listTable.mj_footer endRefreshingWithNoMoreData];
        }
        [listTable.mj_header endRefreshing];
        [listTable.mj_footer endRefreshing];
        dataArr = [NSMutableArray arrayWithArray:array];
    }else if (type == RefreshTypeUP){
        if (array.count == 0) {
            num --;
            [listTable.mj_footer endRefreshingWithNoMoreData];
        }else{
            for (int i = 0; i<array.count; i++) {
                NSDictionary *dic = array[i];
                [dataArr addObject:dic];
            }
//            [dataArr addObjectsFromArray:array];
            [listTable.mj_footer endRefreshing];
        }
    }else if (type == RefreshTypeNormal){
        dataArr = [NSMutableArray arrayWithArray:array];
    }
    
    return dataArr;
}

+ (BOOL)isValidPassword:(NSString *)pwd {
    
    //以字母开头，只能包含“字母”，“数字”，“下划线”，长度6~18
       NSString *regex2 = @"^([a-zA-Z]|[a-zA-Z0-9_]|[0-9]){6,18}$";
//    (?![0-9]+$) 预测该位置后面不全是数字
//    (?![a-zA-Z]+$) 预测该位置后面不全是字母
    // 只能包含“字母”，“数字”，长度8~16
    NSString *regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$";
    return [self isValidateByRegex:regex withPwd:pwd];
}

+ (BOOL)isValidateByRegex:(NSString *)regex withPwd:(NSString *)pwd{
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pre evaluateWithObject:pwd];
}

+ (void)resetDefaults {
    
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    
    NSDictionary* dict = [defs dictionaryRepresentation];
    
    for(id key in dict) {
        
        [defs removeObjectForKey:key];
        
    }
    
    [defs synchronize];
    
}


//获得设备型号
+ (NSString *)getCurrentDeviceModel
{
    int mib[2];
    size_t len;
    char *machine;
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    NSString *deviceString = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);

    // iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"]) { return @"iPhone 1G";}
    if ([deviceString isEqualToString:@"iPhone1,2"]) { return @"iPhone 3G";}
    if ([deviceString isEqualToString:@"iPhone2,1"]) { return @"iPhone 3GS";}
    if ([deviceString isEqualToString:@"iPhone3,1"]) { return @"iPhone 4";}
    if ([deviceString isEqualToString:@"iPhone3,2"]) { return @"Verizon iPhone 4";}
    if ([deviceString isEqualToString:@"iPhone4,1"]) { return @"iPhone 4S";}
    if ([deviceString isEqualToString:@"iPhone5,1"]) { return @"iPhone 5";}
    if ([deviceString isEqualToString:@"iPhone5,2"]) { return @"iPhone 5";}
    if ([deviceString isEqualToString:@"iPhone5,3"]) { return @"iPhone 5C";}
    if ([deviceString isEqualToString:@"iPhone5,4"]) { return @"iPhone 5C";}
    if ([deviceString isEqualToString:@"iPhone6,1"]) { return @"iPhone 5S";}
    if ([deviceString isEqualToString:@"iPhone6,2"]) { return @"iPhone 5S";}
    if ([deviceString isEqualToString:@"iPhone7,1"]) { return @"iPhone 6 Plus";}
    if ([deviceString isEqualToString:@"iPhone7,2"]) { return @"iPhone 6";}
    if ([deviceString isEqualToString:@"iPhone8,1"]) { return @"iPhone 6s";}
    if ([deviceString isEqualToString:@"iPhone8,2"]) { return @"iPhone 6s Plus";}
    if ([deviceString isEqualToString:@"iPhone8,4"]) { return @"iPhone SE";}
    if ([deviceString isEqualToString:@"iPhone9,1"]) { return @"iPhone 7";}
    if ([deviceString isEqualToString:@"iPhone9,3"]) { return @"iPhone 7";}
    if ([deviceString isEqualToString:@"iPhone9,2"]) { return @"iPhone 7 Plus";}
    if ([deviceString isEqualToString:@"iPhone9,4"]) { return @"iPhone 7 Plus";}
    if ([deviceString isEqualToString:@"iPhone10,1"]) { return @"iPhone 8";}
    if ([deviceString isEqualToString:@"iPhone10,4"]) { return @"iPhone 8";}
    if ([deviceString isEqualToString:@"iPhone10,2"]) { return @"iPhone 8 Plus";}
    if ([deviceString isEqualToString:@"iPhone10,5"]) { return @"iPhone 8 Plus";}
    if ([deviceString isEqualToString:@"iPhone10,3"]) { return @"iPhone X";}
    if ([deviceString isEqualToString:@"iPhone10,6"]) { return @"iPhone X";}
    
    // iPod
    if ([deviceString isEqualToString:@"iPod1,1"])   { return @"iPod Touch";}
    if ([deviceString isEqualToString:@"iPod2,1"])   { return @"iPod Touch 2";}
    if ([deviceString isEqualToString:@"iPod3,1"])   { return @"iPod Touch 3";}
    if ([deviceString isEqualToString:@"iPod4,1"])   { return @"iPod Touch 4";}
    if ([deviceString isEqualToString:@"iPod5,1"])   { return @"iPod Touch 5";}
    if ([deviceString isEqualToString:@"iPod7,1"])   { return @"iPod Touch 6";}
    return deviceString;
}

+(UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+(CAShapeLayer*)cutCorners:(UIRectCorner)corners ForView:(UIView *)view withSize:(CGSize)size{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect: view.bounds byRoundingCorners:corners cornerRadii:size];
    //创建 layer
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    //赋值
    maskLayer.path = maskPath.CGPath;
    
    return maskLayer;
}

+ (NSDictionary *)convert2DictionaryWithJSONString:(NSString *)jsonString{
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"%@",err);
        return nil;
    }
    return dic;
}

+ (void)callUserLogin:(UIViewController *)contr{
    LoginVC *vc = [[LoginVC alloc] init];
    BaseNavigationController *vc2 = [[BaseNavigationController alloc] initWithRootViewController:vc];
    vc2.modalPresentationStyle = 0;
    [contr presentViewController:vc2 animated:true completion:nil];
}

+ (void)callUMLogin:(void (^_Nullable)(NSDictionary * _Nullable resultDic))complete with:(void (^_Nullable)(NSInteger type))completeType inVC:(UIViewController *)vc{
    

}
//--生成高清二维码
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 创建 bitmap
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 保存 bitmap 到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}


+ (void)checkHasOwnApp:(BaseViewController *)selfVC withData:(NSDictionary *)dic{
    
    
}

+(void)calUrl:(NSString *)targetUrl{
    
    if (@available(iOS 10.0, *)) {
//        [[UIApplication sharedApplication] openURL:URL(targetUrl) options:@{} completionHandler:^(BOOL success) {
//            NSLog(@"scheme调用结束");
//        }];
    } else {
        // Fallback on earlier versions
//        [[UIApplication sharedApplication] openURL:URL(targetUrl)];
    }
}



+ (void)PostWithUrlAndBody:(NSString *)url body:(NSData *)body success:(void(^)(NSDictionary *response))success failure:(void(^)(NSError *error))failure
{
    NSString *requestUrl = url;
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:requestUrl parameters:nil error:nil];
    request.timeoutInterval= 5.0;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

//    [request setValue:@"text/plain;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [request setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"cookie"] forHTTPHeaderField:@"Cookie"];
    // 设置body
    [request setHTTPBody:body];
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                 @"text/html",
                                                 @"text/json",
                                                 @"text/javascript",
                                                 @"text/plain",
                                                 nil];
    manager.responseSerializer = responseSerializer;
    [[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            success(responseObject);
        } else {
            failure(error);
        }
    }] resume];
}

@end
