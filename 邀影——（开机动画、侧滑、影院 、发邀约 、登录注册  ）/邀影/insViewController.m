//
//  insViewController.m
//  邀影
//
//  Created by ZY on 15/9/23.
//  Copyright (c) 2015年 罗凌云. All rights reserved.
//

#import "insViewController.h"

@interface insViewController ()
- (IBAction)delete:(UIButton *)sender forEvent:(UIEvent *)event;


@end

@implementation insViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    PFFile *photo = _obj[@"photo"];
    [photo getDataInBackgroundWithBlock:^(NSData *photoData, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:photoData];
            dispatch_async(dispatch_get_main_queue(), ^{
                _photoIV.image = image;
            });
        }
    }];
    
    NSDateFormatter*formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString*dataString=[formatter stringFromDate:_Booking[@"date"]];
    _timeTF.text=[NSString stringWithFormat:@"电影时间：%@",dataString];
    _placeTF.text=[NSString stringWithFormat:@"电影地点：%@",_Booking[@"place"]];
    _numberTF.text=[NSString stringWithFormat:@"电影人数：%@",_Booking[@"number"]];
    _movieTF.text=[NSString stringWithFormat:@"电影：%@",_Booking[@"movie"]];
    _wayTF.text=[NSString stringWithFormat:@"电影方式：%@",_Booking[@"way"]];
    _ins.text=[NSString stringWithFormat:@"邀请：%@",_Booking[@"ins"]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)delete:(UIButton *)sender forEvent:(UIEvent *)event {
    //提示框
    NSString *msg = [[NSString alloc]initWithFormat:@"确认删除？"];
    UIAlertView *confirmView = [[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [confirmView show];

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
        [self.Booking deleteInBackgroundWithBlock:^(BOOL succ,NSError *error){
            [aiv stopAnimating];
            if (succ) {
                [Utilities popUpAlertViewWithMsg:@"删除成功" andTitle:nil];
                [[NSNotificationCenter defaultCenter] performSelectorOnMainThread:@selector(postNotification:) withObject:[NSNotification notificationWithName:@"refreshMine" object:self] waitUntilDone:YES];
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        }];
    }
   }
@end
