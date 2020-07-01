//
//  CourseDetailModel.h
//  shengyihuitongApp
//
//  Created by Mac on 2020/6/26.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Child_list: NSObject
@property (nonatomic, assign) NSInteger study_time;
@property (nonatomic, copy) NSString *live_end;
@property (nonatomic, assign) NSInteger is_delete;
@property (nonatomic, assign) NSInteger difficult;
@property (nonatomic, assign) NSInteger chapter_id;
@property (nonatomic, assign) NSInteger course_id;
@property (nonatomic, assign) NSInteger is_video;
@property (nonatomic, copy) NSString *chapter_name;
@property (nonatomic, assign) NSInteger add_time;
@property (nonatomic, assign) NSInteger parent_id;
@property (nonatomic, assign) NSInteger play_status;
@property (nonatomic, copy) NSString *video_id;
@property (nonatomic, copy) NSString *live_begin;
@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, assign) NSInteger is_free;
@property (nonatomic, copy) NSString *intro;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) BOOL isSel;
@end

@interface Chapter_list: NSObject
@property (nonatomic, assign) NSInteger parent_id;
@property (nonatomic, assign) NSInteger play_status;
@property (nonatomic, copy) NSString *live_end;
@property (nonatomic, copy) NSString *video_id;
@property (nonatomic, copy) NSString *chapter_name;
@property (nonatomic, assign) NSInteger chapter_id;
@property (nonatomic, assign) NSInteger difficult;
@property (nonatomic, strong) NSArray<Child_list *> *child_list;
@property (nonatomic, copy) NSString *live_begin;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger is_delete;
@property (nonatomic, copy) NSString *intro;
@property (nonatomic, assign) NSInteger is_free;
@property (nonatomic, assign) NSInteger add_time;
@property (nonatomic, assign) NSInteger is_video;
@property (nonatomic, assign) NSInteger study_time;
@property (nonatomic, assign) NSInteger course_id;
@property (nonatomic, assign) NSInteger duration;
@end



@interface CourseDetailModel : NSObject

@property (nonatomic, assign) NSInteger is_delete;
@property (nonatomic, copy) NSString *video_id;
@property (nonatomic, copy) NSString *course_name;
@property (nonatomic, assign) BOOL is_collect;
@property (nonatomic, copy) NSString *topic_rand_price;
@property (nonatomic, assign) NSInteger last_video_chapter_id;
@property (nonatomic, assign) NSInteger hit;
@property (nonatomic, assign) BOOL hav_buy;
@property (nonatomic, copy) NSString *live_end;
@property (nonatomic, assign) NSInteger is_recomm;
@property (nonatomic, assign) NSInteger job_id;
@property (nonatomic, copy) NSString *topic_price;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, assign) NSInteger sort;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *commented;
@property (nonatomic, assign) NSInteger ctype;
@property (nonatomic, copy) NSString *intro;
@property (nonatomic, assign) NSInteger is_video;
@property (nonatomic, copy) NSString *live_begin;
@property (nonatomic, assign) NSInteger end_time;
@property (nonatomic, assign) NSInteger course_id;
@property (nonatomic, copy) NSString *topic_bet_price;
@property (nonatomic, assign) BOOL is_share;
@property (nonatomic, assign) NSInteger topic_bet_integral;
@property (nonatomic, assign) NSInteger add_time;
@property (nonatomic, assign) NSInteger topic_integral;
@property (nonatomic, assign) NSInteger teacher_id;
@property (nonatomic, assign) NSInteger score;
@property (nonatomic, assign) NSInteger is_free;
@property (nonatomic, assign) NSInteger begin_time;
@property (nonatomic, assign) NSInteger buyed;
@property (nonatomic, assign) NSInteger topic_rand_integral;
@property (nonatomic, copy) NSString *user_price;
@property (nonatomic, assign) NSInteger play_status;
@property (nonatomic, copy) NSString *room_id;
@property (nonatomic, copy) NSString *course_img;
@property (nonatomic, strong) NSArray<Chapter_list *> *chapter_list;
@property (nonatomic, assign) NSInteger played;

@end


NS_ASSUME_NONNULL_END
