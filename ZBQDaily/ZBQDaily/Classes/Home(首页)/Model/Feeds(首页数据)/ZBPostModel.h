//
//  ZBPostModel.h
//  ZBQDaily
//
//  Created by zibin on 17/2/8.
//  Copyright © 2017年 zibin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZBCategoryModel;
@class ZBColumnModel;
@interface ZBPostModel : NSObject
/** 新闻标题*/
@property (nonatomic, copy) NSString *title;
/** 副标题*/
@property (nonatomic, copy) NSString *subhead;
/** 出版时间*/
@property (nonatomic, assign) NSInteger publish_time;
/** 配图*/
@property (nonatomic, copy) NSString *image;
/** 评论数*/
@property (nonatomic, assign) NSInteger comment_count;
/** 点赞数*/
@property (nonatomic, assign) NSInteger praise_count;
/** 新闻文章链接（html格式）*/
@property (nonatomic, copy) NSString *appview;
/** 评论请求URl中的索引*/
@property (nonatomic, assign) NSInteger comment_index;



@property (nonatomic,strong) ZBCategoryModel *category;
@property (nonatomic,strong) ZBColumnModel *column;

@end
