//
//  AppDelegate.h
//  邀影
//
//  Created by 罗凌云 on 15/9/18.
//  Copyright (c) 2015年 罗凌云. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "BootAnimayionView.h"
#import "LeftViewController.h"
#import "Constants.h"
#import "ECSlidingAnimationController.h"
#import "Utilities.h"
#import "MainTabViewController.h"
#import "Utilities.h"
#import "ECSlidingAnimationController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,UIViewControllerAnimatedTransitioning,ECSlidingViewControllerDelegate,ECSlidingViewControllerLayout>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) ECSlidingViewController *ViewController;
@property (assign, nonatomic) ECSlidingViewControllerOperation operation;
//- (void)saveContext;
//- (NSURL *)applicationDocumentsDirectory;

@end

