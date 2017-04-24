//
//  ZBPostModel.m
//  ZBQDaily
//
//  Created by zibin on 17/2/8.
//  Copyright © 2017年 zibin. All rights reserved.
//

#import "ZBPostModel.h"

@implementation ZBPostModel

/** 设置模型属性名和字典key之间的映射关系 */
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    /* 返回的字典，key为模型属性名，value为转化的字典的多级key */
    return @{@"subhead":@"description",
             @"comment_index":@"id"};
}

@end
