//
//  UIButton+LTLbutton.h
//  WeiBo
//
//  Created by LiTaiLiang on 16/9/15.
//  Copyright © 2016年 LTL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (LTLbutton)

//@property(nonatomic,assign) BOOL Tick;

/**
 设置按钮
 
 @param text      欢迎文字
 @param image     按钮背景
 @param colorText 文字颜色
 
 @return 按钮
 */
-(instancetype)initText : (NSString *)text  image : (NSString *)image colorText : (UIColor *)colorText;

@end
