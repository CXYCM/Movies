//
//  loginViewController.m
//  邀影
//
//  Created by 罗凌云 on 15/9/21.
//  Copyright (c) 2015年 罗凌云. All rights reserved.
//

#import "loginViewController.h"
#import "MainTabViewController.h"


@interface loginViewController ()
{
    UIImageView* imgLeftHand;
    UIImageView* imgRightHand;
    
    UIImageView* imgLeftHandGone;
    UIImageView* imgRightHandGone;
    
    LogingAnimationType AnimationType;
}
- (IBAction)loginAction:(UIButton *)sender forEvent:(UIEvent *)event;
@end

@implementation loginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UISetting];
    // Do any additional setup after loading the view.
    NSLog(@"IN");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)UISetting{
    
    AnimationType = LogingAnimationType_NONE;
    
    UIColor* boColor = [UIColor colorWithRed:221.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:100];
    
    _usernameTF.layer.borderColor = boColor.CGColor;
    _usernameTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    _usernameTF.leftViewMode = UITextFieldViewModeAlways;
    UIImageView* imgUser = [[UIImageView alloc] initWithFrame:CGRectMake(11, 11, 22, 22)];
    imgUser.image = [UIImage imageNamed:@"iconfont-user"];
    [_usernameTF.leftView addSubview:imgUser];
    
    _passwordTF.layer.borderColor = boColor.CGColor;
    _passwordTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    _passwordTF.leftViewMode = UITextFieldViewModeAlways;
    UIImageView* imgPwd = [[UIImageView alloc] initWithFrame:CGRectMake(11, 11, 22, 22)];
    imgPwd.image = [UIImage imageNamed:@"iconfont-password"];
    [_passwordTF.leftView addSubview:imgPwd];
    
    _loginview.layer.borderColor = boColor.CGColor;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if ([textField isEqual:_passwordTF]) {
        AnimationType = LogingAnimationType_PWD;
        [self AnimationUserToPassword];
        
    }else{
        
        if (AnimationType == LogingAnimationType_NONE) {
            AnimationType = LogingAnimationType_USER;
            return;
        }
        AnimationType = LogingAnimationType_USER;
        [self AnimationPasswordToUser];
        
    }
    
}

#pragma mark 移开手动画
-(void)AnimationPasswordToUser{
    
    [UIView animateWithDuration:0.5f animations:^{
        
        self.leftlook.frame = CGRectMake(self.leftlook.frame.origin.x - 80, self.leftlook.frame.origin.y, 40, 40);
        self.rightlook.frame = CGRectMake(self.rightlook.frame.origin.x + 40, self.rightlook.frame.origin.y, 40, 40);
        
        self.righthidden.frame = CGRectMake(self.righthidden.frame.origin.x+55, self.rightlook.frame.origin.y+40, 40, 66);
        self.lefthidden.frame = CGRectMake(self.lefthidden.frame.origin.x-60, self.leftlook.frame.origin.y+40, 40, 66);
        
    } completion:^(BOOL finished) {
        
    }];
    
}

#pragma mark 捂眼
-(void)AnimationUserToPassword{
    [UIView animateWithDuration:0.5f animations:^{
        
        self.leftlook.frame = CGRectMake(self.leftlook.frame.origin.x + 80, self.leftlook.frame.origin.y, 0, 0);
        self.rightlook.frame = CGRectMake(self.rightlook.frame.origin.x - 40, self.rightlook.frame.origin.y, 0, 0);
        
        self.righthidden.frame = CGRectMake(self.righthidden.frame.origin.x-55, self.righthidden.frame.origin.y-40, 40, 66);
        self.lefthidden.frame = CGRectMake(self.lefthidden.frame.origin.x+60, self.lefthidden.frame.origin.y-40, 40, 66);
        
    } completion:^(BOOL finished) {
        
    }];
}


//- (void)dealloc {
//    [_usernameTF release];
//    [_passwordTF release];
//    [_loginview release];
//    [_righthidden release];
//    [_lefthidden release];
//    [_leftlook release];
//    [_rightlook release];
//    [_loginButton release];
//    [super dealloc];
//}
-(void)popUpHomePage{
    MainTabViewController *tabVC = [Utilities getStoryboardInstanceByIdentity:@"Tab"];
    
    UINavigationController* naviVC = [[UINavigationController alloc] initWithRootViewController:tabVC];
    naviVC.navigationBarHidden = YES;
    [self presentViewController:naviVC animated:YES completion:nil];
    
}
//隐藏键盘
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}


- (IBAction)EndEDitTap:(id)sender {
    if (AnimationType == LogingAnimationType_PWD) {
        [self AnimationPasswordToUser];
    }
    AnimationType = LogingAnimationType_NONE;
    [self.view endEditing:YES];
}

- (IBAction)loginAction:(UIButton *)sender forEvent:(UIEvent *)event {
    NSString *username = _usernameTF.text;
    NSString *password = _passwordTF.text;
    
    if ([username isEqualToString:@""] || [password isEqualToString:@""]) {
        [Utilities popUpAlertViewWithMsg:@"请填写所有信息" andTitle:nil];
        return;
    }
    
    UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error) {
        [aiv stopAnimating];
        if (user) {
            [Utilities setUserDefaults:@"userName" content:username];
            //     _usernameTF.text = @"";
            _passwordTF.text = @"";
            [self popUpHomePage];
            
        } else if (error.code == 101) {
            [Utilities popUpAlertViewWithMsg:@"用户名或密码错误" andTitle:nil];
        } else if (error.code == 100) {
            [Utilities popUpAlertViewWithMsg:@"网络不给力，请稍后再试" andTitle:nil];
        }else{
            [Utilities popUpAlertViewWithMsg:nil andTitle:nil];
        }
    }];
    

}



@end
