//
//  ZBCommentViewController.m
//  ZBQDaily
//
//  Created by zibin on 17/4/23.
//  Copyright © 2017年 zibin. All rights reserved.
//

#import "ZBCommentViewController.h"
//工具
#import "ZBDataManagerTool.h"
//第三方
#import "MBProgressHUD+MJ.h"
#import "SDAutoLayout.h"
//模型
#import "ZBResponseModel.h"
//视图
#import "ZBFatherCommentCell.h"
#import "UIViewController+CustomBackButtonItem.h"

@interface ZBCommentViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) ZBResponseModel *response;
@property (nonatomic,weak) UITableView *commentTableView;

@end

@implementation ZBCommentViewController
#pragma mark -- 初始化
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        //添加TabelView
        [self addTabelView];
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES];
    //自定义返回按钮
//    [self CustomBackButtonItemWithAction:@selector(goBackAction)];
}

#pragma mark -- set相关方法
-(void)setCommet_index:(NSInteger)commet_index{
    _commet_index = commet_index;
    //请求数据
    [ZBDataManagerTool CommentDataWithIndex:commet_index success:^(id response) {
        //字典转模型
        _response = [ZBResponseModel mj_objectWithKeyValues:response];
        [_commentTableView reloadData];
    } failure:^(id response) {
        [MBProgressHUD showError:@"网络连接失败，请检查网络"];
    }];
}

#pragma mark --TabelView相关方法
-(void)addTabelView{
    UITableView *commentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ZBSCREEN_WIDTH, ZBSCREENH_HEIGHT + 20) style:UITableViewStylePlain];
    commentTableView.delegate = self;
    commentTableView.dataSource = self;
    [self.view addSubview:commentTableView];
    _commentTableView = commentTableView;
    //去掉tableView分割线
    commentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    commentTableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _response.comments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZBFatherCommentCell *cell = [ZBFatherCommentCell fatherCommentCellWithTableView:tableView];
    cell.commentModel = _response.comments[indexPath.row];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  [self.commentTableView cellHeightForIndexPath:indexPath cellContentViewWidth:ZBSCREEN_WIDTH tableView:tableView];
}

#pragma  mark -- Other
-(void)goBackAction{
    [self.navigationController popViewControllerAnimated:YES];

}

@end
