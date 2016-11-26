//
//  UIButton+LTLbutton.m
//  WeiBo
//
//  Created by LiTaiLiang on 16/9/15.
//  Copyright © 2016年 LTL. All rights reserved.
//

#import "UIButton+LTLbutton.h"

@implementation UIButton (LTLbutton)

/**
 设置按钮

 @param text      欢迎文字
 @param image     按钮背景
 @param colorText 文字颜色

 @return 按钮
 */
-(instancetype)initText : (NSString *)text  image : (NSString *)image colorText : (UIColor *)colorText
{
    if (self = [super init]) {

        [self setTitle:text forState:UIControlStateNormal];
       // [self setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
         [self setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_highlighted",image]] forState:UIControlStateHighlighted];
//        [self setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_highlighted",image]] forState:UIControlStateNormal];
    self.tintColor = colorText;


    }
    return self;
}

@end
