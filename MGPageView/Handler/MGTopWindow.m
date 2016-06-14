//
//  SMTopWindow.m
//  WeiboOffline
//
//  Created by DaiMing on 15/9/6.
//  Copyright (c) 2015年 starming. All rights reserved.
//

#import "MGTopWindow.h"
#import <UIKit/UIKit.h>
#import "MGTopViewController.h"

@implementation MGTopWindow
// 全局对象
static UIWindow *topWindow_;

+ (void)initialize {
    
    topWindow_ = [[UIWindow alloc] init];
    topWindow_.frame = [UIApplication sharedApplication].statusBarFrame;
    topWindow_.windowLevel = UIWindowLevelAlert;
    topWindow_.backgroundColor = [UIColor clearColor];
    
    MGTopViewController *rootVc = [MGTopViewController shareInstance];
    topWindow_.rootViewController = rootVc;
}

+ (void)show
{
    topWindow_.hidden = NO;
}

+ (void)hide
{
    topWindow_.hidden = YES;
}
@end
