//
//  AppDelegate.m
//  邀影
//
//  Created by 罗凌云 on 15/9/18.
//  Copyright (c) 2015年 罗凌云. All rights reserved.
//

#import "AppDelegate.h"
//#import "ViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
//- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    NSLog(@"GO");
////    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
////    ViewController *viewController = [[ViewController alloc]init];  //初始化
////    self.window.rootViewController = viewController; //为window设置rootviewcontroller
////    [self.window makeKeyAndVisible]; //呈现window内容
//    // Override point for customization after application launch.
//    return YES;
//}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [Parse setApplicationId:@"K1iquDzCmH0S6FmlD2j1NDVYn1lWjo3xn0vlpXQa" clientKey:@"uZxHsYcDQxC6oZVXbnFue4Vcl9b40g4BDWy6SqQe"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
       [self poHompage];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(void)poHompage
{   //跳转到Tab 界面
    NSLog(@"IN");
    MainTabViewController    *tabVC = [Utilities getStoryboardInstanceByIdentity:@"Tab"];//获得界面
    UINavigationController* naviVC = [[UINavigationController alloc] initWithRootViewController:tabVC];//创建一个导航控制器，隐藏导航条，将tabVC放进
    naviVC.navigationBarHidden = YES;//隐藏导航条
    //
    //    初始化侧滑的容器，并将Tab放进TopV页面和中间页面
    _ViewController = [ECSlidingViewController  slidingWithTopViewController:naviVC];
    //
    //   滑动默认的动画时间
    //    _ViewController.defaultTransitionDuration = 0.25;
    _ViewController.delegate = self;
    //   给TopV增加手势（触摸Tapping 、拖拽Panning ）
    _ViewController.topViewAnchoredGesture = ECSlidingViewControllerAnchoredGestureTapping | ECSlidingViewControllerAnchoredGesturePanning;
    //   给naviVC添加手势
    [naviVC.view addGestureRecognizer:self.ViewController.panGesture];
    
    LeftViewController *leftVC = [Utilities getStoryboardInstanceByIdentity:@"Left"];
    //    设置 左划视图
    _ViewController.underLeftViewController = leftVC;
    //    设置视图划到的位置（当划出左侧菜单时，中间页面左边到屏幕右边的距离1/4）
    _ViewController.anchorRightPeekAmount = UI_SCREEN_W / 4;//    当划出右侧页面时，中间页面右边到屏幕左边的距离anchorLeftPeekAmount
    
    //   建立 通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(leftSwitchAction) name:@"leftSwitch" object:nil];
    //   建立激活手势通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enablePanGesOnSliding) name:@"enablePanGes" object:nil];
    //    建立关闭手势通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disablePanGesOnSliding) name:@"disablePanGes" object:nil];
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = _ViewController; //根目录设置为_ViewController这个容器
    [self.window makeKeyAndVisible]; //呈现window内容
}
//重新设置状态（如果在左策触发这个方法就会回正，在中间时就会划到左边）
- (void)leftSwitchAction {
    if (_ViewController.currentTopViewPosition == ECSlidingViewControllerTopViewPositionAnchoredRight) {
        [_ViewController resetTopViewAnimated:YES];
    } else {
        [_ViewController anchorTopViewToRightAnimated:YES];
    }
}
//激活手势
- (void)enablePanGesOnSliding {
    _ViewController.panGesture.enabled = YES;
}
//关闭手势
- (void)disablePanGesOnSliding {
    _ViewController.panGesture.enabled = NO;
}


#pragma mark - ECSlidingViewControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)slidingViewController:(ECSlidingViewController *)slidingViewController animationControllerForOperation:(ECSlidingViewControllerOperation)operation topViewController:(UIViewController *)topViewController {
    //   页与页之间的切换 ，获取当前的操作
    _operation = operation;
    return self;
}

- (id<ECSlidingViewControllerLayout>)slidingViewController:(ECSlidingViewController *)slidingViewController layoutControllerForTopViewPosition:(ECSlidingViewControllerTopViewPosition)topViewPosition {
    return self;
}
#pragma mark - ECSlidingViewControllerLayout

- (CGRect)slidingViewController:(ECSlidingViewController *)slidingViewController frameForViewController:(UIViewController *)viewController topViewPosition:(ECSlidingViewControllerTopViewPosition)topViewPosition {
    //当移动之后的位置
    if (topViewPosition == ECSlidingViewControllerTopViewPositionAnchoredRight && viewController == slidingViewController.topViewController) {//移动到右边之后变为原有的viewController
        return [self topViewAnchoredRightFrame:slidingViewController];
    } else {
        return CGRectInfinite;
    }
}
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;//动画时间0.25
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    //页面与页面间的转换
    UIViewController *topViewController = [transitionContext viewControllerForKey:ECTransitionContextTopViewControllerKey];
    UIViewController *underLeftViewController  = [transitionContext viewControllerForKey:ECTransitionContextUnderLeftControllerKey];
    UIView *containerView = [transitionContext containerView];
    //容器
    UIView *topView = topViewController.view;
    //中间页面视图
    topView.frame = containerView.bounds;
    //
    underLeftViewController.view.layer.transform = CATransform3DIdentity;
    //
    if (_operation == ECSlidingViewControllerOperationAnchorRight) {
        [containerView insertSubview:underLeftViewController.view belowSubview:topView];
        //
        
        [self topViewStartingStateLeft:topView containerFrame:containerView.bounds];
        [self underLeftViewStartingState:underLeftViewController.view containerFrame:containerView.bounds];
        
        NSTimeInterval duration = [self transitionDuration:transitionContext];
        [UIView animateWithDuration:duration animations:^{
            [self underLeftViewEndState:underLeftViewController.view];
            [self topViewAnchorRightEndState:topView anchoredFrame:[transitionContext finalFrameForViewController:topViewController]];
        } completion:^(BOOL finished) {
            if ([transitionContext transitionWasCancelled]) {
                underLeftViewController.view.frame = [transitionContext finalFrameForViewController:underLeftViewController];
                underLeftViewController.view.alpha = 1;
                [self topViewStartingStateLeft:topView containerFrame:containerView.bounds];
            }
            [transitionContext completeTransition:finished];
        }];
    } else if (_operation == ECSlidingViewControllerOperationResetFromRight) {
        [self topViewAnchorRightEndState:topView anchoredFrame:[transitionContext initialFrameForViewController:topViewController]];
        [self underLeftViewEndState:underLeftViewController.view];
        
        NSTimeInterval duration = [self transitionDuration:transitionContext];
        [UIView animateWithDuration:duration animations:^{
            [self underLeftViewStartingState:underLeftViewController.view containerFrame:containerView.bounds];
            [self topViewStartingStateLeft:topView containerFrame:containerView.bounds];
        } completion:^(BOOL finished) {
            if ([transitionContext transitionWasCancelled]) {
                [self underLeftViewEndState:underLeftViewController.view];
                [self topViewAnchorRightEndState:topView anchoredFrame:[transitionContext initialFrameForViewController:topViewController]];
            } else {
                underLeftViewController.view.alpha = 1;
                underLeftViewController.view.layer.transform = CATransform3DIdentity;
                [underLeftViewController.view removeFromSuperview];
            }
            [transitionContext completeTransition:finished];
        }];
    }
}

#pragma mark - Private
//当你的位置变化时，它之后的位置  缩小
- (CGRect)topViewAnchoredRightFrame:(ECSlidingViewController *)slidingViewController {
    CGRect frame = slidingViewController.view.bounds;
    
    frame.origin.x = slidingViewController.anchorRightRevealAmount;
    frame.size.width = frame.size.width * 0.75;
    frame.size.height = frame.size.height * 0.75;
    frame.origin.y = (slidingViewController.view.bounds.size.height - frame.size.height) / 2;
    
    return frame;
}
-(void)topViewStartingStateLeft:(UIView *)topView containerFrame:(CGRect)containerFrame {
    topView.layer.transform = CATransform3DIdentity;
    topView.layer.position = CGPointMake(containerFrame.size.width / 2, containerFrame.size.height / 2);
}

- (void)underLeftViewStartingState:(UIView *)underLeftView containerFrame:(CGRect)containerFrame {
    underLeftView.alpha = 0;
    //透明，初态
    underLeftView.frame = containerFrame;
    //
    underLeftView.layer.transform = CATransform3DMakeScale(1.25, 1.25, 1);
    //起始状态
}

- (void)underLeftViewEndState:(UIView *)underLeftView {
    underLeftView.alpha = 1;
    //完全不透明，终态
    underLeftView.layer.transform = CATransform3DIdentity;
    
}

- (void)topViewAnchorRightEndState:(UIView *)topView anchoredFrame:(CGRect)anchoredFrame {
    topView.layer.transform = CATransform3DMakeScale(0.75, 0.75, 1);
    topView.frame = anchoredFrame;
    topView.layer.position  = CGPointMake(anchoredFrame.origin.x + ((topView.layer.bounds.size.width * 0.75) / 2), topView.layer.position.y);
}

@end
