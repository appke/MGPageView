//
//  MGPageViewController.m
//  MGPageView
//
//  Created by 穆良 on 16/6/17.
//  Copyright © 2016年 MG. All rights reserved.
//

#import "MGPageViewController.h"
#import "MGPageViewConst.h"
#import "MGPageFlowLayout.h"
#import "MGPageTitleLabel.h"
#import "UIViewAdditions.h"

@interface MGPageViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

/** 红^指示器 */
@property (nonatomic, weak) UIView *underLine;

/** 顶部所有标签栏 */
@property (nonatomic, weak) UIScrollView *titlesView;

/** 底部的内容collectionView */
@property (nonatomic, weak) UICollectionView *contentCollectionView;

/** 所有内容=滚动内容+标题栏 */
@property (nonatomic, weak) UIView *contentView;

/** 当前选中的按钮 */
@property (nonatomic, weak) MGPageTitleLabel *selectedLabel;


/* 是否初始化,却换时 */
@property (nonatomic, assign) BOOL isInitial;
/** 标题间距 */
@property (nonatomic, assign) CGFloat titleMargin;

/** 所有标题宽度数组 */
@property (nonatomic, strong) NSMutableArray *titleWidths;
/** 所有标题数组 */
@property (nonatomic, strong) NSMutableArray *titleLabels;

@end

@implementation MGPageViewController

#pragma mark - 初始化方法
- (instancetype)init
{
    if (self = [super init]) {
        [self initial];
    }
    return self;
}

- (void)awakeFromNib
{
    [self initial];
}

- (void)initial
{
    // 不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 这个bug调了2小时，要调用这个方法
}

#pragma mark - 属性懒加载
- (UIFont *)titleFont
{
    if (_titleFont == nil) {
        _titleFont = MGTitleFont;
    }
    return _titleFont;
}

- (CGFloat)titleHeight
{
    if (_titleHeight == 0) {
        _titleHeight = MGTitlesViewH;
    }
    return _titleHeight;
}

- (NSMutableArray *)titleWidths
{
    if (_titleWidths == nil) {
        _titleWidths = [NSMutableArray array];
    }
    return _titleWidths;
}

- (NSMutableArray *)titleLabels
{
    if (!_titleLabels) {
        _titleLabels = [NSMutableArray array];
    }
    return _titleLabels;
}

//- (void)setIsFullDisplay:(BOOL)isFullDisplay
//{
//    _isFullDisplay = isFullDisplay;
//}

#pragma mark - 控件懒加载
// 标题滚动视图
- (UIScrollView *)titlesView
{
    if (_titlesView == nil) {
        
        UIScrollView *titlesView = [[UIScrollView alloc] init];
        _titlesView = titlesView;
        titlesView.backgroundColor = _titleViewColor ? _titleViewColor : [UIColor colorWithWhite:1 alpha:0.8];
        titlesView.showsHorizontalScrollIndicator = NO;
        [self.contentView addSubview:titlesView];
//        [self.view addSubview:titlesView];
    }
    return _titlesView;
}

// 滚动内容视图
- (UICollectionView *)contentCollectionView
{
    if (_contentCollectionView == nil) {
        // 创建布局
        MGPageFlowLayout *layout = [[MGPageFlowLayout alloc] init];
        
        UICollectionView *contentCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout]; // Zero？？
        _contentCollectionView = contentCollectionView;
        
        // 设置滚动内容属性
        contentCollectionView.pagingEnabled = YES;
        contentCollectionView.bounces = NO;
        contentCollectionView.showsHorizontalScrollIndicator = NO;
        contentCollectionView.delegate = self;
        contentCollectionView.dataSource = self;
        
        [self.contentView insertSubview:contentCollectionView belowSubview:self.titlesView];
//        [self.view insertSubview:contentCollectionView belowSubview:self.titlesView];
        
    }
    
    return _contentCollectionView;
}

// 整个内容视图
- (UIView *)contentView
{
    if (_contentView == nil) {
        UIView *contentView = [[UIView alloc] init];
        _contentView = contentView;
        [self.view addSubview:contentView];
    }
    return _contentView;
}

// 懒加载不设置frame在生命周期中设置
#pragma mark - 控制器生命周期方法
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    // 设置整个内容尺寸
    CGFloat contentW = SCREEN_WIDTH;
    // 设置整个内容的尺寸
    if (self.contentView.frame.size.height == 0) {
        // 没有设置内容尺寸，才需要设置内容尺寸
        self.contentView.frame = CGRectMake(0, 0, contentW, SCREEN_HEIGHT);
    }
    
    
    // 设置标题视图尺寸
    CGFloat titlesViewY = self.navigationController ? MGNavBarH : MGStatusBarH;
    CGFloat titlesViewH = _titleHeight ? _titleHeight : MGTitlesViewH;
    self.titlesView.frame = CGRectMake(0, titlesViewY, contentW, titlesViewH);
    
    // 设置滚动内容尺寸
    CGFloat collectionViewY = CGRectGetMaxY(self.titlesView.frame);
    self.contentCollectionView.frame = _isFullDisplay ? CGRectMake(0, 0, contentW, SCREEN_HEIGHT) : CGRectMake(0, collectionViewY, contentW, SCREEN_HEIGHT - collectionViewY);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    if (_isInitial == NO) {
        _isInitial = YES;
        
        // 注册cell
        [self.contentCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
        
        // 初始化
        //???
        
        // 没有子控制器,不需要设置标题
        if (self.childViewControllers.count == 0) return;
        
        // 设置标题宽度
        [self setupTitleWidth];
        
        // 设置所有标题
        [self setupAllTitle];
    }
}

#pragma mark - 设置标题方法
// 计算所有标题宽度
- (void)setupTitleWidth
{
    NSInteger count = self.childViewControllers.count;
    NSArray *titles = [self.childViewControllers valueForKey:@"title"];
    
    CGFloat totalWidth = 0;
    for (NSString *title in titles) {
        
        if ([title isKindOfClass:[NSNull class]]) {
            // 抛异常
            NSException *excp = [NSException exceptionWithName:@"MGPageViewControllerException" reason:@"没有设置Controller.title属性，应该把子标题保存到对应子控制器中" userInfo:nil];
            [excp raise];
        }
        
        CGRect titleBounds = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.titleFont} context:nil];
        
        CGFloat width = titleBounds.size.width;
        [self.titleWidths addObject:@(width)];
        totalWidth += width;
    }
    
    // 判断是否能占据整个屏幕
    if (totalWidth > SCREEN_WIDTH) {
        
        _titleMargin = MGTitleMargin;
        self.titlesView.contentInset = UIEdgeInsetsMake(0, 0, 0, MGTitleMargin);
        return;
    }
    
    CGFloat titleMargin = (SCREEN_WIDTH - totalWidth) / (count + 1);
    _titleMargin = titleMargin < MGTitleMargin ? MGTitleMargin : titleMargin;
    self.titlesView.contentInset = UIEdgeInsetsMake(0, 0, 0, _titleMargin);
    
    // 为什么要增加 额外的滚动区域
}

// 设置所有标题
- (void)setupAllTitle
{
    NSInteger count = self.childViewControllers.count;
    
    // 添加所有的标题
    CGFloat labelW = 0;
    CGFloat labelH = self.titleHeight;
    CGFloat labelX = 0;
    CGFloat labelY = 0;
    
    for (int i = 0; i < count; i++) {
        
        UIViewController *vc = self.childViewControllers[i];
        
        MGPageTitleLabel *label = [[MGPageTitleLabel alloc] init];
        // 设置label属性
        label.tag = i;
        label.text = vc.title;
        label.font = self.titleFont;
        label.textColor = [UIColor redColor];
        
        // label的位置
        labelW = [self.titleWidths[i] floatValue];
        MGPageTitleLabel *lastLabel = [self.titleLabels lastObject];
        labelX = _titleMargin + CGRectGetMaxX(lastLabel.frame);
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        
        // 监听标题点击
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleClick:)];
        [label addGestureRecognizer:tap];
        
        // 把标题保存到数组中
        [self.titleLabels addObject:label];
        [self.titlesView addSubview:label];
        
        // 第一个label选中
        if (0 == i) {
            [self titleClick:tap];
        }
    }
    
    // 设置标题视图 内容范围
    MGPageTitleLabel *lastLabel = [self.titleLabels lastObject];
    self.titlesView.contentSize = CGSizeMake(CGRectGetMaxX(lastLabel.frame), 0);
    
    // 设置滚动视图 内容范围
    self.contentCollectionView.contentSize = CGSizeMake(SCREEN_WIDTH * count, 0);

}

#pragma mark - 标题点击处理
- (void)titleClick:(UITapGestureRecognizer *)tap
{
    
//    MGPageTitleLabel *label = (MGPageTitleLabel *)tap.view;
    
}



#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.childViewControllers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [self.contentCollectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    
    // 移除之前的子控件
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    // 添加控制器
    UIViewController *vc = self.childViewControllers[indexPath.item];
    vc.view.frame = CGRectMake(0, 0, self.contentCollectionView.frame.size.width, self.contentCollectionView.frame.size.height);
    [cell.contentView addSubview:vc.view];

    return cell;
}


@end
