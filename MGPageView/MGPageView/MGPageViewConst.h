//
//  MGPageViewConst.h
//  MGPageView
//
//  Created by 穆良 on 16/6/17.
//  Copyright © 2016年 MG. All rights reserved.
//

#ifndef MGPageViewConst_h
#define MGPageViewConst_h

/** 导航栏高度 */
static CGFloat const MGNavBarH = 64;
/** 状态栏高度 */
static CGFloat const MGStatusBarH = 20;

/** 下划线指示器默认高度 */
static CGFloat const MGUnderLineH = 2;
/** 标题栏 默认高度 */
static CGFloat const MGTitlesViewH = 40;
/** 标题默认间距 */
static CGFloat const MGTitleMargin = 20;

/** ID */
static NSString *const ID = @"MGPageViewCell";


#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
/** 标题栏默认字体 */
#define MGTitleFont [UIFont systemFontOfSize:15]


#endif /* MGPageViewConst_h */
