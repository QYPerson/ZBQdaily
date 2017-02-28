//
//  ZBHttpTool.m
//  ZBQDaily
//
//  Created by zibin on 17/1/18.
//  Copyright © 2017年 zibin. All rights reserved.
//

#import "ZBHttpTool.h"
#import "AFNetworking.h"
@implementation ZBHttpTool
+(void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    AFHTTPSessionManager *mag = [AFHTTPSessionManager manager];
    [mag GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];

}




@end
