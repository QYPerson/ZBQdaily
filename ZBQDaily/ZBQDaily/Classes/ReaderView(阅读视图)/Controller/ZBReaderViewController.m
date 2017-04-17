//
//  ZBReaderViewController.m
//  ZBQDaily
//
//  Created by zibin on 17/4/15.
//  Copyright © 2017年 zibin. All rights reserved.
//

#import "ZBReaderViewController.h"
#import <WebKit/WebKit.h>



@interface ZBReaderViewController ()<UIScrollViewDelegate,WKNavigationDelegate>
{
    CGFloat _contentOffSet_Y; //WKWebView滑动后Y轴偏移量
}
@property (nonatomic,weak) WKWebView *readerWebView;
//判断滑动方向
@property (nonatomic,assign) BOOL iSDownDrag;

@end

@implementation ZBReaderViewController

#pragma mark -- 视图生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //当控制器pop时 把readerWebView的代理清空 防止项目崩溃
    _readerWebView.scrollView.delegate = nil;
}

-(void)setHtmlUrl:(NSString *)HtmlUrl{
    _HtmlUrl = HtmlUrl;
    [self addWebView];
}

#pragma mark -- WKWebView
//添加WKWebView
- (void)addWebView{
    WKWebView *readerWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, -20, ZBSCREEN_WIDTH, ZBSCREENH_HEIGHT + 20)];
    readerWebView.navigationDelegate = self;
    readerWebView.scrollView.delegate = self;
    [readerWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_HtmlUrl]]];
    _readerWebView = readerWebView;
    [self.view addSubview:readerWebView];
}
#pragma mark -- UIScrollViewDelegate
///// 停止滚动时调用
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    NSLog(@"%f", scrollView.contentOffset.y);
//}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //判断滑动方向 正为向下滑动 负为向上滑动
    if (scrollView.contentOffset.y > _contentOffSet_Y) {
        _iSDownDrag = YES;
    } else{
        _iSDownDrag = NO;
    };
    //保存偏移量
    _contentOffSet_Y = scrollView.contentOffset.y;
    //如果偏移到这个范围 改变状态栏颜色
    if (scrollView.contentOffset.y >= 230 && scrollView.contentOffset.y <= 260 ) {
        [self setNeedsStatusBarAppearanceUpdate];
    }
    NSLog(@"%f",scrollView.contentOffset.y);

}
#pragma mark -- Other
//隐藏导航栏
- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}
//修改状态栏颜色
-(UIStatusBarStyle)preferredStatusBarStyle{
    //判断方向
    if (_iSDownDrag) {
        return UIStatusBarStyleDefault;
    }else{
        return  UIStatusBarStyleLightContent;
    }
}
@end
