//
//  ZBFatherCommentCell.m
//  ZBQDaily
//
//  Created by zibin on 17/4/23.
//  copyright © 2017年 zibin. All rights reserved.
//

#import "ZBFatherCommentCell.h"

#import <SDWebImage/UIImageView+WebCache.h>
#import "SDAutoLayout.h"
#import "NSDate+Extention.h"


#import "ZBCommentModel.h"
#import "ZBCommentAuthor.h"
@interface ZBFatherCommentCell ()
/** 评论者头像*/
@property (nonatomic,strong) UIImageView *iconView;
/** 点赞图像 */
@property (nonatomic,strong) UIImageView *praiseView;
/** 评论者姓名 */
@property (nonatomic,strong) UILabel *nameLabel;
/** 评论内容 */
@property (nonatomic,strong) UILabel *contentLabel;
/** 评论时间 */
@property (nonatomic,strong) UILabel *publish_timeLabel;
/** 点赞数 */
@property (nonatomic,strong) UILabel *praise_countLabel;
@end



@implementation ZBFatherCommentCell

+ (instancetype)fatherCommentCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"fatherCommentCell";
    ZBFatherCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[ZBFatherCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        // 添加子控件
        [self addSubviews];
        
    }
    
    return self;
}
#pragma mark -- 添加子控件
-(void)addSubviews{
    
    /** 评论者头像*/
    self.iconView = [[UIImageView alloc] init];
    _iconView.clipsToBounds = YES;
    [self.contentView addSubview:_iconView];
    _iconView.layer.cornerRadius = 25 * 0.5 ;

    /** 点赞图像 */
    self.praiseView = [[UIImageView alloc] init];
    [self.contentView addSubview:_praiseView];
    
    /** 评论者姓名 */
    self.nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_nameLabel];
    
    /** 评论内容 */
    self.contentLabel = [[UILabel alloc] init];
    _contentLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_contentLabel];
    
    /** 评论时间 */
    self.publish_timeLabel = [[UILabel alloc] init];
    _publish_timeLabel.font = [UIFont systemFontOfSize:12];
    _publish_timeLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_publish_timeLabel];
    
    /** 点赞数 */
    self.praise_countLabel = [[UILabel alloc] init];
    _praise_countLabel.font = [UIFont systemFontOfSize:14];
    _praise_countLabel.textAlignment = NSTextAlignmentCenter;
    _praise_countLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_praise_countLabel];
    
    
}
#pragma mark -- 填充数据
-(void)setCommentModel:(ZBCommentModel *)commentModel{
    _commentModel = commentModel;
    self.nameLabel.text = commentModel.author.name;
    self.praise_countLabel.text = commentModel.praise_count;
    if ([commentModel.praise_count isEqualToString:@"0"]) {
        self.praise_countLabel.text = nil;
    }
    self.publish_timeLabel.text = [NSDate nowFromDateExchange:(int)commentModel.publish_time];
    self.contentLabel.text = commentModel.content;
    self.praiseView.image = [UIImage imageNamed:@"Suspention_Praise"];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:commentModel.author.avatar]];
    
    [self customUI];


}

#pragma mark -- 设置子控件布局
-(void)customUI{
    
    // 1.名字图标
    _iconView.sd_layout
    .topSpaceToView(self.contentView,10)
    .leftSpaceToView(self.contentView,10)
    .widthIs(25)
    .heightIs(25);

    // 2.名字
    _nameLabel.sd_layout
    .leftSpaceToView(_iconView,5)
    .topEqualToView(_iconView)
    .heightIs(25);
    [_nameLabel setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    
    // 3.评论时间
    _publish_timeLabel.sd_layout
    .leftSpaceToView(_nameLabel,5)
    .topEqualToView(_nameLabel)
    .heightIs(25);
    [_publish_timeLabel setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    

    
    //点赞图标
    _praiseView.sd_layout
    .topSpaceToView(self.contentView,10)
    .rightSpaceToView(self.contentView,10)
    .widthIs(20)
    .heightIs(20);
    
    //点赞数
    _praise_countLabel.sd_layout
    .topSpaceToView(self.contentView,10)
    .rightSpaceToView(_praiseView,0)
    .widthIs(20)
    .heightIs(20);
    
    //点赞数
    _contentLabel.sd_layout
    .topSpaceToView(_nameLabel,10)
    .leftEqualToView(_nameLabel)
    .rightSpaceToView(_praiseView,0)
    .autoHeightRatio(0);
    [self setupAutoHeightWithBottomView:_contentLabel bottomMargin:10];
}

@end
