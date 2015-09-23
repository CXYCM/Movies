//
//  sendViewController.h
//  邀影
//
//  Created by 罗凌云 on 15/9/21.
//  Copyright (c) 2015年 罗凌云. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sendViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>
//时间
@property (retain, nonatomic) IBOutlet UIView *tansView;
@property (retain, nonatomic) IBOutlet UIDatePicker *date;
@property (retain, nonatomic) IBOutlet UIToolbar *classTB;
@property (retain, nonatomic) IBOutlet UIButton *timeButton;


//电影
@property (retain, nonatomic) IBOutlet UIToolbar *movieTB;
@property (retain, nonatomic) IBOutlet UIButton *movieButton;
@property (retain, nonatomic) IBOutlet UIPickerView *movie;
@property (retain, nonatomic) IBOutlet UIView *movieView;

@property(strong,nonatomic)NSArray * movieArr;
//地点
@property (retain, nonatomic) IBOutlet UIPickerView *place;
@property (retain, nonatomic) IBOutlet UIView *placeView;
@property (retain, nonatomic) IBOutlet UIToolbar *placeTB;
@property (retain, nonatomic) IBOutlet UIButton *placeButton;
@property(strong,nonatomic)NSArray * placeArr;

@property(strong,nonatomic)NSArray * nowArr;
//数据库
@property (retain, nonatomic) IBOutlet UITextView *say;
@property (retain, nonatomic) IBOutlet UITextField *way;
@property (retain, nonatomic) IBOutlet UITextField *numberTF;
@property (retain, nonatomic) IBOutlet UITextField *ins;



@end
