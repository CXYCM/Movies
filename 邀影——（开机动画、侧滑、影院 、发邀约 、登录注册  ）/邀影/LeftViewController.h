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


@end
