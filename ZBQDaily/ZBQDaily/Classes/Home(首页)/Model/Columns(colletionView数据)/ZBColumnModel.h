//
//  ZBColumnModel.h
//  ZBQDaily
//
//  Created by zibin on 17/2/12.
//  Copyright © 2017年 zibin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZBColumnModel : NSObject
/** 名字图标*/
@property (nonatomic,copy) NSString *icon;
/** 分类名字*/
@property (nonatomic,copy) NSString *name;
/** 请求参数标记*/
@property (nonatomic,copy) NSString *column_tag;

@end
