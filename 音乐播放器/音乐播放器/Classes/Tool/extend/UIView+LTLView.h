//
//  UIView+LTLView.h
//  WeiBo
//
//  Created by Apple_Lzzy46 on 16/9/23.
//  Copyright © 2016年 LTL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LTLView)
/**
 *  高度
 */
@property(nonatomic,assign) CGFloat highly;
///宽度
@property(nonatomic,assign) CGFloat width;
///x值
@property(nonatomic,assign) CGFloat x;
///y值
@property(nonatomic,assign) CGFloat y;
///centerX
@property(nonatomic,assign) CGFloat centerX;
///centerY
@property(nonatomic,assign) CGFloat centerY;
/** 从xib中创建一个控件 */
+ (instancetype)viewFromXib;
///获取父控制器
- (UIViewController *)viewController;
@end
