//
//  sendViewController.m
//  邀影
//
//  Created by 罗凌云 on 15/9/21.
//  Copyright (c) 2015年 罗凌云. All rights reserved.
//

#import "sendViewController.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@interface sendViewController ()<RFSegmentViewDelegate>


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
    PFQuery *query = [PFQuery queryWithClassName:@"Movie"];
    
    UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
    [query findObjectsInBackgroundWithBlock:^(NSArray *returnedObjects, NSError *error) {
        [aiv stopAnimating];
        if (!error) {
            self.movieArr = returnedObjects;
            NSLog(@"%@", _movieArr);
            [_movie reloadAllComponents];
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

   // NSArray *arr = [[NSArray alloc] initWithObjects:@"双枪",@"金刚狼2",@"蓝精灵2",@"卑鄙的我2",@"长大成人2",@"极速蜗牛",@"赤焰战场2",@"环太平洋",@"迷途知返", nil];
    NSArray *arrr =[[NSArray alloc] initWithObjects:@"东城区",@"西城区",@"海淀区",@"朝阳区",@"崇文区",@"平谷区",@"燕郊开发区",@"密云县",@"延安县",nil];
    _nowArr = [NSArray array];
    self.placeArr = arrr;

    _segmentView = [[RFSegmentView alloc] initWithFrame:CGRectMake(kScreenWidth/2, 60,kScreenWidth/2 , 60) items:@[@"男生",@"女生",@"不限"]];
    _segmentView.tintColor = [self getRandomColor];
    _segmentView.delegate = self;
    [self.view addSubview:_segmentView];
    
    _segmentViews = [[RFSegmentView alloc] initWithFrame:CGRectMake(kScreenWidth/2, 110,kScreenWidth/2 , 60) items:@[@"AA制",@"你请客",@"我请客"]];
    _segmentViews.tintColor = [self getRandomColor];
    _segmentViews.delegate = self;
    [self.view addSubview:_segmentViews];


}
- (UIColor *)getRandomColor

{
    UIColor *color = [UIColor grayColor ];
    return color;
}

- (void)segmentViewSelectIndex:(NSInteger)index
{
    if (_segmentView) {
        gender = index;
    }else if (_segmentViews) {
        genders = index;
    }
    
    
}

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
    
    NSString *ins = @"男生";
    switch (gender) {
        case 0: {
            ins = @"男生";
        }
            break;
        case 1: {
            ins = @"女生";
        }
            break;
        case 2: {
            ins = @"不限";
        }
            break;
        default:
            break;
    }
    NSString *way = @"AA制";
    switch (genders) {
        case 0: {
            way = @"AA制";
        }
            break;
        case 1: {
            way = @"你请客";
        }
            break;
        case 2: {
            way = @"我请客";
        }
            break;
        default:
            break;
    }

    //手动输入的东西
    NSString *numbers = _numberTF.text;
    NSString *describe = _say.text;
    NSString *movies=_movieButton.titleLabel.text;
    NSString *places = _placeButton.titleLabel.text;
    NSDate *date = _date.date;
   
    if ([numbers isEqualToString:@""]) {
        [Utilities popUpAlertViewWithMsg:@"请填写人数" andTitle:nil];
        return;
    }  if ([describe isEqualToString:@""]) {
        [Utilities popUpAlertViewWithMsg:@"请填写对小伙伴说的话" andTitle:nil];
        return;
    }
    if ([movies isEqualToString:@"选择电影 >"]) {
        [Utilities popUpAlertViewWithMsg:@"请选择电影" andTitle:nil];
        return;
    }
    if ([places isEqualToString:@"选择地点 >"]) {
        [Utilities popUpAlertViewWithMsg:@"请选择地点" andTitle:nil];
        return;
    }
    

    //创建item 基本信息
    PFObject *item = [PFObject objectWithClassName:@"invitation"];
    item[@"ins"] = ins;
    item[@"way"] = way;
    item[@"number"] = numbers;
    item[@"say"] = describe;
    item[@"place"] = places;
    item[@"movie"] = movies;
    item[@"date"] =date;
    item[@"object"] = @NO;

    
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
    
    if (pickerView == _movie) {
        return _movieArr.count;
    } else {
        return _placeArr.count;
    }

    
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
    if (pickerView == _movie) {
        PFObject *movie = [_movieArr objectAtIndex:row];
        return movie[@"name"];
    } else {
        return [_placeArr objectAtIndex:row];
    }
}



@end
