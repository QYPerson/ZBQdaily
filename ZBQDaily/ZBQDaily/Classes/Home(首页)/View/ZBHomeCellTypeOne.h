//
//  ZBHomeCellTypeOne.h
//  ZBQDaily
//
//  Created by zibin on 17/1/7.
//  Copyright © 2017年 zibin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZBFeedsModel;
@interface ZBHomeCellTypeOne : UITableViewCell
@property (nonatomic,strong) ZBFeedsModel *feed;
/** 封装创建cell代码 */
+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
