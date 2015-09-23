//
//  Utilities.m
//  Utility
//
//  Created by ZIYAO YANG on 15/8/20.
//  Copyright (c) 2015年 Zhong Rui. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities

+ (id)getUserDefaults:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (void)setUserDefaults:(NSString *)key content:(id)value
{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)removeUserDefaults:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//通过这个方法只要输入stroyboard的名称直接得到stroyboard
+ (id)getStoryboardInstanceByIdentity:(NSString*)identity
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"MainApp" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:identity];
}

//弹出警告框
+ (void)popUpAlertViewWithMsg:(NSString *)msg andTitle:(NSString* )title
{
    //title是空默认 提示
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title == nil ? @"提示" : title
                                                        message:msg == nil ? @"操作失败" : msg
                                                       delegate:self
                                              cancelButtonTitle:@"确认"
                                              otherButtonTitles:nil];
    [alertView show];
}

+ (UIActivityIndicatorView *)getCoverOnView:(UIView *)view
{
    UIActivityIndicatorView *aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    //深灰色0.4透明度  灰色膜白色菊花
    aiv.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.4];
    aiv.frame = view.bounds;
    [view addSubview:aiv];
    [aiv startAnimating];
    return aiv;
}
+ (NSString *)notRounding:(float)price afterPoint:(int)position
{
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    
    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:price];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [NSString stringWithFormat:@"%@",roundedOunces];
}
@end
