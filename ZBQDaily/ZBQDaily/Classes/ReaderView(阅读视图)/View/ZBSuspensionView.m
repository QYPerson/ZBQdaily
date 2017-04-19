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


-(instancetype)init{
    if (self == [super init]) {
        //添加子控件
        [self addSubViews];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
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
    
//    _praiseBtn.backgroundColor = [UIColor orangeColor];
//    _commentBtn.backgroundColor = [UIColor grayColor];
//    _shareBtn.backgroundColor = [UIColor yellowColor];
//    _backBtn.backgroundColor = [UIColor greenColor];

    
    self.backgroundColor = [UIColor whiteColor];
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
    commentText.backgroundColor = [UIColor grayColor];
    //点赞按钮 和label
    UIButton *praiseBtn = [[UIButton alloc]init];
    [praiseBtn setImage:[UIImage imageNamed:@"Suspention_Praise"] forState:UIControlStateNormal];
    UILabel *praiseLabel = [[UILabel alloc] init];
    [praiseBtn addTarget:self action:@selector(praiseBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //评论按钮 和label
    UIButton *commentBtn = [[UIButton alloc]init];
    [commentBtn setImage:[UIImage imageNamed:@"Suspention_Comment"] forState:UIControlStateNormal];
    UILabel *commentLabel = [[UILabel alloc] init];
    [commentBtn addTarget:self action:@selector(commentBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    
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
    

}


-(void)backBtnDidClick:(UIButton *)btn{
    NSLog(@"%@",btn);
}
-(void)praiseBtnDidClick:(UIButton *)btn{
    NSLog(@"%@",btn);
}
-(void)commentBtnDidClick:(UIButton *)btn{
    NSLog(@"%@",btn);
}
-(void)shareBtnDidClick:(UIButton *)btn{
    NSLog(@"%@",btn);
}
-(void)commentTextDidClick:(UITextField *)textfield{
    NSLog(@"%@",textfield);
}


@end
