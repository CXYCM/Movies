//
//  invitationTableViewController.h
//  邀影
//
//  Created by 罗凌云 on 15/9/21.
//  Copyright (c) 2015年 罗凌云. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface invitationTableViewController : UITableViewController{
       UITableView *_tableView;
}

@property(strong,nonatomic)NSArray*objectsForShow;
@end
