//
//  XJUtil.h
//  MallApp
//
//  Created by mac on 2020/1/7.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Macro.h"
#import "BaseViewController.h"
NS_ASSUME_NONNULL_BEGIN


@interface XJUtil : NSObject
/*!
 * @brief 获取当前时间作为图片的名称
 * @return 以"20160621171802.png"形式的当前时间字符串形式的照片名
 */
+ (NSString * _Nonnull)achieveImageNameWithCurrentTime;

/*!
 * @breif
 * @param obj 输入值
 * @return 传入对象为空则返回默认输入值
 */
+ (id _Nonnull)insertStringWithNotNullObject:(id _Nonnull)obj
                              andDefailtInfo:(nonnull id)defailInfo;

/**
 删除 navigationController.viewControllers 里的界面
 
 @param array navigationController.viewControllers
 @param classNames 多个 string
 @return return navigationController.viewControllers
 */
+(NSMutableArray *)removeNavViewController:(NSArray *)array withArrayClassName:(NSArray *)classNames;
/**
提取img标签
@param html html标签
@return return navigationController.viewControllers
*/
+(NSString *)filterImage:(NSString *)html;

/**
 提取img标签
 @param html html description
 */
+(NSString *)filterHtmlGoodsImageArr:(NSString *)html;

/**
 拨打电话 一个 系统的弹窗

 @param phone phone description
 */
+(void)callTelNoCommAlert:(NSString *)phone;

/**
popTOVC
@param VC ClassString
@param ViewController totalVC
@param rootVC rootVC
*/
+(void)popToVC:(NSString *)VC inViewControllers:(NSArray<__kindof UIViewController *> *)ViewController InCurNav:(UINavigationController *)rootVC;

/**
字符串转时间戳
@param formatTime 2019-10-11 10:12:12
@return return 1583948569
*/
+ (NSInteger)timeSwitchTimestamp:(NSString *)formatTime;

/**
获取当前时间yyyyMMdd
*/
+(NSString *)getNowTimeStamp;

/**
获取当前时间YYYY-MM_dd
*/
+ (NSString * _Nonnull)getNowTime;

/**
处理分页数据

*/
+ (NSMutableArray *)dealData:(NSArray *)array withRefreshType:(RefreshType)type withListView:(UITableView *)listTable AndCurDataArray:(NSMutableArray *)dataArr withNum:(NSInteger)num;
/**
判断密码是否符合
*/
+ (BOOL)isValidPassword:(NSString *)pwd;

//获得设备型号
+ (NSString *)getCurrentDeviceModel;
/**
清除本地缓存
*/
+ (void)resetDefaults;

/**
 颜色转图片

 @param color color description
 @return return value description
 */
+(UIImage*) createImageWithColor:(UIColor*) color;

/**
 切圆角

 @param corners corners description
 @param view view description
 @param size size description
 @return return value description
 */
+(CAShapeLayer*)cutCorners:(UIRectCorner)corners ForView:(UIView *)view withSize:(CGSize)size;

/**
json字符串->json

@param jsonString jsonString description
@return return value description
*/
+ (NSDictionary *)convert2DictionaryWithJSONString:(NSString *)jsonString;

/**
callLogin

@param contr contr description

*/
+ (void)callUserLogin:(UIViewController *)contr;



/// callUMLogin
/// @param complete complete description
+ (void)callUMLogin:(void (^_Nullable)(NSDictionary * _Nullable resultDic))complete with:(void (^_Nullable)(NSInteger type))completeType inVC:(UIViewController *)vc;

/// 生成高清图片
/// @param image image description
/// @param size size description
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size;

/**
检测支持本机的地图app
*/
+ (void)checkHasOwnApp:(BaseViewController *)selfVC withData:(NSDictionary *)dic;


/**
 *  异步POST请求:以body方式,支持数组
 *
 *  @param url     请求的url
 *  @param body    body数据（NSString 转为utf8编码的NSData就行）
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)PostWithUrlAndBody:(NSString *)url body:(NSData *)body success:(void(^)(NSDictionary *response))success failure:(void(^)(NSError *error))failure;
@end

NS_ASSUME_NONNULL_END
