//
//  SMWebViewController.m
//  SMPagerTab
//
//  Created by ming on 15/7/4.
//  Copyright (c) 2015年 starming. All rights reserved.
//

#import "SMWebViewController.h"

@interface SMWebViewController ()
@property (nonatomic, strong) UIWebView* webView;
@end

@implementation SMWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1];
    
    // 设置额外滚动区域,如果当前是全屏
    // 如果有导航控制器，顶部需要添加额外滚动区域
    // 添加额外滚动区域   导航条高度 + 标题高度
    if (self.navigationController) {
        // 导航条上面高度
        CGFloat navBarH = 64;
        
        // 查看自己标题滚动视图设置的高度，我这里设置为44
        CGFloat titleScrollViewH = 44;
        
        self.webView.scrollView.contentInset = UIEdgeInsetsMake(navBarH + titleScrollViewH, 0, 0, 0);
    }
}

#pragma mark - setter/getter
- (void)setWebUrlString:(NSString *)webUrlString {
    NSURLRequest* webReq = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:webUrlString]];
    [self.webView loadRequest:webReq];
}

- (UIWebView *)webView {
    if (!_webView) {
        self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
        _webView.scalesPageToFit = YES;
        _webView.scrollView.directionalLockEnabled = YES;
        _webView.scrollView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_webView];
    }
    return _webView;
}

@end
