//
//  insViewController.h
//  邀影
//
//  Created by ZY on 15/9/23.
//  Copyright (c) 2015年 罗凌云. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface insViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *photoIV;
@property (weak, nonatomic) IBOutlet UILabel *movieTF;
@property (weak, nonatomic) IBOutlet UILabel *numberTF;
@property (weak, nonatomic) IBOutlet UILabel *wayTF;
@property (weak, nonatomic) IBOutlet UILabel *ins;
@property (weak, nonatomic) IBOutlet UILabel *timeTF;
@property (weak, nonatomic) IBOutlet UILabel *placeTF;
@property(strong,nonatomic)PFObject*obj;
@property(strong,nonatomic)PFObject*Booking;
@end
