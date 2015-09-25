//
//  LeftViewController.h
//  邀影
//
//  Created by ZY on 15/9/22.
//  Copyright (c) 2015年 罗凌云. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftViewController : UIViewController<UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *objectsForShow;
@property (weak, nonatomic) IBOutlet UILabel *YHname;

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;

@end
