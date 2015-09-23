//
//  loginViewController.h
//  邀影
//
//  Created by 罗凌云 on 15/9/21.
//  Copyright (c) 2015年 罗凌云. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utilities.h"
#import "ECSlidingAnimationController.h"

@interface loginViewController : UIViewController
typedef NS_ENUM(NSInteger, LogingAnimationType) {
    LogingAnimationType_NONE,
    LogingAnimationType_USER,
    LogingAnimationType_PWD
};
@property (retain, nonatomic) IBOutlet UITextField *usernameTF;
@property (retain, nonatomic) IBOutlet UITextField *passwordTF;
@property (retain, nonatomic) IBOutlet UIView *loginview;
@property (retain, nonatomic) IBOutlet UIImageView *lefthidden;
@property (retain, nonatomic) IBOutlet UIImageView *righthidden;
@property (retain, nonatomic) IBOutlet UIImageView *leftlook;
@property (retain, nonatomic) IBOutlet UIImageView *rightlook;
@property (retain, nonatomic) IBOutlet UIButton *loginButton;



@end
