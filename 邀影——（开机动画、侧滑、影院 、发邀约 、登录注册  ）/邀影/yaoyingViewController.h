//
//  yaoyingViewController.h
//  邀影
//
//  Created by ZY on 15/9/23.
//  Copyright (c) 2015年 罗凌云. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "insTableViewCell.h"
@interface yaoyingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,insTableViewCellDelegate,UIActionSheetDelegate>{
     NSIndexPath *ip;
}
@property(strong,nonatomic)NSArray*objectsForShow;

;
@end
