//
//  ViewController.m
//  邀影
//
//  Created by 罗凌云 on 15/9/18.
//  Copyright (c) 2015年 罗凌云. All rights reserved.
//

#import "ViewController.h"
#import "BootAnimayionView.h"
//#import "loginViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    BootAnimayionView *bootView = [[BootAnimayionView alloc]init];
    [self.view addSubview:bootView];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    loginViewController *loginVC = [Utilities getStoryboardInstanceByIdentity:@"Login"];
//    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:loginVC];
//    [self presentViewController:navi animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
