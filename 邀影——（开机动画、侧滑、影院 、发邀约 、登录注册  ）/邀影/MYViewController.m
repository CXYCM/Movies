//
//  MYViewController.m
//  邀影
//
//  Created by ZY on 15/9/23.
//  Copyright (c) 2015年 罗凌云. All rights reserved.
//

#import "MYViewController.h"
#import "insViewController.h"
@interface MYViewController ()
- (IBAction)XGAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)pickView:(UITapGestureRecognizer *)sender;

@end

@implementation MYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航条按钮
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = doneButton;
    //获得当前用户
    PFUser *currentUser =[PFUser currentUser];
    //获得当前用户名
    _username.text=currentUser.username;
    //去除多余下划线
    _tableView.tableFooterView = [[UIView alloc]init];
    [self requestData];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestData) name:@"refreshMine" object:nil];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//返回上一页
-(void)back{
    [self dismissViewControllerAnimated:self completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)XGAction:(UIButton *)sender forEvent:(UIEvent *)event {
    
    //弹窗
    UIAlertView *sellView = [[UIAlertView alloc]initWithTitle:nil message:@"修改用户名" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    //弹窗风格  （普通）
    [sellView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [sellView show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //如果按了1确定
    //PFQuery *query = [PFQuery queryWithClassName:@"User"];
    if (buttonIndex == 1) {
        UITextField *textField = [alertView textFieldAtIndex:0];
        
        if([textField.text isEqualToString:@""]){
            [Utilities popUpAlertViewWithMsg:@"请填写用户名"  andTitle:nil];
            return;//终止操作
        }
        PFUser *user=[PFUser currentUser];
        user[@"username"]=textField.text;
        
        UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
        [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [aiv stopAnimating];
            if (succeeded) {
                //退出
                [self dismissViewControllerAnimated:YES completion:nil];
                
            } else {
                [Utilities popUpAlertViewWithMsg:nil andTitle:nil];
            }
        }];
        
    }
    
}

- (IBAction)pickView:(UITapGestureRecognizer *)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择", nil];
    [actionSheet setExclusiveTouch:YES];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];

}
//摄像头
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 2)//2取消
        return;
    
    UIImagePickerControllerSourceType temp;
    if (buttonIndex == 0) {//0摄像头
        temp = UIImagePickerControllerSourceTypeCamera;
    } else if (buttonIndex == 1) {//1相册
        temp = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    if ([UIImagePickerController isSourceTypeAvailable:temp]) {
        _imagePickerController = nil;
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate = self;
        _imagePickerController.allowsEditing = YES;//可编辑
        _imagePickerController.sourceType = temp;
        [self presentViewController:_imagePickerController animated:YES completion:nil];
    } else {//监听模拟器有没有摄像头
        if (temp == UIImagePickerControllerSourceTypeCamera) {
            [Utilities popUpAlertViewWithMsg:@"当前设备无照相功能" andTitle:nil];
        }
    }
}



- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    PFObject *item = [PFObject objectWithClassName:@"Item"];
    
    //照片上传 本地图片转为PNG
    NSData *photoData = UIImagePNGRepresentation(_photo.image);
    PFFile *photoFile = [PFFile fileWithName:@"photo.png" data:photoData];
    item[@"photo"] = photoFile;
    UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
    [item saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [aiv stopAnimating];
        if (succeeded) {//成功
            //结合线程去触发 通过refreshMine触发通知自己刷新列表
            [[NSNotificationCenter defaultCenter] performSelectorOnMainThread:@selector(postNotification:) withObject:[NSNotification notificationWithName:@"refreshMine" object:self] waitUntilDone:YES];
            //返回上一页面
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [Utilities popUpAlertViewWithMsg:nil andTitle:nil];
        }
    }];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //已经编辑过的图片放到photo
    UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];
    _photo.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


//tableView
- (void)requestData {
    
    //得到当前用户
    PFQuery *query = [PFQuery queryWithClassName:@"invitation"];
    //Booking表中User字段筛选当前用户
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"Item"]) {
        //获得当前tableviewcell选中行的数据
        PFObject *object = [_objectsForShow objectAtIndex:[_tableView indexPathForSelectedRow].row];
        //获得目的地控制器
        insViewController *itemVC = segue.destinationViewController;
        //传过去的数据
        itemVC.Booking = object;
        //关联表  在预定的详情列表中读取图片
        PFObject*acObject=object[@"User"];
        itemVC.obj=acObject;
        //切换按钮隐藏
        itemVC.hidesBottomBarWhenPushed = YES;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _objectsForShow.count;
}

//tableview必须方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    PFObject *object = [_objectsForShow objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",object[@"movie"]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",object[@"ins"]];
    
    return cell;
}


//回到页面后就不会选中之前选中的哪行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
