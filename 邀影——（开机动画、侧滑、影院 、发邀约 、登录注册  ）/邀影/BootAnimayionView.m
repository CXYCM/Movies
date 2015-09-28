//
//  BootAnimayionView.m
//  邀影
//
//  Created by ZY on 15/9/22.
//  Copyright (c) 2015年 罗凌云. All rights reserved.
//

#import "BootAnimayionView.h"
#import "Common.h"
@implementation BootAnimayionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //固定视图的大小
        self.width = kScreenWidth;
        self.height = kScreenHeight;
        
        [self _initViews];
    }
    return self;
}

//初始化子视图
- (void)_initViews
{
    //当前文件路径
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/firstSetUp.plist"];
    //    NSLog(@"%@",path);
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSLog(@"%@", dic);
    //存数据
    //    [[[NSUserDefaults standardUserDefaults] setObject:(id) forKey:<#(NSString *)#>]
    //    [[NSUserDefaults standardUserDefaults] setInteger:<#(NSInteger)#> forKey:<#(NSString *)#>];
    //取数据
    //    [[NSUserDefaults standardUserDefaults] objectForKey:<#(NSString *)#>];
    //    [[NSUserDefaults standardUserDefaults] integerForKey:<#(NSString *)#>]
    
    
    if (dic == nil) {
        
        dic = @{@"first": @YES};
        [dic writeToFile:path atomically:YES];
        
        //第一次安装的开机动画
        [self _firstAnimationView];
    }else
    {
        //普通的开机动画
        [self _defautAnimationView];
    }
}

//第一次安装的开机动画
- (void)_firstAnimationView
{
    //设置当前视图的背景
    self.backgroundColor = [UIColor clearColor];
    
    //----------------创建滑动视图----------------
    //存放图片名字的数组
    NSArray *imageNames = @[@"guide1.png",@"guide2.png",@"guide3.png",@"guide4.png",@"guide5.png"];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    scrollView.delegate = self;
    //取消滑动条
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.bounces = NO;
    
    //内容视图的大小
    scrollView.contentSize = CGSizeMake((imageNames.count +1)*kScreenWidth, kScreenHeight);
    //创建视图中的图片
    for (int i = 0; i < imageNames.count; i++) {
        //创建图片视图
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*kScreenWidth, 0, kScreenWidth, kScreenHeight)];
        imageView.image = [UIImage imageNamed:imageNames[i]];
        [scrollView addSubview:imageView];
        
    }
    [self addSubview:scrollView];
    
    
    //------------------创建页码------------------
    NSArray *pageImageNames = @[@"guideProgress1.png",@"guideProgress2.png",@"guideProgress3.png",@"guideProgress4.png",@"guideProgress5.png"];
    _pageImages = [[NSMutableArray alloc] init];
    for (NSString *imageName in pageImageNames) {
        //创建图片
        UIImage *image = [UIImage imageNamed:imageName];
        [_pageImages addObject:image];
    }
    
    //创建页码视图
    _pageImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - 86.5)/2, kScreenHeight - 13 - 30, 86.5, 13)];
    _pageImageView.image = _pageImages[0];
    [self addSubview:_pageImageView];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //根据偏移量算出滑动页面索引
    NSInteger pageIndex = scrollView.contentOffset.x/kScreenWidth;
    
    //改变页面控件
    if (pageIndex < _pageImages.count) {
        _pageImageView.image = _pageImages[pageIndex];
    }else
    {
        //到达最后一页,（透明页面）
        [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:.5];
    }
    
    if (scrollView.contentOffset.x > scrollView.contentSize.width - kScreenWidth *2) {
        //页码控件跟着滑动视图走动
        float cWidth = scrollView.contentOffset.x - (scrollView.contentSize.width - kScreenWidth *2);
        
        //设置页码控件的横坐标
        float x = (kScreenWidth - 86.5)/2;
        
        _pageImageView.left = x - cWidth;
    }
}

//普通的开机动画
- (void)_defautAnimationView
{
    self.backgroundColor = [UIColor whiteColor];
    //创建开机动画的小视图
    //图片的宽度
    float imageWidth = kScreenWidth/4;
    //图片的高度
    float imageHeight = kScreenWidth/4;
    //图片的列数
    int lineNum = 4;
    //图片的行数
    int rowNum = kScreenHeight/(kScreenWidth/4);
    
    //图片的个数
    imageCount = lineNum * rowNum;
    NSLog(@"%ld", (long)imageCount);
    //初始化图片的坐标（竖直居中)
    float x = 0, y = (kScreenHeight-(float)(imageHeight*rowNum))/2;
    //初始化数组
    _imageViews = [[NSMutableArray alloc] init];
    for (int i = 0; i < imageCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, imageWidth, imageHeight)];
        imageView.alpha = 0;
        //       通过图片名来调用图片  1++
        NSString *imageName = [NSString stringWithFormat:@"%d.png",i+1];
        imageView.image = [UIImage imageNamed:imageName];
        [self addSubview:imageView];
        [_imageViews addObject:imageView];
        
        
        //修改坐标，使x,y变成下一个图片的坐标
        if (i < lineNum - 1) {
            x += imageWidth;
        }else if (i < (lineNum - 1) + (rowNum - 1))
        {
            y += imageHeight;
        }else if (i < (lineNum - 1)*2 + (rowNum - 1))
        {
            x -= imageWidth;
        }else if (i < (lineNum - 1)*2 + (rowNum - 1)*2 - 1)
        {
            y -= imageHeight;
        }else if (i < (lineNum - 1)*3 + (rowNum - 1)*2 - 2)
        {
            x += imageWidth;
        }else if (i < (lineNum - 1)*3 + (rowNum - 1)*3 - 4)
        {
            y += imageHeight;
        }else if (i < (lineNum - 1)*4 + (rowNum - 1)*3 - 6)
        {
            x -= imageWidth;
        }else
        {
            y -= imageHeight;
        }
    }
    
    //开始显示动画
    [self showAnimationImageView];
    
}


//开始显示动画
- (void)showAnimationImageView
{
    //显示的动画
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.18];
    UIImageView *imageView = _imageViews[_imageIndex];
    imageView.alpha = 1;
    [UIView commitAnimations];
    
    //改变动画索引
    _imageIndex++;
    if (_imageIndex < imageCount) {
        //递归调用
        [self performSelector:@selector(showAnimationImageView) withObject:nil afterDelay:.1];
    }else
    {
        //从父视图中移除
        [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1];
    }
}

@end
