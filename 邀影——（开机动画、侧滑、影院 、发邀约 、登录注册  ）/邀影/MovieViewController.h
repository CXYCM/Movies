//
//  MovieViewController.h
//  邀影
//
//  Created by ZY on 15/9/24.
//  Copyright (c) 2015年 罗凌云. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) PFObject *item;
@property (strong,nonatomic) NSArray *objectsForShow;
@property (strong,nonatomic) NSTimer *timer;
@end
