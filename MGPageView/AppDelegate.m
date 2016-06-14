//
//  AppDelegate.m
//  SMPagerTab
//
//  Created by ming on 15/7/4.
//  Copyright (c) 2015年 starming. All rights reserved.
//

#import "AppDelegate.h"
#import "MGTopWindow.h"
#import "ViewController.h"
#import "MGTopViewController.h"

@interface AppDelegate ()
/** 窗口 */
@property (nonatomic, strong) UIWindow *topWindow;
@end

@implementation AppDelegate




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    [SMTopWindow work];
    
//    self.topWindow = [[UIWindow alloc] init];
//    self.topWindow.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20);
//    self.topWindow.windowLevel = UIWindowLevelAlert;
//    self.topWindow.hidden = NO;
//    self.topWindow.backgroundColor = [UIColor clearColor];
//    
//    self.topWindow.rootViewController = [MGTopViewController shareInstance];
//    [self.topWindow addSubview:[[UISwitch alloc] init]];
    
    
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
    // 添加一个window,屏幕上的scrollView滚动到最顶部
    [MGTopWindow show];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
