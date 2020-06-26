//
//  Interface.h
//  shengyihuitongApp
//
//  Created by mac on 2020/6/23.
//  Copyright © 2020 mac. All rights reserved.
//

#ifndef Interface_h
#define Interface_h


#define appLogin @"/api/login"
#define getUserInfo @"/api/user"
#define Homeindex @"/api/index"
#define getthirdClass @"/api/third/class"
#define getthirdLink @"/api/third/link/"
#define getcateData @"/api/config"
#define getcourseData @"/api/course"
#define getJobCourse @"/api/course/job"
#define getLiveData @"/api/course/live"
#define getCourseInfoData @"/api/course/info/"
#define getSquadListData @"/api/course/squad/"
#define getUserCourse @"/api/user/course"
#define getUserSquad @"/api/user/squad"
#ifdef DEBUG

#define KServer @"http://class.syhtedu.com"


#else

#define KServer @"http://class.syhtedu.com"


#endif

#endif /* Interface_h */
