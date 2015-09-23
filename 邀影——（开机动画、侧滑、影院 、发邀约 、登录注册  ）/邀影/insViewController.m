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
    _timeTF.text=[NSString stringWithFormat:@"%@",dataString];
    _placeTF.text=[NSString stringWithFormat:@"%@",_Booking[@"place"]];
    _numberTF.text=[NSString stringWithFormat:@"%@",_Booking[@"number"]];
    _movieTF.text=[NSString stringWithFormat:@"%@",_Booking[@"movie"]];
    _wayTF.text=[NSString stringWithFormat:@"%@",_Booking[@"way"]];
    _ins.text=[NSString stringWithFormat:@"%@",_Booking[@"ins"]];

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

- (IBAction)delete:(UIButton *)sender forEvent:(UIEvent *)event {
}
@end
