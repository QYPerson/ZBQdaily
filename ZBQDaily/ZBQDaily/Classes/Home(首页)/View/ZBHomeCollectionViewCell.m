//
//  ZBHomeCollectionViewCell.m
//  ZBQDaily
//
//  Created by zibin on 17/2/27.
//  Copyright © 2017年 zibin. All rights reserved.
//

#import "ZBHomeCollectionViewCell.h"

/**  第三方*/
#import "SDAutoLayout.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSDate+Extention.h"
/**  模型*/
#import "ZBFeedsModel.h"
/** 副标题字体大小*/
static const CGFloat fontSize = 12;
/** 副标题与左边视图的间距*/
static const CGFloat subTitelLeftMargin = 4;
/** 副标题与底部的间距*/
static const CGFloat subTitelbottomMargin = 5;
/** 副标题高度*/
static const CGFloat subTitelHeight = 13;

@interface ZBHomeCollectionViewCell ()
/** 新闻标题*/
@property (nonatomic, strong) UILabel *news_title;
/** 新闻副标题*/
@property (nonatomic, strong) UILabel *news_subhead;
/** 出版时间*/
@property (nonatomic, strong) UILabel *publish_time;
/** 评论数*/
@property (nonatomic, strong) UILabel *comment_count;
/** 点赞数*/
@property (nonatomic, strong) UILabel *praise_count;
/** 新闻类型（设计、娱乐、智能等）*/
@property (nonatomic, strong) UILabel *news_type;

/** 主图*/
@property (nonatomic, strong) UIImageView *image;
/** 评论数视图*/
@property (nonatomic,strong)  UIImageView *comment_imageView;
/** 点赞数视图*/
@property (nonatomic, strong) UIImageView *praise_imageView;

@end




@implementation ZBHomeCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        /*
         需要在这里编写代码,实现自定制的功能.为了方便维护, 我写成一个一个函数, 在这里调用.
         */
        [self addSubviews];
    }
    return self;
}

-(void)addSubviews{
   
    // 1.标题
    self.news_title = [[UILabel alloc] init];
    _news_title.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_news_title];
    
    // 1.1副标题
    self.news_subhead = [[UILabel alloc] init];
    _news_subhead.font = [UIFont systemFontOfSize:14];
    _news_subhead.textColor = [UIColor grayColor];
    [self.contentView addSubview:_news_subhead];
    
    // 2.类型（娱乐 商业等）
    self.news_type = [self Label];
    [self.contentView addSubview:_news_type];
    
    // 3.评论数
    self.comment_count = [self Label];
    [self.contentView addSubview:_comment_count];
    
    // 4.点赞数
    self.praise_count = [self Label];
    [self.contentView addSubview:_praise_count];
    
    // 5.时间 （多少分钟前）
    self.publish_time = [self Label];
    [self.contentView addSubview:_publish_time];
    
    // 6.主图
    self.image = [[UIImageView alloc] init];
    [self.contentView addSubview:_image];
    
    // 7.评论配图
    self.comment_imageView = [[UIImageView alloc] init];
    _comment_imageView.image = [UIImage imageNamed:@"feedComment"];
    [self.contentView addSubview:_comment_imageView];
    
    // 8.点赞配图
    self.praise_imageView = [[UIImageView alloc] init];
    _praise_imageView.image = [UIImage imageNamed:@"feedPraise"];
    [self.contentView addSubview:_praise_imageView];
    
    
    _image.backgroundColor = [UIColor orangeColor];
    _news_title.backgroundColor = [UIColor blueColor];
    _news_subhead.backgroundColor = [UIColor yellowColor];
    _news_type.backgroundColor = [UIColor yellowColor];
    _comment_count.backgroundColor = [UIColor purpleColor];
    _praise_count.backgroundColor = [UIColor blackColor];
    _publish_time.backgroundColor = [UIColor greenColor];
    self.backgroundColor = [UIColor redColor];
    
    _comment_count.text = @"12";
    _praise_count.text = @"12";
    _news_type.text = @"jiaju";
    _news_title.text = @"123";
    _publish_time.text = @"santianqian";
    
    _news_subhead.text = @"santianqian";

    

    [self customUI];


}
#pragma mark -- 填充数据
-(void)setFeed:(ZBFeedsModel *)feed{
    // 设置子控件布局
    [self customUI];
}
#pragma mark -- 设置子控件布局
-(void)customUI{
    
    //主图
    _image.sd_layout
    .topSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0)
    .widthRatioToView(self.contentView, 1)
    .heightIs(100);
    
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
    
    
    // 新闻类型
    _news_type.sd_layout
    .leftEqualToView(_news_title)
    .topSpaceToView(_news_subhead,subTitelbottomMargin)
    .widthIs(30)
    .autoHeightRatio(0);
    
    
    //如果评论数为零 把评论配图和评论label宽度设置为0
    if ([_comment_count.text isEqualToString:@"0"]) {
        //点赞配图
        _comment_imageView.sd_layout
        .leftSpaceToView(_news_type, 0)
        .bottomEqualToView(_news_type)
        .widthIs(0)
        .heightIs(subTitelHeight - 3);
        // 评论数量
        _comment_count.sd_layout
        .leftSpaceToView(_comment_imageView, 0)
        .bottomEqualToView(_news_type)
        .heightIs(subTitelHeight)
        .widthIs(0);
        
    }else{//如果不为零 则正常显示
        
        _comment_imageView.sd_layout
        .leftSpaceToView(_news_type, subTitelLeftMargin)
        .bottomEqualToView(_news_type)
        .widthIs(subTitelHeight)
        .heightIs(subTitelHeight - 3);
        
        _comment_count.sd_layout
        .leftSpaceToView(_comment_imageView, subTitelLeftMargin + 1)
        .bottomEqualToView(_news_type)
        .heightIs(subTitelHeight);
        [_comment_count setSingleLineAutoResizeWithMaxWidth:180];
        
    }
    
    //如果点赞数为零 把点赞imageView和点赞label宽度设置为0
    if ([_praise_count.text isEqualToString:@"0"]) {
        // 点赞配图
        _praise_imageView.sd_layout
        .leftSpaceToView(_comment_count,0)
        .bottomSpaceToView(self.contentView,subTitelbottomMargin)
        .widthIs(0)
        .heightIs(subTitelHeight - 2);
        
        _praise_count.sd_layout
        .leftSpaceToView(_praise_imageView, 0)
        .bottomEqualToView(_news_type)
        .heightIs(subTitelHeight)
        .widthIs(0);
        
    }else{//如果不为零 则正常显示
        
        // 点赞配图
        _praise_imageView.sd_layout
        .leftSpaceToView(_comment_count,subTitelLeftMargin)
        .bottomEqualToView(_news_type)
        .widthIs(subTitelHeight)
        .heightIs(subTitelHeight - 2);
        
        _praise_count.sd_layout
        .leftSpaceToView(_praise_imageView, subTitelLeftMargin)
        .bottomEqualToView(_news_type)
        .heightIs(subTitelHeight);
        [_praise_count setSingleLineAutoResizeWithMaxWidth:180];
        
    }
    
    //时间
    _publish_time.sd_layout
    .leftSpaceToView(_praise_count,subTitelLeftMargin+2)
    .bottomEqualToView(_news_type)
    .heightIs(subTitelHeight);
    [_publish_time setSingleLineAutoResizeWithMaxWidth:180];
    
//    [self setupAutoHeightWithBottomView:_news_type bottomMargin:10];
    
}

/**返回设定好的Label*/
-(UILabel *)Label{
    UILabel *label  = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = [UIColor grayColor];
    return label;
}

@end
