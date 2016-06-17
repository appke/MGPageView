//
//  MGPageViewController.h
//  MGPageView
//
//  Created by 穆良 on 16/6/17.
//  Copyright © 2016年 MG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGPageViewController : UIViewController


/**
*  内容是否需要全屏展示
*  YES : 全屏,内容占据整个屏幕,会有穿透导航栏效果,需要手动设置tableView额外滚动区域
*  NO  : 内容从标题下展示
*/
@property (nonatomic, assign) BOOL isFullDisplay;


/** 标题字体 */
@property (nonatomic, strong) UIFont *titleFont;
/** 标题高度 */
@property (nonatomic, assign) CGFloat titleHeight;


@end
