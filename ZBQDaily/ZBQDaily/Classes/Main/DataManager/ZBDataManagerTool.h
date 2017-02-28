//
//  ZBDataManagerTool.h
//  ZBQDaily
//
//  Created by zibin on 17/2/8.
//  Copyright © 2017年 zibin. All rights reserved.
//

#import <Foundation/Foundation.h>

#define HOMEURL @


@interface ZBDataManagerTool : NSObject
/**
 *  加载首页的新闻数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)HomeNewsDataWithLastKey:(NSString *)lastKey success:(void(^)(id response))success failure:(void(^)(id response))failure;


@end
