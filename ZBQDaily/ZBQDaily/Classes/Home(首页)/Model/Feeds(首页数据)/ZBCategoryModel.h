//
//  ZBCategoryModel.h
//  ZBQDaily
//
//  Created by zibin on 17/2/8.
//  Copyright © 2017年 zibin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZBCategoryModel : NSObject
/** 新闻类型（设计、娱乐、智能等）*/
@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *normal;

@property (nonatomic,copy) NSString *normal_hl;
@end

