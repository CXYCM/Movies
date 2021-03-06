//
//  DetailViewController.m
//  邀影
//
//  Created by ZY on 15/9/24.
//  Copyright (c) 2015年 罗凌云. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
- (IBAction)comment:(id)sender;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = [NSString stringWithFormat:@"%@", _item[@"name"]];
    
    PFFile *photo = _item[@"photo"];
    PFFile *face = _item[@"face"];
    PFFile *face1 = _item[@"face1"];
    [face getDataInBackgroundWithBlock:^(NSData *faceData, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:faceData];
            dispatch_async(dispatch_get_main_queue(), ^{
                _photoIV.image = image;
            });
        }
    }];
    [photo getDataInBackgroundWithBlock:^(NSData *photoData, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:photoData];
            dispatch_async(dispatch_get_main_queue(), ^{
                _imageIV.image = image;
            });
        }
    }];
    [face1 getDataInBackgroundWithBlock:^(NSData *face1Data, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:face1Data];
            dispatch_async(dispatch_get_main_queue(), ^{
                _faceIV.image = image;
            });
        }
    }];
    
    _descTV.text = _item[@"description"];
    _reviewTV.text = _item[@"review"];
    _review1TV.text = _item[@"review1"];
    //监听键盘的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangFrame:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(HideNotification:) name:UIKeyboardWillHideNotification object:nil];
    
}

#pragma mark - 文本框代理
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self ];
}
-(void)HideNotification:(NSNotification *)note
{
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
}
/**
 *  当键盘改变了frame（位置和尺寸）的时候调用
 */
-(void)keyboardWillChangFrame:(NSNotification *)note
{
    
    //0.取出键盘动画的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //1.取得键盘最后的frame
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    
    NSLog(@"keyboardFrame = %0.2f",keyboardFrame.origin.y);
    //2.计算控制器的view需要平移的距离
    
    //    CGFloat hieght=[_textField]
    CGRect newFrame = [_textField convertRect:_textField.bounds toView:self.view];
    CGFloat transformY = keyboardFrame.origin.y-newFrame.origin.y-newFrame.size.height;
    
    //3.执行动画
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, transformY);
    }];
    
}
-(BOOL)prefersStatusBarHidden
{
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)comment:(id)sender {
    self.userComment = self.textField.text;
    NSString *commentString = self.userComment   ;
    if ([commentString length] == 0) {
        //commentString = @"";
        //弹窗
        UIAlertView *reView = [[UIAlertView alloc]initWithTitle:nil message:@"请填写评论" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        //弹窗风格  （普通）
        //[qcView setAlertViewStyle:UIAlertViewStylePlainTextInput];
        [reView show];
    }
    NSString *comment = [[NSString alloc]initWithFormat:@"我的评论：%@",commentString];
    self.label.text = comment;
    self.textField.text = @"";
    self.textField.placeholder = @"";
    PFObject *items = [PFObject objectWithClassName:@"Movie"];
    items[@"userreview"] =commentString;
    
    //设置菊花
    UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
    
    //保存
    [items saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [aiv stopAnimating];
        if (succeeded) {//成功
            //结合线程去触发 通过refreshMine触发通知自己刷新列表
            [[NSNotificationCenter defaultCenter] performSelectorOnMainThread:@selector(postNotification:) withObject:[NSNotification notificationWithName:nil object:self] waitUntilDone:YES];
            //返回上一页面
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [Utilities popUpAlertViewWithMsg:nil andTitle:nil];
        }
    }];
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];

}
@end
