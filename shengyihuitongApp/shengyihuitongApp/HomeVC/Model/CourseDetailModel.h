//
//  CourseDetailModel.h
//  shengyihuitongApp
//
//  Created by Mac on 2020/6/26.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PLVVodSDK/PLVVodSDK.h>
NS_ASSUME_NONNULL_BEGIN

@class PLVVodLocalVideo;
@class PLVVodDownloadInfo;

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

@interface DownloadInfo: NSObject
@property (nonatomic, assign) NSInteger isDownload;//0表示未下载完成 1表示下载完成
@property (nonatomic, strong) NSString *identifier;//唯一标识
@property (nonatomic, strong) PLVVodDownloadInfo *downloadInfo;
@property (nonatomic, assign) NSInteger courseid;
@property (nonatomic, strong) NSString *vid;
@property (nonatomic, copy) NSString *snapshot; // 封面
@property (nonatomic, copy) NSString *title;    // 视频名称
@property (nonatomic, assign) NSUInteger filesize; // 文件大小
@property (nonatomic, assign) NSUInteger duration; // 视频时长
@end

@interface Chapter_list: NSObject<NSCopying,NSMutableCopying>
@property (nonatomic, assign) NSInteger parent_id;
@property (nonatomic, assign) NSInteger play_status;
@property (nonatomic, copy) NSString *live_end;
@property (nonatomic, copy) NSString *video_id;
@property (nonatomic, copy) NSString *chapter_name;
@property (nonatomic, assign) NSInteger chapter_id;
@property (nonatomic, assign) NSInteger difficult;
@property (nonatomic, strong) NSMutableArray<Child_list *> *child_list;
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
@property (nonatomic, assign) BOOL itemIsSel;//有课程item选中
@end



@interface CourseDetailModel : NSObject<NSCopying,NSMutableCopying>

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
@property (nonatomic, strong) NSMutableArray<Chapter_list *> *chapter_list;
@property (nonatomic, assign) NSInteger played;

@end


NS_ASSUME_NONNULL_END
