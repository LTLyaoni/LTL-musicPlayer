//
//  UILabel+LTLlabel.h
//  WeiBo
//
//  Created by LiTaiLiang on 16/9/15.
//  Copyright © 2016年 LTL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (LTLlabel)
/**
 设置文本
 
 @param text  文本
 @param font  文本大小
 @param color 文本颜色
 
 @return 文本
 */
-(instancetype)initText:(NSString *)text font:(CGFloat)font color:(UIColor *)color;

@end
