//
//  ZBHomeCellTypeZero.m
//  ZBQDaily
//
//  Created by zibin on 17/2/22.
//  Copyright © 2017年 zibin. All rights reserved.
//

#import "ZBHomeCellTypeZero.h"


/**  第三方*/
#import "SDAutoLayout.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSDate+Extention.h"
/**  模型*/
#import "ZBPostModel.h"
#import "ZBCategoryModel.h"
#import "ZBFeedsModel.h"
#import "ZBColumnModel.h"
/** 副标题字体大小*/
static const CGFloat fontSize = 12;

@interface ZBHomeCellTypeZero ()
/** 名字图标*/
@property (nonatomic,strong) UIImageView *column_iconView;
/** 名字（例如 好奇心研究所）*/
@property (nonatomic,strong) UILabel *column_nameLabel;
/** 分享按钮*/
@property (nonatomic,strong) UIButton *shareBtn;
/** 主图*/
@property (nonatomic, strong) UIImageView *image;
/** 分类标题(例如 我说)*/
@property (nonatomic,strong) UIImageView *category_titleView;
/** 新闻标题*/
@property (nonatomic, strong) UILabel *news_title;
/** 新闻副标题*/
@property (nonatomic, strong) UILabel *news_subhead;

@end


@implementation ZBHomeCellTypeZero

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *ID = @"HomeCellTypeZero";
    ZBHomeCellTypeZero *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[ZBHomeCellTypeZero alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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

    // 3.分享按钮
    self.shareBtn = [[UIButton alloc] init];
    [_shareBtn setImage:[UIImage imageNamed:@"feedShare"] forState:UIControlStateNormal];
    [_shareBtn addTarget:self action:@selector(shareBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_shareBtn];
    
    // 4.主图
    self.image = [[UIImageView alloc] init];
    [self.contentView addSubview:_image];
    
    // 5.分类标题(例如 我说)
    self.category_titleView = [[UIImageView alloc] init];
    [self.contentView addSubview:_category_titleView];
    
    // 6.标题
    self.news_title = [[UILabel alloc] init];
    _news_title.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_news_title];
    
    // 7副标题
    self.news_subhead = [[UILabel alloc] init];
    _news_subhead.font = [UIFont systemFontOfSize:14];
    _news_subhead.textColor = [UIColor grayColor];
    [self.contentView addSubview:_news_subhead];
    
  
    
}



#pragma mark -- 填充数据
-(void)setFeed:(ZBFeedsModel *)feed{
    _feed = feed;
    
    _news_title.text = feed.post.title;
    _news_subhead.text = feed.post.subhead;
    [_image sd_setImageWithURL:[NSURL URLWithString:feed.post.image]];
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
    
    
    //主图
    _image.sd_layout
    .topSpaceToView(_column_iconView,10)
    .rightSpaceToView(self.contentView,0)
    .widthRatioToView(self.contentView, 1)
    .heightIs(150);
    
    // 标题
    _news_title.sd_layout
    .leftSpaceToView(self.contentView,10)
    .rightSpaceToView(self.contentView,10)
    .topSpaceToView(_image, 10)
    .autoHeightRatio(0);
    
    //副标题
    _news_subhead.sd_layout
    .leftEqualToView(_news_title)
    .topSpaceToView(_news_title,10)
    .rightEqualToView(_news_title)
    .autoHeightRatio(0);
    
    [self setupAutoHeightWithBottomView:_news_subhead bottomMargin:10];

    
}

/**返回设定好的Label*/
-(UILabel *)Label{
    UILabel *label  = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = [UIColor grayColor];
    return label;
}

//分享按钮被点击
- (void)shareBtnDidClick{
    if (self.shareBtnClick) {
        self.shareBtnClick();
    }
    
}






@end
