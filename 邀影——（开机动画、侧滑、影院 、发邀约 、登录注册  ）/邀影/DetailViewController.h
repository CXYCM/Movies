//
//  DetailViewController.h
//  邀影
//
//  Created by ZY on 15/9/24.
//  Copyright (c) 2015年 罗凌云. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageIV;
@property (weak, nonatomic) IBOutlet UITextView *descTV;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextView *reviewTV;
@property (weak, nonatomic) IBOutlet UITextView *review1TV;
@property (weak, nonatomic) IBOutlet UIImageView *photoIV;
@property (weak, nonatomic) IBOutlet UIImageView *faceIV;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (strong, nonatomic) PFObject *item;

@property (copy,nonatomic) NSString *userComment;

@end
