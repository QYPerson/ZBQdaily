//
//  ZBHomeCellTypeThree.m
//  ZBQDaily
//
//  Created by zibin on 17/2/27.
//  Copyright © 2017年 zibin. All rights reserved.
//

#import "ZBHomeCellTypeThree.h"


/**  第三方*/
#import "SDAutoLayout.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSDate+Extention.h"
/**  模型*/
#import "ZBPostModel.h"
#import "ZBCategoryModel.h"
#import "ZBFeedsModel.h"
#import "ZBColumnModel.h"
/**  视图*/
#import "ZBHomeCollectionViewCell.h"

/** 副标题字体大小*/
static const CGFloat fontSize = 12;
// 注意const的位置
static NSString *const cellId = @"cellId";

@interface ZBHomeCellTypeThree () <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/** 名字图标*/
@property (nonatomic,strong) UIImageView *column_iconView;
/** 名字（例如 好奇心研究所）*/
@property (nonatomic,strong) UILabel *column_nameLabel;
/** 订阅按钮 */
@property (nonatomic,strong) UIButton *followBtn;
/** 分享按钮*/
@property (nonatomic,strong) UIButton *shareBtn;
/** 分割线*/
@property (nonatomic,strong) UIView *lineView;
/** collectionView*/
@property (nonatomic,strong) UICollectionView *collectionView;


@end


@implementation ZBHomeCellTypeThree
#pragma mark -- 初始化方法
+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *ID = @"ZBHomeCellTypeThree";
    ZBHomeCellTypeThree *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[ZBHomeCellTypeThree alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
    
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        // 添加子控件
        [self addSubviews];
        
    }
    
    return self;
}

#pragma mark -- 添加子控件
-(void)addSubviews{
    // 1.名字图标
    self.column_iconView = [[UIImageView alloc] init];
    _column_iconView.clipsToBounds = YES;
    _column_iconView.layer.cornerRadius = 4;
    [self.contentView addSubview:_column_iconView];
    
    // 2.名字
    self.column_nameLabel = [[UILabel alloc] init];
    _column_nameLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_column_nameLabel];
    
    // 3.订阅按钮
    self.followBtn = [[UIButton alloc] init];
    [_followBtn setImage:[UIImage imageNamed:@"feedFollow"] forState:UIControlStateNormal];
    [_followBtn addTarget:self action:@selector(followBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_followBtn];
    
    // 4.分享按钮
    self.shareBtn = [[UIButton alloc] init];
    [_shareBtn setImage:[UIImage imageNamed:@"feedShare"] forState:UIControlStateNormal];
    [_shareBtn addTarget:self action:@selector(shareBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_shareBtn];
    
    // 5.分割线
    self.lineView = [[UIView alloc] init];
    _lineView.backgroundColor = [UIColor grayColor];
    _lineView.alpha = 0.2;
    [self.contentView addSubview:_lineView];

    // 5.collectionView
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //设置 UICollectionView 的滑动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置每个 item 的大小
    flowLayout.itemSize = CGSizeMake(140, 200);
    //行距
    flowLayout.minimumLineSpacing = 5;
    //列距
    //flowLayout.minimumInteritemSpacing = 100;
    //设置 item 的上左下右的边距大小
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 0);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.width, 200) collectionViewLayout:flowLayout];
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.contentView addSubview:_collectionView];
    [_collectionView registerClass:[ZBHomeCollectionViewCell class] forCellWithReuseIdentifier:cellId];

}



#pragma mark -- 填充数据
-(void)setFeed:(ZBFeedsModel *)feed{
    _feed = feed;
    
    [_column_iconView sd_setImageWithURL:[NSURL URLWithString:feed.post.column.icon]];
    _column_nameLabel.text = feed.post.column.name;
    // 设置子控件布局
    [self customUI];
}
#pragma mark -- 设置子控件布局
-(void)customUI{
    
    // 1.名字图标
    _column_iconView.sd_layout
    .topSpaceToView(self.contentView,10)
    .leftSpaceToView(self.contentView,10)
    .widthIs(25)
    .heightIs(25);
    
    // 2.名字
    _column_nameLabel.sd_layout
    .leftSpaceToView(_column_iconView,5)
    .topEqualToView(_column_iconView)
    .heightIs(25);
    [_column_nameLabel setSingleLineAutoResizeWithMaxWidth:180];
    
    // 3.分享按钮
    _shareBtn.sd_layout
    .rightSpaceToView(self.contentView,10)
    .topEqualToView(_column_iconView)
    .widthIs(25)
    .heightIs(25);
    
    // 4.订阅按钮
    _followBtn.sd_layout
    .rightSpaceToView(_shareBtn,5)
    .topEqualToView(_column_iconView)
    .widthIs(25)
    .heightIs(25);
    
    // 5.分割线
    _lineView.sd_layout
    .leftEqualToView(_column_iconView)
    .rightEqualToView(_shareBtn)
    .topSpaceToView(_column_iconView,10)
    .heightIs(1);
    
    // 6.collectionView
    _collectionView.sd_layout
    .leftSpaceToView(self.contentView,0)
    .topSpaceToView(_lineView,5)
    .widthIs(ZBSCREEN_WIDTH)
    .heightIs(200);
    
    [self setupAutoHeightWithBottomView:_collectionView bottomMargin:10];
}

/**返回设定好的Label*/
-(UILabel *)Label{
    UILabel *label  = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = [UIColor grayColor];
    return label;
}
#pragma mark -- 订阅 分享按钮被点击
//分享按钮被点击
- (void)shareBtnDidClick{
    if (self.shareBtnClick) {
        self.shareBtnClick();
    }
    
}

//订阅按钮被点击
-(void)followBtnDidClick{
    NSLog(@"%@",@"订阅按钮被点击");
}

#pragma mark --  collectionView  数据源
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = (ZBHomeCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;

}

#pragma mark --  collectionView  代理方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"我点击了第%ld个item",indexPath.item);


}

@end