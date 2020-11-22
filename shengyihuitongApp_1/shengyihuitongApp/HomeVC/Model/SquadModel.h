//
//  SquadModel.h
//  shengyihuitongApp
//
//  Created by Mac on 2020/6/26.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface Course_list: NSObject
@property (nonatomic, copy) NSString *video_id;
@property (nonatomic, copy) NSString *topic_rand_price;
@property (nonatomic, assign) NSInteger is_recomm;
@property (nonatomic, assign) NSInteger buyed;
@property (nonatomic, copy) NSString *room_id;
@property (nonatomic, assign) NSInteger add_time;
@property (nonatomic, assign) NSInteger is_delete;
@property (nonatomic, copy) NSString *course_img;
@property (nonatomic, assign) NSInteger topic_integral;
@property (nonatomic, assign) NSInteger course_id;
@property (nonatomic, assign) NSInteger begin_time;
@property (nonatomic, copy) NSString *intro;
@property (nonatomic, assign) NSInteger job_id;
@property (nonatomic, assign) NSInteger played;
@property (nonatomic, assign) NSInteger score;
@property (nonatomic, copy) NSString *course_name;
@property (nonatomic, assign) NSInteger topic_rand_integral;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, assign) NSInteger end_time;
@property (nonatomic, assign) NSInteger teacher_id;
@property (nonatomic, assign) NSInteger topic_bet_integral;
@property (nonatomic, assign) NSInteger is_free;
@property (nonatomic, copy) NSString *user_price;
@property (nonatomic, assign) NSInteger ctype;
@property (nonatomic, assign) NSInteger is_video;
@property (nonatomic, copy) NSString *topic_price;
@property (nonatomic, assign) NSInteger sort;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger commented;
@property (nonatomic, assign) NSInteger hit;
@property (nonatomic, copy) NSString *topic_bet_price;
@end

@interface SquadModel : NSObject
@property (nonatomic, assign) NSInteger job_id;
@property (nonatomic, assign) NSInteger user_limit;
@property (nonatomic, assign) NSInteger begin_time;
@property (nonatomic, assign) NSInteger squad_id;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *ios_deposit;
@property (nonatomic, assign) NSInteger buyed;
@property (nonatomic, assign) BOOL is_collect;
@property (nonatomic, copy) NSString *squad_img;
@property (nonatomic, copy) NSString *intro;
@property (nonatomic, copy) NSString *squad_name;
@property (nonatomic, assign) NSInteger add_time;
@property (nonatomic, assign) BOOL hav_buy;
@property (nonatomic, assign) NSInteger school_id;
@property (nonatomic, copy) NSString *deposit;
@property (nonatomic, assign) NSInteger is_delete;
@property (nonatomic, assign) NSInteger stype;
@property (nonatomic, assign) NSInteger sort;
@property (nonatomic, strong) NSArray<Course_list *> *course_list;
@property (nonatomic, assign) NSInteger end_time;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, assign) NSInteger is_recomm;
@end

NS_ASSUME_NONNULL_END
