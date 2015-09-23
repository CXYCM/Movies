//
//  WXDataServiece.m
//  Project-WXMovie26
//
//  Created by keyzhang on 14-8-20.
//  Copyright (c) 2014年 keyzhang. All rights reserved.
//

#import "WXDataServiece.h"

@implementation WXDataServiece


+ (id)requestData:(NSString *)fileName
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    NSError *error = nil;
    
    //通过系统自带的json解析方法解析json数据（5.0之后）
    id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    if (json == nil) {
        NSLog(@"%@",error);
        return nil;
    }
    
    return json;
}


@end
