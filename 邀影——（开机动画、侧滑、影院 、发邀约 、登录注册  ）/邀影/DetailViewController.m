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
    self.userName = self.textField.text;
    NSString *nameString = self.userName;
    if ([nameString length] == 0) {
        nameString = @"comment";
    }
    NSString *comment = [[NSString alloc]initWithFormat:@"%@",nameString];
    self.label.text = comment;

}
@end
