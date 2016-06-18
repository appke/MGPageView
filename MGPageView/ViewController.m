//
//  ViewController.m
//  SMPagerTab
//
//  Created by 穆良 on 15/7/4.
//  Copyright (c) 2015年 MG. All rights reserved.
//

#import "ViewController.h"
#import "UIViewAdditions.h"
#import "SMWebViewController.h"
#import "MGTableViewController.h"
#import "MGViewController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *allVC;

@property (nonatomic, strong) SMPagerTabView *segmentView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
   
    MGTableViewController *four = [[MGTableViewController alloc] init];
    four.title = @"表格表格表格表格";
    [self addChildViewController:four];
    
    
    MGViewController *five = [[MGViewController alloc] init];
    five.title = @"空的";
    [self addChildViewController:five];
    
    
    SMWebViewController *one = [[SMWebViewController alloc]initWithNibName:nil bundle:nil];
    one.title = @"我的我的我的我的";
    one.webUrlString = @"https://github.com/angmu";
    [self addChildViewController:one];
    
    SMWebViewController *two = [[SMWebViewController alloc]initWithNibName:nil bundle:nil];
    two.title = @"项目";
    two.webUrlString = @"https://github.com/angmu/MGPageView";
    [self addChildViewController:two];
    
    SMWebViewController *three = [[SMWebViewController alloc]initWithNibName:nil bundle:nil];
    three.title = @"代码代码代码代码";
    three.webUrlString = @"https://github.com/angmu/MGPageView/blob/master/MGPageView/Handler/MGTopViewController.m";
    [self addChildViewController:three];
    
    self.underLineColor = [UIColor blueColor];
    self.selColor = [UIColor magentaColor];
    
    self.isFullDisplay = YES;
}


- (void)test
{
    _allVC = [NSMutableArray array];
    SMWebViewController *one = [[SMWebViewController alloc]initWithNibName:nil bundle:nil];
    one.title = @"我的";
    one.webUrlString = @"https://github.com/angmu";
    [_allVC addObject:one];
    
    SMWebViewController *two = [[SMWebViewController alloc]initWithNibName:nil bundle:nil];
    two.title = @"项目";
    two.webUrlString = @"https://github.com/angmu/MGPageView";
    [_allVC addObject:two];
    
    SMWebViewController *three = [[SMWebViewController alloc]initWithNibName:nil bundle:nil];
    three.title = @"代码";
    three.webUrlString = @"https://github.com/angmu/MGPageView/blob/master/MGPageView/Handler/MGTopViewController.m";
    [_allVC addObject:three];
    
    self.segmentView.delegate = self;
    //可自定义背景色和tab button的文字颜色等
    //开始构建UI
    [_segmentView buildUI];
    //起始选择一个tab
    [_segmentView selectTabWithIndex:1 animate:NO];
    //显示红点，点击消失
    [_segmentView showRedDotWithIndex:0];
}

#pragma mark - DBPagerTabView Delegate
- (NSUInteger)numberOfPagers:(SMPagerTabView *)view {
    return [_allVC count];
}
- (UIViewController *)pagerViewOfPagers:(SMPagerTabView *)view indexOfPagers:(NSUInteger)number {
    return _allVC[number];
}

- (void)whenSelectOnPager:(NSUInteger)number {
    NSLog(@"页面 %lu",(unsigned long)number);
}

#pragma mark - setter/getter
- (SMPagerTabView *)segmentView {
    if (!_segmentView) {
        self.segmentView = [[SMPagerTabView alloc]initWithFrame:CGRectMake(0, 22, SCREEN_WIDTH, SCREEN_HEIGHT - 22)];
        
        [self.view addSubview:_segmentView];
    }
    return _segmentView;

}

@end
