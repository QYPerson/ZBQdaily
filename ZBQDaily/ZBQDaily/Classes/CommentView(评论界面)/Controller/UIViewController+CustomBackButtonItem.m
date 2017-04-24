//
//  UIViewController+CustomBackButtonItem.m
//  ZBQDaily
//
//  Created by zibin on 17/4/24.
//  Copyright © 2017年 zibin. All rights reserved.
//

#import "UIViewController+CustomBackButtonItem.h"

@implementation UIViewController (CustomBackButtonItem)
- (void)CustomBackButtonItemWithAction:(SEL)action{
    UIButton *backbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame = CGRectMake(0, 0, 30, 30);
    [backbtn setBackgroundImage:[UIImage imageNamed:@"Suspention_Back"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:action forControlEvents: UIControlEventTouchUpInside];
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithCustomView:backbtn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = - 20;
    self.navigationItem.leftBarButtonItems =@[negativeSpacer,backBtn];
}

@end
