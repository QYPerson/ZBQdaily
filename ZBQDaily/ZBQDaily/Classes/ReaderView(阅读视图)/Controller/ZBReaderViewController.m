//
//  ZBReaderViewController.m
//  ZBQDaily
//
//  Created by zibin on 17/4/15.
//  Copyright © 2017年 zibin. All rights reserved.
//

#import "ZBReaderViewController.h"
//系统库
#import <WebKit/WebKit.h>
//第三方
#import "MBProgressHUD+MJ.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
//视图
#import "ZBSuspensionView.h"
#import "ZBCommentViewController.h"

@interface ZBReaderViewController ()<UIScrollViewDelegate,WKNavigationDelegate>
{
    CGFloat _contentOffSet_Y; //WKWebView滑动后Y轴偏移量
}

/** 加载动画view*/
@property (nonatomic, strong) UIView *loadingView;
@property (nonatomic, strong) UIImageView *loadingImageView;
/** 悬浮视图view*/
@property (nonatomic,weak) ZBSuspensionView *suspensionView;

@property (nonatomic,weak) WKWebView *readerWebView;
//判断滑动方向
@property (nonatomic,assign) BOOL iSDownDrag;

@end

@implementation ZBReaderViewController

#pragma mark -- 懒加载
- (UIView *)loadingView{
    if (!_loadingView) {
        _loadingView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _loadingView.backgroundColor = [UIColor whiteColor];
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
    //监听键盘的弹出和收回
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardDidShow) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardDidHide) name:UIKeyboardDidHideNotification object:nil];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //当控制器pop时 把readerWebView的代理清空 防止项目崩溃
    _readerWebView.scrollView.delegate = nil;
}

-(void)dealloc{
    //移除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}
#pragma  mark -- set相关方法
-(void)setPost:(ZBPostModel *)post{
    _post = post;
    [self addWebView];

}

#pragma mark -- WKNavigationDelegate
//添加WKWebView
- (void)addWebView{
    WKWebView *readerWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, -20, ZBSCREEN_WIDTH, ZBSCREENH_HEIGHT + 20)];
    readerWebView.navigationDelegate = self;
    readerWebView.scrollView.delegate = self;
    [readerWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_post.appview]]];
    _readerWebView = readerWebView;
    [self.view addSubview:readerWebView];
    [self.view addSubview:self.loadingView];
    [self.loadingView addSubview:self.loadingImageView];
    //添加悬浮视图
    [self addSuspensionView];
    
  
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
                         [self.loadingImageView removeFromSuperview];
                         self.loadingImageView = nil;
                     }];
}
/// WXWebView加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    [self.loadingView setAlpha:0];
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
    if (scrollView.contentOffset.y >= 200 && scrollView.contentOffset.y <= 300 ) {
        [self setNeedsStatusBarAppearanceUpdate];
    }
    //悬浮视图隐藏或者显示
    [self SuspensionViewShowOrHide];
   
    
}
#pragma mark -- 悬浮试图相关方法
//添加悬浮视图
- (void)addSuspensionView{
    ZBSuspensionView *suspensionView = [[ZBSuspensionView alloc] init];
    suspensionView.frame = CGRectMake(0, ZBSCREENH_HEIGHT - 40, ZBSCREEN_WIDTH, 40);
    //赋值
    suspensionView.praise_count = [NSString stringWithFormat:@"%ld",(long)_post.praise_count];
    suspensionView.comment_count = [NSString stringWithFormat:@"%ld",(long)_post.comment_count];

   __weak typeof(self) weakSelf = self;
    //Block相关方法
    //退出阅读视图
    suspensionView.popupReaderViewControllerBlock = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    //进入评论列表
    suspensionView.pushCommentViewControllerBlock = ^{
        ZBCommentViewController *commentVC = [[ZBCommentViewController alloc] init];
        commentVC.commet_index = _post.comment_index;
        commentVC.title = [NSString stringWithFormat:@"%ld 条评论", _post.comment_count];
        [weakSelf.navigationController pushViewController:commentVC animated:YES];
    };
    
    
    
    [self.view addSubview:suspensionView];
    _suspensionView = suspensionView;

}
- (void)SuspensionViewShowOrHide{
    //判断方向
    if (_iSDownDrag && _suspensionView.alpha == 1 ) {//向下滑动 消失
        [UIView animateWithDuration:0.5 animations:^{
            _suspensionView.alpha = 0;
        }];
    }else if(!_iSDownDrag && _suspensionView.alpha == 0){//向上滑动 出现
        [UIView animateWithDuration:0.5 animations:^{
            _suspensionView.alpha = 1;
        }];
    }

}


#pragma mark -- 键盘处理问题
- (void)KeyboardDidShow{
    //弹出键盘 禁止全屏返回
    self.fd_interactivePopDisabled = YES;
}

- (void)KeyboardDidHide{
    //收回键盘 可以全屏返回
    self.fd_interactivePopDisabled = NO;
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

//}

@end
