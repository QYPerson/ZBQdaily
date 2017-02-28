//
//  ZBHomeCellTypeThree.h
//  ZBQDaily
//
//  Created by zibin on 17/2/27.
//  Copyright © 2017年 zibin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZBFeedsModel.h"
@interface ZBHomeCellTypeThree : UITableViewCell
@property (nonatomic,strong) ZBFeedsModel *feed;
@property (nonatomic,copy) void (^shareBtnClick)();
/** 封装创建cell代码 */
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end