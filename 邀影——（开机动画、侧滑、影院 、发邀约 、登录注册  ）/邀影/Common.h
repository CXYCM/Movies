//
//  Common.h
//  Project-WXMovie26
//
//  Created by keyzhang on 14-8-19.
//  Copyright (c) 2014年 keyzhang. All rights reserved.
//

#ifndef Project_WXMovie26_Common_h
#define Project_WXMovie26_Common_h

//屏幕的宽、高
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define ios7 ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)


//接口宏定义
#define us_box     @"us_box"    //北美榜
#define news_list  @"news_list" //新闻列表
#define top250     @"top250"    //top电影列表
#define image_list @"image_list"//图片浏览数据


#define WXRelease(obj) [obj release];obj = nil;



#endif
