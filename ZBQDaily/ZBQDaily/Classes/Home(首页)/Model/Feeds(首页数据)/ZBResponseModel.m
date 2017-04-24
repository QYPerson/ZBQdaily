//
//  ZBResponseModel.m
//  ZBQDaily
//
//  Created by zibin on 17/2/8.
//  Copyright © 2017年 zibin. All rights reserved.
//

#import "ZBResponseModel.h"
#import "MJExtension.h"

@implementation ZBResponseModel

+(NSDictionary *)mj_objectClassInArray{
    return @{
            @"feeds"  :  @"ZBFeedsModel",
            @"banners":  @"ZBBannersModel",
            @"columns":  @"ZBColumnModel",
            @"comments":@"ZBCommentModel"
            };
}

@end
