//
//  MYViewController.h
//  邀影
//
//  Created by ZY on 15/9/23.
//  Copyright (c) 2015年 罗凌云. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIImagePickerController *imagePickerController;
@property(strong,nonatomic)NSArray*objectsForShow;
@end
