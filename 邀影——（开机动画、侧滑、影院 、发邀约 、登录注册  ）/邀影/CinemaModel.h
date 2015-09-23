//
//  CinemaModel.h
//  邀影
//
//  Created by ZY on 15/9/23.
//  Copyright (c) 2015年 罗凌云. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CinemaModel : NSObject
- (id)initContentWithDic:(NSDictionary *)jsonDic;
- (void)setAttributes:(NSDictionary *)jsonDic;
- (NSDictionary *)attributeMapDictionary:(NSDictionary *)jsonDic;
@property(nonatomic,copy)NSString *lowPrice;
@property(nonatomic,copy)NSString *grade;
@property(nonatomic,copy)NSString *coord;
@property(nonatomic,copy)NSString *address;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *cinemaId;
@property(nonatomic,copy)NSString *districtId;
@property(nonatomic,copy)NSString *isSeatSupport;
@property(nonatomic,copy)NSString *isCouponSupport;
@property(nonatomic,copy)NSString *circleName;
@end
