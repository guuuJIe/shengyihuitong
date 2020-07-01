//
//  CourseDetailModel.m
//  shengyihuitongApp
//
//  Created by Mac on 2020/6/26.
//  Copyright © 2020 mac. All rights reserved.
//

#import "CourseDetailModel.h"

@implementation CourseDetailModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"chapter_list":@"Chapter_list"};
}
@end

@implementation Chapter_list

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"child_list":@"Child_list"};
}

@end
@implementation Child_list



@end
