### PageViewController
使用：
- 继承


- 参考
 - [快速集成App中顶部标题滚动条](http://www.jianshu.com/p/b45655e23a42)
 - []()



### iOS9, 点击状态回到scrollView回到最顶部
- 参考
 - [解决点击状态栏时ScrollView自动滚动到初始位置失效办法](http://www.jianshu.com/p/836cdd481982)
 - [如何让页面中有多个UIScrollView时支持statusbar点击回顶部的功能](http://www.jianshu.com/p/3a75770cffb2)


```objc
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // 添加一个window,屏幕上的scrollView滚动到最顶部
    [MGTopWindow show];
}
```

```objc
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
@end

+ (void)show
{
    topWindow_.hidden = NO;
}

+ (void)hide
{
    topWindow_.hidden = YES;
}

```

#### 点击状态栏，scrollView滚动最前面去
```objc
// MGTopViewController.m
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
```
---
### window的控制器决定状态栏的显示隐藏和样式
```objc
// MGTopViewController.m
#pragma mark - 状态栏控制
- (BOOL)prefersStatusBarHidden
{
    return self.statusBarHidden;
}

#pragma mark - 重写setter方法
- (void)setStatusBarHidden:(BOOL)statusBarHidden
{
    _statusBarHidden = statusBarHidden;
    [self setNeedsStatusBarAppearanceUpdate];
}

```
