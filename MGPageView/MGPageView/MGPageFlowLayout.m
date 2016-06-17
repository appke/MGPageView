//
//  MGPageViewFlowLayout.m
//  MGPageView
//
//  Created by 穆良 on 16/6/17.
//  Copyright © 2016年 MG. All rights reserved.
//
#import "MGPageFlowLayout.h"

@implementation MGPageFlowLayout

- (void)prepareLayout
{
    [super prepareLayout];
    
    // 自定义流水布局
    self.minimumLineSpacing = 0; // item之间距离
    self.minimumInteritemSpacing = 0; // section之间距离
    
    if (self.collectionView.bounds.size.height) {
        self.itemSize = self.collectionView.bounds.size;
    }

    self.sectionInset = UIEdgeInsetsZero;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}

@end
