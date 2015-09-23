//
//  MainTabViewController.m
//  邀影
//
//  Created by 罗凌云 on 15/9/21.
//  Copyright (c) 2015年 罗凌云. All rights reserved.
//

#import "MainTabViewController.h"
#import "BootAnimayionView.h"

@interface MainTabViewController ()

@end

@implementation MainTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    BootAnimayionView *bootView = [[BootAnimayionView alloc]init];
    [self.view addSubview:bootView];
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

@end
