//
//  ZBFeedsModel.h
//  ZBQDaily
//
//  Created by zibin on 17/2/8.
//  Copyright © 2017年 zibin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZBPostModel;
@interface ZBFeedsModel : NSObject
/** 文章类型（以此来判断cell（文章显示）的样式）*/
@property (nonatomic, copy) NSString *type;
/** 文章配图 */
@property (nonatomic, copy) NSString *image;

@property (nonatomic, strong) ZBPostModel *post;

@end
