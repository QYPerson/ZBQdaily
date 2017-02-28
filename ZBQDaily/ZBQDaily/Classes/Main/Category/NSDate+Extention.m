//
//  NSDate+Extention.m
//  NSData+Extention
//
//  Created by 段盛武 on 16/7/17.
//  Copyright © 2016年 D.James. All rights reserved.
//

#import "NSDate+Extention.h"

@implementation NSDate (Extention)

+ (NSString *)nowFromDateExchange:(int)oldTime {//oldTime 为服务器返回的发布消息时间距离1970年多少秒
    
    //    计算现在距1970年多少秒
    NSDate *date = [NSDate date];
    NSTimeInterval currentTime= [date timeIntervalSince1970];
    
    //    计算现在的时间和发布消息的时间时间差
    double timeDiffence = currentTime - oldTime;
    
    //    根据秒数的时间差的不同，返回不同的日期格式
    if (timeDiffence <= 60) {
        return [NSString stringWithFormat:@"%.0f秒前",timeDiffence];
    }else if (timeDiffence <= 3600){
        return [NSString stringWithFormat:@"%.0f分钟前",timeDiffence / 60];
    }else if (timeDiffence <= 86400){
        return [NSString stringWithFormat:@"%.0f小时前",timeDiffence / 3600];
    }else {
        //    返回具体日期
        NSDate *oldTimeDate = [NSDate dateWithTimeIntervalSince1970:oldTime];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"M月dd日"];
        return [formatter stringFromDate:oldTimeDate];
    }
}
//未修改版本
-(void)weixiugai{
//    //    计算现在距1970年多少秒
//    NSDate *date = [NSDate date];
//    NSTimeInterval currentTime= [date timeIntervalSince1970];
//    
//    //    计算现在的时间和发布消息的时间时间差
//    double timeDiffence = currentTime - oldTime;
//    
//    //    根据秒数的时间差的不同，返回不同的日期格式
//    if (timeDiffence <= 60) {
//        return [NSString stringWithFormat:@"%.0f秒前",timeDiffence];
//    }else if (timeDiffence <= 3600){
//        return [NSString stringWithFormat:@"%.0f分钟前",timeDiffence / 60];
//    }else if (timeDiffence <= 86400){
//        return [NSString stringWithFormat:@"%.0f小时前",timeDiffence / 3600];
//    }else if (timeDiffence <= 604800){
//        return [NSString stringWithFormat:@"%.0f天前",timeDiffence / 3600 /24];
//    }else{
//        //    返回具体日期
//        NSDate *oldTimeDate = [NSDate dateWithTimeIntervalSince1970:oldTime];
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        [formatter setDateFormat:@"MM月dd日"];
//        return [formatter stringFromDate:oldTimeDate];
//    }





}


@end
