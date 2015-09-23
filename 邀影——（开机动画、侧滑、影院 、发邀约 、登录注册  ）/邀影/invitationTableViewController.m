//
//  invitationTableViewController.m
//  邀影
//
//  Created by 罗凌云 on 15/9/21.
//  Copyright (c) 2015年 罗凌云. All rights reserved.
//

#import "invitationTableViewController.h"
#import "insTableViewCell.h"
#import "Common.h"
@interface invitationTableViewController ()


@end

@implementation invitationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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


- (void)_initTableView
{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
   
    //设置分割线颜色
    _tableView.separatorColor = [UIColor darkGrayColor];
    [self.view addSubview:_tableView];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    insTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"insTableViewCell" owner:self options:nil] lastObject];
    }
    
    PFObject *object = _objectsForShow[indexPath.row];
    cell.movie.text=object[@"movie"];
    cell.place.text=[NSString stringWithFormat:@"%@",object[@"place"]];
    cell.say.text=[NSString stringWithFormat:@"%@",object[@"say"]];
    cell.username.text=[NSString stringWithFormat:@"%@",object[@"username"]];
    cell.way.text=[NSString stringWithFormat:@"%@",object[@"way"]];
    cell.date.text = [NSString stringWithFormat:@"%@",object[@"date"]];
    cell.number.text = [NSString stringWithFormat:@"%@",object[@"number"]];
    
    PFFile *photo = object[@"photo"];
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
    return 145;
}





@end
