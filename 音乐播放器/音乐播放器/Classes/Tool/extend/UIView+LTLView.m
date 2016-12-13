//
//  UIView+LTLView.m
//  WeiBo
//
//  Created by Apple_Lzzy46 on 16/9/23.
//  Copyright © 2016年 LTL. All rights reserved.
//

#import "UIView+LTLView.h"

@implementation UIView (LTLView)
+ (instancetype)viewFromXib
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
-(void)setHighly:(CGFloat)highly
{
    CGRect frame   = self.frame;
    frame.size.height = highly;
    self.frame     = frame;
}
-(CGFloat)highly
{
    return self.frame.size.height;
}
-(void)setWidth:(CGFloat)width
{
    CGRect frame   = self.frame;
    
    frame.size.width = width;
    self.frame     = frame;
}
-(CGFloat)width
{
    return self.frame.size.width;
}
-(void)setX:(CGFloat)x
{
    CGRect frame   = self.frame;
    
    frame.origin.x = x;
    self.frame     = frame;
}
-(CGFloat)x
{
    return self.frame.origin.x;
}
-(void)setY:(CGFloat)y
{
    CGRect frame   = self.frame;
    
    frame.origin.y = y;
    
    self.frame     = frame;
}
-(CGFloat)y
{
    return self.frame.origin.y;
}
-(void)setCenterX:(CGFloat)centerX
{
    CGPoint origin = self.center;
      origin.x = centerX;
    self.center     = origin;
}
-(CGFloat)centerX
{
    return self.center.x;
}

-(void)setCenterY:(CGFloat)centerY
{
    CGPoint origin = self.center;
    origin.y = centerY;
    self.center     = origin;}
-(CGFloat)centerY
{
    return self.center.y;
}
///获取父控制器
- (UIViewController *)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
@end
