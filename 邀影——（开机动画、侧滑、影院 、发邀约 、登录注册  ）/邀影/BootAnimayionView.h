//
//  BootAnimayionView.h
//  邀影
//
//  Created by ZY on 15/9/22.
//  Copyright (c) 2015年 罗凌云. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewExt.h"
#import "WXDataServiece.h"
@interface BootAnimayionView : UIView<UIScrollViewDelegate>
{
    NSMutableArray *_pageImages;  //存放所有页码的图片
    UIImageView *_pageImageView;  //页码显示图片
    
    NSMutableArray *_imageViews;  //普通启动界面所有图片存放的数组
    
    NSInteger _imageIndex;
    NSInteger imageCount;
}
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *titleCn;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, retain) NSArray *type;
@property (nonatomic, retain) NSArray *directors;
@property (nonatomic, retain) NSArray *actors;
@property (nonatomic, retain) NSArray *images;
@property (nonatomic, retain) NSArray *videos;

- (id)initContentWithDic:(NSDictionary *)jsonDic;
- (void)setAttributes:(NSDictionary *)jsonDic;
- (NSDictionary *)attributeMapDictionary:(NSDictionary *)jsonDic;

@end
