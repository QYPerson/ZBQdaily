//
//  ZBResponseModel.h
//  ZBQDaily
//
//  Created by zibin on 17/2/8.
//  Copyright © 2017年 zibin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@class ZBFeedsModel;
@interface ZBResponseModel : NSObject
/** 下拉加载时判断是否还有更多文章 false：没有 true：有*/
@property (nonatomic, copy) NSString *has_more;
/** 下拉加载时需要拼接到URL中的key*/
@property (nonatomic, copy) NSString *last_key;
@property (nonatomic, strong) NSMutableArray *feeds;
@property (nonatomic, strong) NSArray *banners;

@end
