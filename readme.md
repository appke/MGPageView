### PagerTab
页面滑动切换tab


###iOS9, 点击状态回到scrollView回到最顶部


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
```

实现MGTopViewController的
```
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
```方法，点击状态栏，scrollView滚动最前面去




###window的控制器决定状态栏的显示隐藏和样式
```objc 


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
```

