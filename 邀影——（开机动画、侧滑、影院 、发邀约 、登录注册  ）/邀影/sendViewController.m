//
//  sendViewController.m
//  邀影
//
//  Created by 罗凌云 on 15/9/21.
//  Copyright (c) 2015年 罗凌云. All rights reserved.
//

#import "sendViewController.h"

@interface sendViewController ()

- (IBAction)timeNo:(UIBarButtonItem *)sender;
- (IBAction)timeYes:(UIBarButtonItem *)sender;
- (IBAction)timeAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)movieNo:(UIBarButtonItem *)sender;
- (IBAction)movieYes:(UIBarButtonItem *)sender;
- (IBAction)movieAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)placeNo:(UIBarButtonItem *)sender;
- (IBAction)placeYes:(UIBarButtonItem *)sender;
- (IBAction)placeAction:(UIButton *)sender

               forEvent:(UIEvent *)event;
- (IBAction)goAction:(UIButton *)sender forEvent:(UIEvent *)event;





@end

@implementation sendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *arr = [[NSArray alloc] initWithObjects:@"双枪",@"金刚狼2",@"蓝精灵2",@"卑鄙的我2",@"长大成人2",@"极速蜗牛",@"赤焰战场2",@"环太平洋",@"迷途知返", nil];
    NSArray *arrr =[[NSArray alloc] initWithObjects:@"东城区",@"西城区",@"海淀区",@"朝阳区",@"崇文区",@"平谷区",@"燕郊开发区",@"密云县",@"延安县",nil];
    _nowArr = [NSArray array];
    self.movieArr = arr;
    self.placeArr = arrr;
//    [arr release];
//    [arrr release];

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

//- (void)dealloc {
//    [_date release];
//    [_tansView release];
//    [_classTB release];
//    [_timeButton release];
//    
//    [_movieTB release];
//    [_movieButton release];
//    [_movie release];
//    [_movieView release];
//    
//    [_place release];
//    [_placeView release];
//    [_placeTB release];
//    [_placeButton release];
//    
//    
//    [_say release];
//    [_way release];
//    [_numberTF release];
//    [_ins release];
//    [super dealloc];
//}
//------------时间

- (IBAction)timeNo:(UIBarButtonItem *)sender {
    _tansView.hidden=YES;//隐藏
}

- (IBAction)timeYes:(UIBarButtonItem *)sender {
    _tansView.hidden=YES;//隐藏
    NSDate *date=[_date date];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    formatter.dateFormat=@"yyyy-MM-dd HH:mm";
    NSString *timeStr=[formatter stringFromDate:date];
    NSLog(@"timeStr-------%@",timeStr);
    //文字赋值到button上去   在normal状态下显示这段文字
    [_timeButton setTitle:timeStr forState:UIControlStateNormal];
}

- (IBAction)timeAction:(UIButton *)sender forEvent:(UIEvent *)event {
    _tansView.hidden=NO;//展现
}


//------------电影

- (IBAction)movieNo:(UIBarButtonItem *)sender {
    _movieView.hidden=YES;
}


- (IBAction)movieYes:(UIBarButtonItem *)sender {
    _movieView.hidden=YES;
    NSInteger row = [_movie selectedRowInComponent:0];
    //得到目前选中这行文字
    NSString *titles = [_nowArr objectAtIndex:row];
    //文字赋值到button上去   在normal状态下显示这段文字
    [_movieButton setTitle:titles forState:UIControlStateNormal];
}

- (IBAction)movieAction:(UIButton *)sender forEvent:(UIEvent *)event {
    _nowArr = _movieArr;
    _movie.dataSource=self;
    _movie.delegate=self;
    _movieView.hidden=NO;
}




//------------地点

- (IBAction)placeNo:(UIBarButtonItem *)sender {
    _placeView.hidden=YES;
}

- (IBAction)placeYes:(UIBarButtonItem *)sender {
    _placeView.hidden=YES;
    NSInteger row = [_place selectedRowInComponent:0];
    //得到目前选中这行文字
    NSString *titles = [_nowArr objectAtIndex:row];
    //文字赋值到button上去   在normal状态下显示这段文字
    [_placeButton setTitle:titles forState:UIControlStateNormal];
}

- (IBAction)placeAction:(UIButton *)sender forEvent:(UIEvent *)event {
    _placeView.hidden=NO;
    _nowArr = _placeArr;
    _place.dataSource=self;
    _place.delegate=self;
}

//------------数据库上传

- (IBAction)goAction:(UIButton *)sender forEvent:(UIEvent *)event {
    //手动输入的东西
    NSString *invitation = _ins.text;
    NSString *ways = _way.text;
    NSString *numbers = _numberTF.text;
    NSString *describe = _say.text;
    NSString *movies=_movieButton.titleLabel.text;
    NSString *places = _placeButton.titleLabel.text;
    NSDate *date = _date.date;
    
    if ([ways isEqualToString:@""]) {
        [Utilities popUpAlertViewWithMsg:@"请填写邀请方式" andTitle:nil];
        return;
    }
    if ([numbers isEqualToString:@""]) {
        [Utilities popUpAlertViewWithMsg:@"请填写人数" andTitle:nil];
        return;
    }  if ([describe isEqualToString:@""]) {
        [Utilities popUpAlertViewWithMsg:@"请填写对小伙伴说的话" andTitle:nil];
        return;
    }
    if ([movies isEqualToString:@""]) {
        [Utilities popUpAlertViewWithMsg:@"请选择电影" andTitle:nil];
        return;
    }
    if ([places isEqualToString:@""]) {
        [Utilities popUpAlertViewWithMsg:@"请选择地点" andTitle:nil];
        return;
    }
    if ([invitation isEqualToString:@""]) {
        [Utilities popUpAlertViewWithMsg:@"请选择邀请性别" andTitle:nil];
        return;
    }

    //创建item 基本信息
    PFObject *item = [PFObject objectWithClassName:@"invitation"];
    item[@"ins"] = invitation;
    item[@"way"] = ways;
    item[@"number"] = numbers;
    item[@"say"] = describe;
    item[@"place"] = places;
    item[@"movie"] = movies;
    item[@"date"] =date;
    
    //设置关联  获得用户实例
    PFUser *currentUser = [PFUser currentUser];
    item[@"User"] = currentUser;
    
    //设置菊花
    UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
    
    //保存
    [item saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [aiv stopAnimating];
        if (succeeded) {//成功
            //结合线程去触发 通过refreshMine触发通知自己刷新列表
            [[NSNotificationCenter defaultCenter] performSelectorOnMainThread:@selector(postNotification:) withObject:[NSNotification notificationWithName:@"refreshyaoqing" object:self] waitUntilDone:YES];
            //返回上一页面
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [Utilities popUpAlertViewWithMsg:nil andTitle:nil];
        }
    }];

}






//组
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
//行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return _nowArr.count;
    
}

//处理textfield
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}
//处理textview
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [_nowArr objectAtIndex:row];
}



@end
