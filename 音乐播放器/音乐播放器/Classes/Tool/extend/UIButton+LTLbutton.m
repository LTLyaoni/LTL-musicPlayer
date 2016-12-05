//
//  UIButton+LTLButton.m
//  代码修改
//
//  Created by LiTaiLiang on 16/12/4.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "UIButton+LTLButton.h"
//#import "LTLLabel.h"
#import <objc/runtime.h>

//@interface UIButton ()
//
//@end

@implementation UIButton (LTLButton)

@dynamic gradientDegree;
@dynamic LTLlabel;
@dynamic gradient;
@dynamic gradientFont;
@dynamic highlightedText;

static const char LTLlabelKey = '\0';
static const char gradientFontKey = '\0';

-(void)setGradient:(BOOL)gradient
{
    if (gradient != self.isGradient) {
        NSNumber *gradientFloatNumber = @(gradient);
        objc_setAssociatedObject(self, @selector(isGradient), gradientFloatNumber, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }

    if (gradient) {
     
        LTLLabel *label = [[LTLLabel alloc]init];
        
        self.LTLlabel = label;
        NSString *text =  [self titleForState:UIControlStateNormal];
        
        self.LTLlabel.text = text;

        UIColor *normalColor = [self titleColorForState:UIControlStateNormal];
        UIColor *highlightedColor = [self titleColorForState:UIControlStateHighlighted];
        
        self.LTLlabel.textColor = normalColor;
        self.LTLlabel.highlightedTextColor = highlightedColor;
        
        self.LTLlabel.gradientDegree = self.state;
        [self.titleLabel removeFromSuperview];
        
        
        self.LTLlabel.userInteractionEnabled  =  NO;
        
        [self addSubview:self.LTLlabel];

//        [self addObserver:self forKeyPath:@"bounds" options:NSKeyValueObservingOptionNew context:nil];
        
        
    }
    
}

//-(void)dealloc
//{
//    //移除
//    [self removeObserver:self forKeyPath:@"bounds"];
//}

-(BOOL)isGradient
{
    return objc_getAssociatedObject(self, @selector(isGradient));
}

-(LTLLabel *)LTLlabel
{
    return objc_getAssociatedObject(self, &LTLlabelKey);
}


-(void)setLTLlabel:(LTLLabel *)LTLlabel
{
    if (LTLlabel != self.LTLlabel) {
//        // 删除旧的，添加新的
//        [self.LTLlabel removeFromSuperview];
//        [self insertSubview:mj_header atIndex:0];
        
        // 存储新的
        [self willChangeValueForKey:@"LTLlabel"]; // KVO
        objc_setAssociatedObject(self, &LTLlabelKey,
                                 LTLlabel, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"LTLlabel"]; // KVO
    }

}

-(void)setHighlightedText:(BOOL)highlightedText
{
    self.LTLlabel.gradientDegree = highlightedText;
}

-(void)setGradientFont:(UIFont *)gradientFont
{
    objc_setAssociatedObject(self, &gradientFontKey,
                             gradientFont, OBJC_ASSOCIATION_ASSIGN);
    
    self.LTLlabel.font = gradientFont;
    
}


-(CGFloat)gradientDegree
{
    return [objc_getAssociatedObject(self, @selector(gradientDegree)) floatValue];

}
-(void)setGradientDegree:(CGFloat)gradientDegree
{
    if (gradientDegree != self.gradientDegree) {
        NSNumber *gradientDegreeFloatNumber = @(gradientDegree);
        objc_setAssociatedObject(self, @selector(gradientDegree), gradientDegreeFloatNumber, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }

    self.LTLlabel.gradientDegree = gradientDegree;
    
}

//-(void)layoutSubviews
//{
//    [super layoutSubviews];
//
//    [self.LTLlabel sizeToFit];
//    
//    self.LTLlabel.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
//    
//    [self.titleLabel sizeToFit];
//    self.titleLabel.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
//   
//};



@end
