//
//  ZBCommentModel.h
//  ZBQDaily
//
//  Created by zibin on 17/4/23.
//  Copyright © 2017年 zibin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZBCommentAuthor;
@interface ZBCommentModel : NSObject
/** 评论数 */
@property (nonatomic, assign) NSInteger comment_count;
/** 评论内容 */
@property (nonatomic,copy) NSString *content;
/** 评论时间 */
@property (nonatomic,assign) NSInteger publish_time;
/** 点赞数 */
@property (nonatomic,copy) NSString *praise_count;
/** 作者 */
@property (nonatomic,strong) ZBCommentAuthor *author;

@end
