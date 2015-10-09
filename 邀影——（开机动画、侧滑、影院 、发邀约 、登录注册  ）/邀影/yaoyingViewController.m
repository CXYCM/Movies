//
//  yaoyingViewController.m
//  邀影
//
//  Created by ZY on 15/9/23.
//  Copyright (c) 2015年 罗凌云. All rights reserved.
//

#import "yaoyingViewController.h"
#import "insTableViewCell.h"
#import "Common.h"
@interface yaoyingViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation yaoyingViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //去除多余下划线
    _tableView.tableFooterView = [[UIView alloc]init];
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestData) name:@"refreshyaoqing" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestData) name:@"refreshMine" object:nil];
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _objectsForShow.count;
}


- (void)requestData {
    
    //得到当前用户
    PFQuery *query = [PFQuery queryWithClassName:@"invitation"];
    //Booking表中User 字段筛选当前用户
    [query includeKey:@"User"];
    //升序排序
    [query orderByAscending:@"date"];
    //菊花
    UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
    [query findObjectsInBackgroundWithBlock:^(NSArray *returnedObjects, NSError *error) {
        [aiv stopAnimating];
        if (!error) {
            _objectsForShow = returnedObjects;
            NSLog(@"%@", _objectsForShow);
            [_tableView reloadData];
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    
    static NSString *identifier = @"Cell";
    insTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    //底边下划线撑满整个屏幕的宽度
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"insTableViewCell" owner:self options:nil] lastObject];
    }
    PFUser *currentUser =[PFUser currentUser];
    //获得当前用户名
    cell.username.text=currentUser.username;
    cell.delegate = self;
    cell.indexPath = indexPath;
    PFObject *object = _objectsForShow[indexPath.row];
    PFUser *user = object[@"User"];
    cell.movie.text=object[@"movie"];
    cell.place.text=[NSString stringWithFormat:@"地点：%@",object[@"place"]];
    cell.say.text=[NSString stringWithFormat:@"对小伙伴说：%@",object[@"say"]];
    cell.way.text=[NSString stringWithFormat:@"方式%@",object[@"way"]];
    cell.number.text = [NSString stringWithFormat:@"邀请%@人",object[@"number"]];
    cell.ins.text = [NSString stringWithFormat:@"邀请%@",object[@"ins"]];
    if ([object[@"object"] integerValue] == 1) {
        [cell.App setTitle:@"取消" forState:UIControlStateNormal];
    } else {
        [cell.App setTitle:@"邀约" forState:UIControlStateNormal];
    }
    NSDateFormatter*formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString*dateString=[formatter stringFromDate:object[@"date"]];
    cell.date.text=[NSString stringWithFormat:@"时间：%@",dateString];
    PFFile *photo = user[@"photo"];
    [photo getDataInBackgroundWithBlock:^(NSData *photoData, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:photoData];
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.photo.image = image;
            });
        }
    }];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 180;
}

- (void)applyPressed:(NSIndexPath *)indexPath {
    ip = indexPath;
    PFObject *object = [_objectsForShow objectAtIndex:ip.row];
    NSLog(@"%@", object[@"object"]);
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
         message: [object[@"object"] integerValue] == 1 ? @"是否确认取消应邀？" : @"是否确认应邀？"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确认", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        PFObject *object = [_objectsForShow objectAtIndex:ip.row];
        if ([object[@"object"] integerValue] == 1) {
            object[@"object"] = @NO;
        } else {
            object[@"object"] = @YES;
        }
        [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {//成功
                [self.tableView reloadRowsAtIndexPaths:@[ip] withRowAnimation:UITableViewRowAnimationFade];
            } else {
                [Utilities popUpAlertViewWithMsg:nil andTitle:nil];
            }
        }];
    }
}
@end
