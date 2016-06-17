//
//  MGPageTitleLabel.m
//  MGPageView
//
//  Created by 穆良 on 16/6/17.
//  Copyright © 2016年 MG. All rights reserved.
//

#import "MGPageTitleLabel.h"

@implementation MGPageTitleLabel


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        self.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}


@end
