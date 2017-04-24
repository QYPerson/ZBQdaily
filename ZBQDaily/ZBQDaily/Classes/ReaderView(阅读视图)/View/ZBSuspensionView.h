//
//  ZBSuspensionView.h
//  ZBQDaily
//
//  Created by zibin on 17/4/18.
//  Copyright © 2017年 zibin. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^ZBSuspensionViewBlock)();

@interface ZBSuspensionView : UIView

/**评论数*/
@property (nonatomic,copy) NSString *comment_count;
/**点赞数*/
@property (nonatomic,copy) NSString *praise_count;


/** 弹出新闻阅读界面block*/
@property (nonatomic,copy) ZBSuspensionViewBlock popupReaderViewControllerBlock;
/** 进入评论界面block*/
@property (nonatomic,copy) ZBSuspensionViewBlock pushCommentViewControllerBlock;


@end
