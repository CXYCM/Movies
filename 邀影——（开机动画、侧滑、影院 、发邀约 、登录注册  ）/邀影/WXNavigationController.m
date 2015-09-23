//
//  WXNavigationController.m
//  邀影
//
//  Created by 陈铭铭铭铭 on 15/9/22.
//  Copyright (c) 2015年 罗凌云. All rights reserved.
//

#import "WXNavigationController.h"

@interface WXNavigationController ()

@end

@implementation WXNavigationController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //修改导航栏上的标题颜色
    NSDictionary *textAttr = @{
                               NSForegroundColorAttributeName:[UIColor blackColor]
                               };
    self.navigationBar.titleTextAttributes = textAttr;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
