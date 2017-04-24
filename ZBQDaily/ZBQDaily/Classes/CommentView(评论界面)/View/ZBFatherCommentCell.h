//
//  ZBFatherCommentCell.h
//  ZBQDaily
//
//  Created by zibin on 17/4/23.
//  Copyright © 2017年 zibin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZBCommentModel;
@interface ZBFatherCommentCell : UITableViewCell

@property (nonatomic,strong) ZBCommentModel *commentModel;
+ (instancetype)fatherCommentCellWithTableView:(UITableView *)tableView;
@end
