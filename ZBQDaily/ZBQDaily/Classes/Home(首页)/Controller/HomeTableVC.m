//
//  HomeTableVC.m
//  ZBQDaily
//
//  Created by zibin on 17/1/7.
//  Copyright © 2017年 zibin. All rights reserved.
//

#import "HomeTableVC.h"
//第三方
#import "MJExtension.h"
#import "MBProgressHUD+MJ.h"
#import "SDCycleScrollView.h"
#import "MJRefresh.h"
#import "SDAutoLayout.h"
//视图
#import "ZBHomeCellTypeZero.h"
#import "ZBHomeCellTypeOne.h"
#import "ZBHomeCellTypeTwo.h"
#import "ZBHomeCellTypeThree.h"
#import "ZBDropDownRefreshHeader.h"
//工具
#import "ZBDataManagerTool.h"
//数据模型
#import "ZBResponseModel.h"
#import "ZBFeedsModel.h"
#import "ZBBannersModel.h"
#import "ZBColumnModel.h"
#import "ZBPostModel.h"
//控制器
#import "ZBReaderViewController.h"
/**首页cell类型分类*/
typedef NS_ENUM(NSInteger, HomeCellStyle) {
    HomeCellTypeZero,
    HomeCellTypeOne,
    HomeCellTypeTwo
};

@interface HomeTableVC () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak) UITableView *HomeTableView;
@property (nonatomic,strong) ZBResponseModel *response;
@property (nonatomic,weak) SDCycleScrollView *cycleScrollView;
@property (nonatomic,strong) UIImageView *launch;
@end

@implementation HomeTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addTableView];
    //添加轮播图
    [self addCycleScrollView];
    //添加启动图
    [self addLaunchView];
    //添加上拉刷新 下拉加载
    [self addDropOrUpRefresh];
    //第一次加载数据
    [self firstLoadData];
}

- (void)addTableView{
    UITableView *HomeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -20, ZBSCREEN_WIDTH, ZBSCREENH_HEIGHT + 20) style:UITableViewStylePlain];
    HomeTableView.delegate = self;
    HomeTableView.dataSource = self;
    //去掉tableView分割线
    [self.view addSubview:HomeTableView];
    _HomeTableView = HomeTableView;
    HomeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}

#pragma mark - 添加启动图
-(void)addLaunchView{
    UIImageView *launchView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    launchView.image = [UIImage imageNamed:@"launch"];
    _launch = launchView;
    [self.view addSubview:launchView];
}

#pragma mark - 轮播图相关方法
-(void)addCycleScrollView{
    // 轮播器
    _cycleScrollView = [SDCycleScrollView customCycleScrollViewWithFrame:CGRectMake(0, 0, ZBSCREEN_WIDTH, ZBSCREENH_HEIGHT * 0.4) imageURLStringsGroup:nil];
    __weak typeof(self) weakSelf = self;
    _cycleScrollView.clickItemOperationBlock = ^(NSInteger currentIndex){
        //创建阅读视图
        ZBReaderViewController *readerVC = [[ZBReaderViewController alloc] init];
        //填数据
        readerVC.HtmlUrl = [_response.banners[currentIndex] post].appview;
        [weakSelf.navigationController pushViewController:readerVC animated:YES];
    };
    _HomeTableView.tableHeaderView = _cycleScrollView;
}
//更新轮播图数据
-(void)reloadCycleScrollData{
    //图片URl数组
    NSMutableArray * imageUrlArr = [NSMutableArray array];
    //轮播图标题数组
    NSMutableArray * titleUrlArr = [NSMutableArray array];
    for (ZBBannersModel *banner in _response.banners) {
        [imageUrlArr addObject: banner.image];
        [titleUrlArr addObject:banner.post.title];
    };
    _cycleScrollView.titlesGroup = titleUrlArr;
    _cycleScrollView.imageURLStringsGroup = imageUrlArr;
}
#pragma mark -添加上拉刷新 下拉加载
-(void)addDropOrUpRefresh{
    __weak typeof(self) weakSelf = self;
    //下拉刷新
    _HomeTableView.mj_header = [ZBDropDownRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf.HomeTableView.mj_header endRefreshing];
    }];
    //上拉刷新
    _HomeTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [ZBDataManagerTool HomeNewsDataWithLastKey:_response.last_key success:^(id response) {
            ZBResponseModel *responseModel = [ZBResponseModel mj_objectWithKeyValues:response];
            [_response.feeds addObjectsFromArray:responseModel.feeds];
            _response.last_key = responseModel.last_key;
            [weakSelf.HomeTableView reloadData];
            [weakSelf.HomeTableView.mj_footer endRefreshing];
        } failure:^(id response) {
            [MBProgressHUD showError:@"网络连接失败，请检查网络"];
            [weakSelf.HomeTableView.mj_footer endRefreshing];
        }];
    }];
}

#pragma mark - 首次加载数据
-(void)firstLoadData{

    //第一次加载数据
    [ZBDataManagerTool HomeNewsDataWithLastKey:@"0" success:^(id response) {
        //字典转模型
        _response = [ZBResponseModel mj_objectWithKeyValues:response];
        //启动图消失 加载数据
        [UIView animateWithDuration:0.5 delay:1 options:UIViewAnimationOptionLayoutSubviews animations:^{
            _launch.alpha = 0;
        } completion:^(BOOL finished) {
            [_launch removeFromSuperview];
            //更新轮播图和主页数据
            [self reloadCycleScrollData];
            [_HomeTableView reloadData];
        }];
     
     } failure:^(id response) {
        [UIView animateWithDuration:1 delay:1 options:UIViewAnimationOptionLayoutSubviews animations:^{
            _launch.alpha = 0;
        } completion:^(BOOL finished) {
            [_launch removeFromSuperview];
        }];
        [MBProgressHUD showError:@"网络连接失败，请检查网络"];
     }];

}


#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
     return _response.feeds.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if ((indexPath.section % 6 == 0) && (indexPath.section != 0)) {
//        NSLog(@"%ld",indexPath.section);
//        ZBHomeCellTypeThree *cell = [ZBHomeCellTypeThree cellWithTableView:tableView];
//        cell.shareBtnClick = ^{
//            NSLog(@"在控制器中被点击");
//        };
//        cell.feed =_response.feeds[indexPath.section];
//        return cell;
//    }
    ZBFeedsModel *feedModel  = _response.feeds[indexPath.section];
    //判断cell类型 选择对应的cell
    switch ([feedModel.type intValue]) {
        case HomeCellTypeZero:{
            ZBHomeCellTypeZero *cell = [ZBHomeCellTypeZero cellWithTableView:tableView];
            cell.shareBtnClick = ^{
                NSLog(@"在控制器中被点击");
            };
            cell.feed =_response.feeds[indexPath.section];
            return cell;
        }
        case HomeCellTypeOne:{
            ZBHomeCellTypeOne *cell = [ZBHomeCellTypeOne cellWithTableView:tableView];
            cell.feed =_response.feeds[indexPath.section];
            return cell;
        }
            break;
        case HomeCellTypeTwo:{
            ZBHomeCellTypeTwo *cell = [ZBHomeCellTypeTwo cellWithTableView:tableView];
            cell.feed =_response.feeds[indexPath.section];
            return cell;
        }
            break;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//     ZBFeedsModel *feedModel  = _response.feeds[indexPath.section];
//    switch ([feedModel.type intValue]) {
//        case HomeCellTypeZero:
//            return 300;
//            break;
//        case HomeCellTypeOne:
//            return 120;
//            break;
//        case HomeCellTypeTwo:
//            return 300;
//            break;
//
//    }
//    return 0;
    return  [self.HomeTableView cellHeightForIndexPath:indexPath cellContentViewWidth:ZBSCREEN_WIDTH tableView:tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 立即取消选中
    [_HomeTableView deselectRowAtIndexPath:indexPath animated:YES];
    //创建阅读视图
    ZBReaderViewController *readerVC = [[ZBReaderViewController alloc] init];
    //填数据
    readerVC.HtmlUrl = [_response.feeds[indexPath.section] post].appview;
    [self.navigationController pushViewController:readerVC animated:YES];
}


#pragma mark - Other
//修改状态栏颜色
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

//UITableView的Style为Plain时禁止headerInsectionView(组头视图)固定在顶端：
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
   static CGFloat sectionHeaderHeight = 5;
    if(scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0,0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
    
//    scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);

}

//隐藏导航栏
- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}
@end


























