//
//  LTLdongHua.h
//  实验
//
//  Created by LiTaiLiang on 16/11/11.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//
////push和pop都在animateTransition:里面实现，
////所以需要一个参数表示是push还是pop；
////还有一个参数表示转场时间
#import <Foundation/Foundation.h>
typedef enum : NSUInteger {
    LTLanimate_push = 0,
    LTLanimate_pop = 1,
    
} LTLAnimate_Type;

@interface LTLAnimate : NSObject
///动画时间
@property (assign, nonatomic) CGFloat duration;
///转场类型
@property (assign, nonatomic) LTLAnimate_Type type;
////那么要如何使用新建的对象呢？可以通过UINavigationControllerDelegate中的方法
///初始化
+ (instancetype)initWithAnimateType:(LTLAnimate_Type)type andDuration:(CGFloat)dura;
@end
