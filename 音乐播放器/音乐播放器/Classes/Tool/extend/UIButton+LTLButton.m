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

@interface UIButton ()

@property(nonatomic,assign) BOOL monitor;

@end

//static  double gradientDegreeKey ;
//static void *gradientDegreeKey = &gradientDegreeKey;


@implementation UIButton (LTLButton)

@dynamic gradientDegree;
@dynamic LTLlabel;
@dynamic gradient;
@dynamic gradientFont;
@dynamic highlightedText;

static const char LTLlabelKey = '\0';
static const char gradientFontKey = '\0';


-(void)setMonitor:(BOOL)monitor
{
    if (monitor != self.monitor) {
        NSNumber *monitorNumber = @(monitor);
        objc_setAssociatedObject(self, @selector(monitor), monitorNumber, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
-(BOOL)monitor
{
    return objc_getAssociatedObject(self, @selector(monitor));
}

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
        
        UIFont *font =self.titleLabel.font ;
        
        self.LTLlabel.font = font;
        self.LTLlabel.textColor = normalColor;
        self.LTLlabel.highlightedTextColor = highlightedColor;
        
        self.LTLlabel.gradientDegree = self.state;
        [self.titleLabel removeFromSuperview];
        
        
        self.LTLlabel.userInteractionEnabled  =  NO;
        
        
        [self.LTLlabel sizeToFit];
        
        self.LTLlabel.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        
        [self addSubview:self.LTLlabel];
//        [self setValue:self.LTLlabel forKey:@"UIButtonLabel"];
        
        [self addObserver:self forKeyPath:@"bounds" options:NSKeyValueObservingOptionNew context:nil];
        
        self.monitor = YES;
        
    }
}
////bounds监听到变化
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    LTLLog(@"keyPath %@",keyPath);
    
    LTLLog(@"object %@",object);
    
}


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

    LTLLog(@"ooo%f",gradientDegree);
    self.LTLlabel.gradientDegree = gradientDegree;
    
}

-(void)dealloc
{
    if (self.monitor) {
        [self removeObserver:self forKeyPath:@"bounds"];
    }

}




@end
