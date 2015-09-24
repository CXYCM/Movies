//
//  LeftViewController.m
//  邀影
//
//  Created by ZY on 15/9/22.
//  Copyright (c) 2015年 罗凌云. All rights reserved.
//

#import "LeftViewController.h"
#import "MYViewController.h"
@interface LeftViewController ()

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _objectsForShow = [[NSMutableArray alloc] initWithObjects:@"我的", @"清除缓存", @"反馈评价", @"检查更新", @"关于", nil];
    //去除多余下划线
    _tableView.tableFooterView = [[UIView alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return 10;
    return _objectsForShow.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [_objectsForShow objectAtIndex:indexPath.row];
    
    return cell;
}

//回到页面后就不会选中之前选中的哪行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //通过标识My判断选中第一行的时候是否跳转到 MYViewController页面
    if (indexPath.row == 0) {
        MYViewController *my = [Utilities getStoryboardInstanceByIdentity:@"MY"];
        //设置导航条的方法
        
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:my];
        
        [self presentViewController:navi animated:YES completion:nil];
    }
    else if(indexPath.row == 1){
        //弹窗
        UIAlertView *qcView = [[UIAlertView alloc]initWithTitle:nil message:@"清除缓存" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        //弹窗风格  （普通）
        [qcView setAlertViewStyle:UIAlertViewStyleDefault];
        [qcView show];
    }else if(indexPath.row == 2){
        //弹窗
        UIAlertView *qcView = [[UIAlertView alloc]initWithTitle:nil message:@"反馈评价" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        //弹窗风格  （普通）
        [qcView setAlertViewStyle:UIAlertViewStylePlainTextInput];
        [qcView show];
    }else if(indexPath.row == 3){
        //弹窗
        UIAlertView *qcView = [[UIAlertView alloc]initWithTitle:nil message:@"当前已是最新版本" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        //弹窗风格  （普通）
        [qcView setAlertViewStyle:UIAlertViewStyleDefault];
        [qcView show];
    }else if(indexPath.row == 4){
        //弹窗
        UIAlertView *qcView = [[UIAlertView alloc]initWithTitle:nil message:@"当前版本IV5.9.0.0" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        //弹窗风格  （普通）
        [qcView setAlertViewStyle:UIAlertViewStyleDefault];
        [qcView show];
        
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
