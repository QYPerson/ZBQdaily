//
//  ZBDropDownRefreshHeader.m
//  ZBQDaily
//
//  Created by zibin on 17/2/13.
//  Copyright © 2017年 zibin. All rights reserved.
//

#import "ZBDropDownRefreshHeader.h"

@interface ZBDropDownRefreshHeader ()
@property (nonatomic,weak) UIImageView *backImage;


@end


@implementation ZBDropDownRefreshHeader
- (void)prepare{
    [super prepare];
    // 设置控件的高度
    self.mj_h = 100;

    //添加背景图
    UIImageView *backImage = [[UIImageView alloc] init];
    backImage.image = [UIImage imageNamed:@"reveal_refresh_foreground"];
    _backImage = backImage;
    [self addSubview:backImage];
    
}


#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    self.backImage.frame = self.bounds;
    
}
#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}


#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
     
            break;
        case MJRefreshStatePulling:
       
            break;
        case MJRefreshStateRefreshing:

            break;
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
    // 1.0 0.5 0.0
    // 0.5 0.0 0.5
    CGFloat red = 1.0 - pullingPercent * 0.5;
    CGFloat green = 0.5 - 0.5 * pullingPercent;
    CGFloat blue = 0.5 * pullingPercent;
}
@end

















