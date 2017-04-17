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
@property (nonatomic,strong) WKWebView *readerWebView;

@end

@implementation ZBReaderViewController

#pragma mark -- 视图生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self addWebView];
}

-(void)loadView{
    [super viewDidLoad];
    [self addWebView];


}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    //当控制器pop时 把readerWebView的代理清空 防止项目崩溃
    _readerWebView.scrollView.delegate = nil;
}

-(void)setHtmlUrl:(NSString *)HtmlUrl{
    _HtmlUrl = HtmlUrl;
    [_readerWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://app3.qdaily.com/app3/articles/39855.html"]]];
    NSLog(@"%@",HtmlUrl);

}

#pragma mark -- WKWebView
//添加WKWebView
- (void)addWebView{
    WKWebView *readerWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, -20, ZBSCREEN_WIDTH, ZBSCREENH_HEIGHT)];
    _readerWebView = readerWebView;
    readerWebView.navigationDelegate = self;
    readerWebView.scrollView.delegate = self;
    //利用KVC替换系统自带的View
    [self.view addSubview:readerWebView];
    [_readerWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://app3.qdaily.com/app3/articles/39855.html"]]];
}


#pragma mark -- Other
//隐藏导航栏
- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}
//修改状态栏颜色
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
@end
