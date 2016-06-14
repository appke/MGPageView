//
//  MGTopViewController.m
//  SMPagerTab

////  Created by 穆良 on 16/6/14.
//  Copyright © 2016年 starming. All rights reserved.
//

#import "MGTopViewController.h"

@implementation MGTopViewController

#pragma mark - 单例
static id instance_;

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance_ = [[self alloc] init];
    });
    return instance_;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance_ = [super allocWithZone:zone];
    });
    return instance_;
}

#pragma mark - 初始化
- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor clearColor];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    NSLog(@"%s", __func__);
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self searchScrollViewInView:window];
}

// 递归搜索所有view查找当前位置合适的scrollView
- (void)searchScrollViewInView:(UIView *)view
{
    for (UIScrollView *subView in view.subviews) {
        if ([subView isKindOfClass:[UIScrollView class]] && [self isShowingInKeyWindow:subView]) {
            //开始进行滚动
            CGPoint offset = subView.contentOffset;
            offset.y = -subView.contentInset.top;
            [subView setContentOffset:offset animated:YES];
        }
        //寻找子视图的子视图
        [self searchScrollViewInView:subView];
    }
}

// 根据位置判断是否合适
- (BOOL)isShowingInKeyWindow:(UIView *)view
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    CGRect currentFrame = [keyWindow convertRect:view.frame fromView:view.superview];
    CGRect winBounds = keyWindow.bounds;
    BOOL intersects = CGRectIntersectsRect(currentFrame, winBounds);
    return !view.isHidden && view.alpha > 0.01 && view.window == keyWindow && intersects;
}


#pragma mark - 状态栏控制
- (BOOL)prefersStatusBarHidden
{
    return self.statusBarHidden;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return self.statusBarStyle;
}

#pragma mark - 重写setter方法
- (void)setStatusBarHidden:(BOOL)statusBarHidden
{
    _statusBarHidden = statusBarHidden;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle
{
    _statusBarStyle = statusBarStyle;
    [self setNeedsStatusBarAppearanceUpdate];
}

// 调用
/**
 *  [MGViewController shareInstance].statusBarStyle = UIStatusBarStyleDefault;
 *  MGStatusBarStyle(UIStatusBarStyleDefault); // 做成宏
 */
@end
