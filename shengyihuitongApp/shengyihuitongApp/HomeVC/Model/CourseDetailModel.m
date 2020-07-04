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

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
   CourseDetailModel *copy = [[self class] allocWithZone:zone];
    copy.play_status = self.play_status;
    copy.live_end = self.live_end;
    copy.video_id = self.video_id;
    copy.course_name = self.course_name;
    copy.course_id = self.course_id;
    copy.chapter_list = self.chapter_list;
    copy.live_begin = self.live_begin;
    copy.status = self.status;
    copy.is_delete = self.is_delete;
    copy.intro = self.intro;
    copy.is_free = self.is_free;
    copy.add_time = self.add_time;
    copy.is_video = self.is_video;
    copy.hav_buy = self.hav_buy;
    copy.course_img = self.course_img;
    copy.course_id = self.course_id;
    copy.is_collect = self.is_collect;
    return copy;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
//    CourseDetailModel *copy = [[CourseDetailModel allocWithZone:zone]init];
    CourseDetailModel *copy = [[self class] allocWithZone:zone];
    copy.play_status = self.play_status;
    copy.live_end = self.live_end;
    copy.video_id = self.video_id;
    copy.course_name = self.course_name;
    copy.course_id = self.course_id;
    copy.chapter_list = self.chapter_list;
    copy.live_begin = self.live_begin;
    copy.status = self.status;
    copy.is_delete = self.is_delete;
    copy.intro = self.intro;
    copy.is_free = self.is_free;
    copy.add_time = self.add_time;
    copy.is_video = self.is_video;
    copy.hav_buy = self.hav_buy;
    copy.course_img = self.course_img;
    copy.course_id = self.course_id;
    copy.is_collect = self.is_collect;
    return copy;
}

@end

@implementation Chapter_list

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"child_list":@"Child_list"};
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    Chapter_list *copy = [[self class] allocWithZone:zone];
    copy.play_status = self.play_status;
    copy.live_end = self.live_end;
    copy.video_id = self.video_id;
    copy.chapter_name = self.chapter_name;
    copy.course_id = self.course_id;
    copy.child_list = [self.child_list copy];
    copy.itemIsSel = self.itemIsSel;
    copy.live_begin = self.live_begin;
    copy.status = self.status;
    copy.is_delete = self.is_delete;
    copy.intro = self.intro;
    copy.is_free = self.is_free;
    copy.add_time = self.add_time;
    copy.is_video = self.is_video;
    copy.is_video = self.is_video;
    copy.duration = self.duration;
    copy.course_id = self.course_id;
    copy.intro = self.intro;
    return copy;
}

- (nonnull id)mutableCopyWithZone:(nullable NSZone *)zone {
    Chapter_list *copy = [[self class] allocWithZone:zone];
    copy.play_status = self.play_status;
    copy.live_end = self.live_end;
    copy.video_id = self.video_id;
    copy.chapter_name = self.chapter_name;
    copy.course_id = self.course_id;
    copy.child_list = [self.child_list copy];
    copy.live_begin = self.live_begin;
    copy.status = self.status;
    copy.is_delete = self.is_delete;
    copy.intro = self.intro;
    copy.is_free = self.is_free;
    copy.add_time = self.add_time;
    copy.is_video = self.is_video;
    copy.is_video = self.is_video;
    copy.duration = self.duration;
    copy.course_id = self.course_id;
    copy.intro = self.intro;
    copy.itemIsSel = self.itemIsSel;
    return copy;
}

@end
@implementation Child_list



@end


@implementation DownloadInfo



@end
