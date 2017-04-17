//
//  ZBReaderViewController.m
//  ZBQDaily
//
//  Created by zibin on 17/4/15.
//  Copyright © 2017年 zibin. All rights reserved.
//

#import "ZBReaderViewController.h"
#import <WebKit/WebKit.h>
#import "MBProgressHUD+MJ.h"


@interface ZBReaderViewController ()<UIScrollViewDelegate,WKNavigationDelegate>
{
    CGFloat _contentOffSet_Y; //WKWebView滑动后Y轴偏移量
}

/** 加载动画view*/
@property (nonatomic, strong) UIView *loadingView;
@property (nonatomic, strong) UIImageView *loadingImageView;

@property (nonatomic,weak) WKWebView *readerWebView;
//判断滑动方向
@property (nonatomic,assign) BOOL iSDownDrag;

@end

@implementation ZBReaderViewController

#pragma mark -- 懒加载
- (UIView *)loadingView{
    if (!_loadingView) {
        _loadingView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _loadingView.backgroundColor = [UIColor clearColor];
    }
    return _loadingView;
}

-(UIImageView *)loadingImageView{
    if (!_loadingImageView) {
        _loadingImageView = [[UIImageView alloc] init];
        _loadingImageView.frame = CGRectMake(0, 0, 100, 100);
        _loadingImageView.center = self.loadingView.center;
        NSMutableArray *imageMutableArray = [NSMutableArray array];
        for (int i = 0; i < 93; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"QDArticleLoading_0%d",i]];
            [imageMutableArray addObject:image];
        }
        _loadingImageView.animationImages = imageMutableArray;
        _loadingImageView.animationDuration = 3.0;
        _loadingImageView.animationRepeatCount = MAXFLOAT;
    }
    return _loadingImageView;
}


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

#pragma mark -- WKNavigationDelegate
//添加WKWebView
- (void)addWebView{
    WKWebView *readerWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, -20, ZBSCREEN_WIDTH, ZBSCREENH_HEIGHT + 20)];
    readerWebView.navigationDelegate = self;
    readerWebView.scrollView.delegate = self;
    [readerWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_HtmlUrl]]];
    _readerWebView = readerWebView;
    [self.view addSubview:readerWebView];
    [self.view addSubview:self.loadingView];
    [self.loadingView addSubview:self.loadingImageView];
}
/// WXWebView开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [self.loadingImageView startAnimating];
}
/// WXWebView加载完成时调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    //渐隐加载动画
    [UIView animateWithDuration:0.3
                     animations:^{
                         [self.loadingView setAlpha:0];
                     } completion:^(BOOL finished) {
                         [self.loadingImageView stopAnimating];
                         [self.loadingView removeFromSuperview];
                         self.loadingView = nil;
                     }];
}
/// WXWebView加载失败时调用
//- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
//    [self.loadingImageView stopAnimating];
//    NSLog(@"2222");
//    [MBProgressHUD showError:@"网络连接失败，请检查网络"];
//    [NSThread sleepForTimeInterval:1.3];
//    [self.navigationController popViewControllerAnimated:YES];
//}
/// WXWebView加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"1111");
    [self.loadingImageView stopAnimating];
    [MBProgressHUD showError:@"网络连接失败，请检查网络"];
    [NSThread sleepForTimeInterval:3];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- UIScrollViewDelegate
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
