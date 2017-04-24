//
//  ZBSuspensionView.m
//  ZBQDaily
//
//  Created by zibin on 17/4/18.
//  Copyright © 2017年 zibin. All rights reserved.
//

#import "ZBSuspensionView.h"
#import "SDAutoLayout.h"


@interface ZBSuspensionView ()

@property (nonatomic,weak) UIButton *backBtn;
@property (nonatomic,weak) UIButton *praiseBtn;
@property (nonatomic,weak) UIButton *commentBtn;
@property (nonatomic,weak) UIButton *shareBtn;

@property (nonatomic,weak) UITextField *commentText;

@property (nonatomic,weak) UILabel *praiseLabel;
@property (nonatomic,weak) UILabel *commentLabel;


@end


@implementation ZBSuspensionView

#pragma mark -- 初始化
-(instancetype)init{
    if (self == [super init]) {
        //添加子控件
        [self addSubViews];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}



/**添加子控件*/
- (void)addSubViews{
    //返回按钮
    UIButton *backBtn = [[UIButton alloc]init];
    [backBtn setImage:[UIImage imageNamed:@"Suspention_Back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //评论输入框
    UITextField *commentText = [[UITextField alloc] init];
    [commentText addTarget:self action:@selector(commentTextDidClick:) forControlEvents:UIControlEventTouchUpInside];
    commentText.backgroundColor = [UIColor whiteColor];
    commentText.borderStyle = UITextBorderStyleRoundedRect;
    commentText.placeholder = @"我有话要说...";
    commentText.font = [UIFont systemFontOfSize:12];
    commentText.layer.cornerRadius = 3;
    commentText.clipsToBounds = YES;
    
    
    //点赞按钮 和label
    UIButton *praiseBtn = [[UIButton alloc]init];
    [praiseBtn setImage:[UIImage imageNamed:@"Suspention_Praise"] forState:UIControlStateNormal];
    [praiseBtn addTarget:self action:@selector(praiseBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *praiseLabel = [[UILabel alloc] init];
    praiseLabel.font = [UIFont systemFontOfSize:10];
    praiseLabel.textColor = [UIColor orangeColor];
    
    //评论按钮 和label
    UIButton *commentBtn = [[UIButton alloc]init];
    [commentBtn setImage:[UIImage imageNamed:@"Suspention_Comment"] forState:UIControlStateNormal];
    [commentBtn addTarget:self action:@selector(commentBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *commentLabel = [[UILabel alloc] init];
    commentLabel.font = [UIFont systemFontOfSize:10];
    commentLabel.textColor = [UIColor orangeColor];

 
    
    //分享按钮
    UIButton *shareBtn = [[UIButton alloc]init];
    [shareBtn setImage:[UIImage imageNamed:@"Suspention_Share"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:backBtn];
    [self addSubview:commentText];
    [self addSubview:praiseBtn];
    [self addSubview:praiseLabel];
    [self addSubview:commentBtn];
    [self addSubview:commentLabel];
    [self addSubview:shareBtn];

    
    _backBtn = backBtn;
    _commentBtn = commentBtn;
    _praiseBtn = praiseBtn;
    _shareBtn = shareBtn;
    _praiseLabel = praiseLabel;
    _commentLabel = commentLabel;
    _commentText = commentText;
    
//    _commentBtn.backgroundColor = ZBRandomColor
//    _praiseBtn.backgroundColor = ZBRandomColor
//    _shareBtn.backgroundColor = ZBRandomColor
//    _praiseLabel.backgroundColor = ZBRandomColor;
//    _commentLabel.backgroundColor = ZBRandomColor;

}


/**子控件布局*/
-(void)layoutSubviews{
    [super layoutSubviews];
    
    _backBtn.sd_layout
    .topSpaceToView(self,10)
    .leftSpaceToView(self,10)
    .widthIs(25)
    .heightIs(25);
    
    _shareBtn.sd_layout
    .topSpaceToView(self,11.5)
    .rightSpaceToView(self,20)
    .widthIs(22)
    .heightIs(22);
    
    _commentBtn.sd_layout
    .topSpaceToView(self,10)
    .rightSpaceToView(_shareBtn,20)
    .widthIs(25)
    .heightIs(25);
    
    _praiseBtn.sd_layout
    .topSpaceToView(self,10)
    .rightSpaceToView(_commentBtn,20)
    .widthIs(25)
    .heightIs(25);
    
    _commentText.sd_layout
    .topSpaceToView(self,10)
    .leftSpaceToView(_backBtn,10)
    .rightSpaceToView(_praiseBtn,10)
    .heightIs(25);
    
    _commentLabel.sd_layout
    .topSpaceToView(self,10)
    .leftSpaceToView(_commentBtn,0)
    .heightIs(15);
    [_commentLabel setSingleLineAutoResizeWithMaxWidth:30];
    
    _praiseLabel.sd_layout
    .topSpaceToView(self,10)
    .leftSpaceToView(_praiseBtn,0)
    .heightIs(15);
    [_praiseLabel setSingleLineAutoResizeWithMaxWidth:30];
    
    
}

#pragma mark --set方法
- (void)setPraise_count:(NSString *)praise_count{
    _praise_count = praise_count;
    _praiseLabel.text  = praise_count;
}

-(void)setComment_count:(NSString *)comment_count{
    _comment_count = comment_count;
    _commentLabel.text = comment_count;
    

}

#pragma mark --事件相关方法
-(void)backBtnDidClick:(UIButton *)btn{
    if (self.popupReaderViewControllerBlock) {
        self.popupReaderViewControllerBlock();
    }
}
-(void)praiseBtnDidClick:(UIButton *)btn{
    NSLog(@"%@",btn);
}
-(void)commentBtnDidClick:(UIButton *)btn{
    if (self.pushCommentViewControllerBlock) {
        self.pushCommentViewControllerBlock();
    }
}
-(void)shareBtnDidClick:(UIButton *)btn{
    NSLog(@"%@",btn);
}
-(void)commentTextDidClick:(UITextField *)textfield{
    NSLog(@"%@",textfield);
}



@end
