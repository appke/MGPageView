//
//  MGTopViewController.h
//  SMPagerTab
//
//  Created by 穆良 on 16/6/14.
//  Copyright © 2016年 MG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGTopViewController : UIViewController

/**
 *  获得单例
 */
+ (instancetype)shareInstance;
/**
 *  状态栏样式
 */
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;

/**
 *  是否隐藏状态栏
 */
@property (nonatomic, assign) BOOL statusBarHidden;

@end
