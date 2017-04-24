//
//  ZBDataManagerTool.m
//  ZBQDaily
//
//  Created by zibin on 17/2/8.
//  Copyright © 2017年 zibin. All rights reserved.
//

#import "ZBDataManagerTool.h"
#import "ZBHttpTool.h"

@implementation ZBDataManagerTool
/**获取首页的数据*/
+(void)HomeNewsDataWithLastKey:(NSString *)lastKey success:(void (^)(id))success failure:(void (^)(id))failure{
    //URL
    NSString *url = [NSString stringWithFormat:@"http://app3.qdaily.com/app3/homes/index/%@.json?",lastKey];
    //请求数据
    [ZBHttpTool get:url params:nil success:^(id responseObj) {
        //获取response字典数据
        success(responseObj[@"response"]);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
//获取评论的数据
+ (void)CommentDataWithIndex:(NSInteger )index success:(void(^)(id response))success failure:(void(^)(id response))failure{
    //URL
    NSString *url = [NSString stringWithFormat:@"http://app3.qdaily.com/app3/comments/index/article/%ld/0.json?",index];
    //请求数据
    [ZBHttpTool get:url params:nil success:^(id responseObj) {
        //获取response字典数据
        success(responseObj[@"response"]);
    } failure:^(NSError *error) {
        failure(error);
    }];

    
}


@end
