//
//  registerViewController.m
//  邀影
//
//  Created by 罗凌云 on 15/9/21.
//  Copyright (c) 2015年 罗凌云. All rights reserved.
//

#import "registerViewController.h"

@interface registerViewController ()
- (IBAction)registerAction:(UIButton *)sender forEvent:(UIEvent *)event;

@end

@implementation registerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
//隐藏键盘
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

//- (void)dealloc {
//    [_usernameTF release];
//    [_emailTF release];
//    [_passwordTF release];
//    [_confrimPwdTF release];
//    [super dealloc];
//}
- (IBAction)registerAction:(UIButton *)sender forEvent:(UIEvent *)event {
    NSString *username = _usernameTF.text;
    NSString *email = _emailTF.text;
    NSString *password = _passwordTF.text;
    NSString *confirmPwd = _confrimPwdTF.text;
    //四个信息其中有个没写
    if ([username isEqualToString:@""] ||[email isEqualToString:@""]||[password isEqualToString:@""]||[confirmPwd isEqualToString:@""]) {
        [Utilities popUpAlertViewWithMsg:@"请填写所有信息" andTitle:nil];
        return;//阻止后面所有操作
    }
    //密码与第二次密码不同
    if(![password isEqualToString:confirmPwd]){
        [Utilities popUpAlertViewWithMsg:@"确认密码必须与密码保持一致" andTitle:nil];
        return;//阻止后面所有操作
    }
    PFUser *user = [PFUser user];
    user.username = username;
    user.password = password;
    user.email = email;
    
    UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
    //写入数据库
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        //菊花停止转
        [aiv stopAnimating];
        //没错就注册成功
        if (!error) {
            
            [[storageMgr singletonStorageMgr]addKeyAndValue:@"signup" And:@1];
            [self.navigationController popViewControllerAnimated:YES];
        } else if (error.code == 202) {
            [Utilities popUpAlertViewWithMsg:@"该用户名已被使用，请尝试其它名称!" andTitle:nil];
        } else if (error.code == 203) {
            [Utilities popUpAlertViewWithMsg:@"该电子邮箱已被使用，请尝试其它名称!" andTitle:nil];
        }else if (error.code == 125) {
            [Utilities popUpAlertViewWithMsg:@"该邮箱地址为非法地址!" andTitle:nil];
        }
        else if (error.code == 100) {
            [Utilities popUpAlertViewWithMsg:@"网络不给力，请稍后再试!" andTitle:nil];
        }
    }];
}
@end
