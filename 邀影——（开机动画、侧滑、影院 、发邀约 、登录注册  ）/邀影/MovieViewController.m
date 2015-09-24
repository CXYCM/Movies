//
//  MovieViewController.m
//  邀影
//
//  Created by ZY on 15/9/24.
//  Copyright (c) 2015年 罗凌云. All rights reserved.
//
#define MJImageCount 5
#define MJInterval
#import "MovieViewController.h"
#import "DetailViewController.h"

@interface MovieViewController ()<UIScrollViewDelegate>

@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self requestData];
    CGFloat imageW = self.scrollView.frame.size.width;
    CGFloat imageH = self.scrollView.frame.size.height;
    CGFloat imageY = 0;
    
    
    //1.添加五张图片到scrollview中
    for (int i =0; i<MJImageCount; i++ ) {
        UIImageView *imageView = [[UIImageView alloc] init];
        
        //设置frame
        CGFloat imageX = i * imageW;
        imageView.frame = CGRectMake(imageX,imageY,imageW,imageH);
        
        //设置图片
        NSString *name = [NSString stringWithFormat:@"img_0%d",i + 1];
        imageView.image = [UIImage imageNamed:name];
        
        [self.scrollView addSubview:imageView];
        
    }
    
    //2.设置内容尺寸
    CGFloat contentW  = MJImageCount * imageW;
    self.scrollView.contentSize =CGSizeMake(contentW,0);
    
    //3.隐藏水平滚动条
    self.scrollView.showsHorizontalScrollIndicator   = NO;
    //4.分页
    self.scrollView.pagingEnabled = YES;
    //self.scrollView.delegate = self;
    //5.设置pageControl的总页数
    self.pageControl.numberOfPages = MJImageCount;
    //6.添加定时器
    [self addTimer];
    
    
}
-(void)addTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
}
-(void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
}
-(void)nextImage
{
    //增加pagecontrol的页码
    
    if (self.pageControl.currentPage == MJImageCount - 1) {
        self.pageControl.currentPage = 0;
    }else{
        self.pageControl.currentPage ++;
    }
    //2.计算scrollview滚动的位置
    CGFloat offsetX = self.pageControl.currentPage *self.scrollView.frame.size.width;//图片滚动
    CGPoint offset = CGPointMake(offsetX , 0);
    [self.scrollView setContentOffset:offset animated:YES];
}
#pragma mark - 代理方法
//当scrollview正在滚动就会调用
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //根据scrollview的滚动位置决定pagecontrol显示第几页
    CGFloat scrollW = scrollView.frame.size.width;
    int page = (scrollView.contentOffset.x + scrollW * 0.5) / scrollW;
    self.pageControl.currentPage = page;
    
}
//开始拖拽时调用
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //停止定时器
    [self removeTimer];
    
    
}
//停止拖拽时候调用
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //开启定时器
    [self addTimer];
}

- (void)requestData {
    // Dispose of any resources that can be recreated.
    
    PFQuery *query = [PFQuery queryWithClassName:@"Movie"];
    //[query selectKeys:@[@"name"]];
    
    UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *returnedObjects, NSError *error) {
        [aiv stopAnimating];//指示器停止旋转
        if (!error) {
            _objectsForShow = returnedObjects;
            NSLog(@"%@", _objectsForShow);
            [_tableView reloadData];
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _objectsForShow.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    PFObject *object = [_objectsForShow objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ ", object[@"name"]];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"评分：%@", object[@"grade"]];
    
    return cell;
}
//-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    scrollView
//}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"Item"]) {
        //获得当前tableview行的数据
        PFObject *object = [_objectsForShow objectAtIndex:[_tableView indexPathForSelectedRow].row];
        DetailViewController *itemVC = segue.destinationViewController;
        itemVC.item = object;
        itemVC.hidesBottomBarWhenPushed = YES;//隐藏切换按钮
    }
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

@end
