//
//  ZBHomeCellTypeTwo.h
//  ZBQDaily
//
//  Created by zibin on 17/2/22.
//  Copyright © 2017年 zibin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBFeedsModel.h"
@interface ZBHomeCellTypeTwo : UITableViewCell
@property (nonatomic,strong) ZBFeedsModel *feed;

/** 封装创建cell代码 */
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
