//
//  CourseDownloadModel.h
//  shengyihuitongApp
//
//  Created by 温州轩捷贸易有限公司 on 2020/7/1.
//  Copyright © 2020 温州轩捷贸易有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChildModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic ,strong) NSString *video_id;
@end

@interface ChapterModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray<ChildModel *> *child_list;
@end

@interface CourseDownloadModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray<ChapterModel *> *chapter_list;
@end

NS_ASSUME_NONNULL_END
