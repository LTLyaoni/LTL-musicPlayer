//
//  LTLdongHua.m
//  实验
//
//  Created by LiTaiLiang on 16/11/11.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//
/**
 自定义转场动画
首先就要声明一个遵守UIViewControllerAnimatedTransitioning协议的类.
然后实现协议中的两个函数
 */


#import "LTLAnimate.h"
///控制器
#import "LTLMainInterface.h"
#import "LTLSongViewController.h"
#import "LTLsongSheetCell.h"

@interface LTLAnimate ()<UIViewControllerAnimatedTransitioning>

@property(nonatomic,strong)id<UIViewControllerContextTransitioning>transitionContext;
///毛玻璃
@property (strong, nonatomic) UIVisualEffectView *visualEffectView;


@end

@implementation LTLAnimate
///毛玻璃懒加载
-(UIVisualEffectView *)visualEffectView
{
    if (!_visualEffectView) {
        UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        
        _visualEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
        
    }
    return _visualEffectView;
}
#pragma mark - 初始化
///初始化
+ (instancetype)initWithAnimateType:(LTLAnimate_Type)type andDuration:(CGFloat)dura
{
    return [[self alloc]initWithAnimateType:type andDuration:dura];
}

- (instancetype)initWithAnimateType:(LTLAnimate_Type)type andDuration:(CGFloat)dura{
    if (self = [super init]) {
        _type = type;
        _duration = dura;
    }
    return self;
}
 #pragma mark - 转场时间
// This is used for percent driven interactive transitions, as well as for container controllers that have companion animations that might need to
///返回转场动画的时间
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return self.duration;

}
#pragma mark - 动作处理
/// 转场的动作
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    self.transitionContext = transitionContext;
    ///判断转场方式
    if (self.type == LTLanimate_push) {
        [self pushAnimateWithanimateTransition:transitionContext];
    }else{
        [self popAnimateWithanimateTransition:transitionContext];
    }

}
#pragma mark - 转场
- (void)pushAnimateWithanimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    ///起始视图控制器
    LTLMainInterface *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ///目标视图控制器
    LTLSongViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    ///在这个视图上实现跳转动画
    UIView *containView = [transitionContext containerView];
    
    //毛玻璃效果
    self.visualEffectView.frame = containView.bounds;
    _visualEffectView.alpha = 0;
    ///把视图控制器添加到处理跳转视图上!!!!!!!!!添加顺序很重要
    [containView addSubview:fromVC.view];
    [containView addSubview:_visualEffectView];
    
    [containView addSubview:toVC.view];
    
//    对点击的Cell上的 imageView 截图，同时将这个 imageView 本身隐藏
    LTLsongSheetCell *cell = (LTLsongSheetCell *)[fromVC.CollectionView cellForItemAtIndexPath:[[fromVC.CollectionView indexPathsForSelectedItems] firstObject]];
    ///保存索引
    toVC.indexPath = [[fromVC.CollectionView indexPathsForSelectedItems]firstObject];
    ///屏幕更新后的快照视图
    UIView * snapShotView = [cell.icon snapshotViewAfterScreenUpdates:NO];
    ///设置转换后的frame
    snapShotView.frame = toVC.finalCellRect = [containView convertRect:cell.icon.frame fromView:cell.icon];
    
    ///隐藏 cell 图片
    cell.icon.hidden = YES;
    ///添加快照
    [containView addSubview:snapShotView];
    ///执行快照动画前把目标控制器隐藏
    toVC.view.alpha = 0;
    ///执行快照动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        ///需要执行的动画
        snapShotView.frame   = [containView convertRect:toVC.infoView.picView.bounds fromView:toVC.infoView.picView];
        _visualEffectView.alpha = 1;
        
    } completion:^(BOOL finished) {
        ///显示目标控制器
        toVC.view.alpha = 1;
        ///layer层动画
        [self addPathAnimateWithView:toVC.view fromPoint:snapShotView.frame view:snapShotView  Transition:transitionContext];
        ///移除快照
        [snapShotView removeFromSuperview];
        ///隐藏 cell 图片
        cell.icon.hidden = NO;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext]+0.5 animations:^{
            self.visualEffectView.alpha = 0;
        }];
        
    }];
    
}
///POP
- (void)popAnimateWithanimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    ///起始视图控制器
    LTLSongViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ///目标视图控制器
    LTLMainInterface *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    ///在这个视图上实现跳转动画
    UIView *containView = [transitionContext containerView];
    
    //毛玻璃效果
    self.visualEffectView.frame = containView.bounds;
    ///把视图控制器添加到处理跳转视图上!!!!!!!!!添加顺序很重要
    [containView addSubview:toVC.view];
    [containView addSubview:self.visualEffectView];
    [containView addSubview:fromVC.view];
    
    //在前一个VC上创建一个截图
    UIView  *snapShotView = [fromVC.infoView.picView snapshotViewAfterScreenUpdates:NO];
    //
    snapShotView.frame = [containView convertRect:fromVC.infoView.picView.frame fromView:fromVC.infoView.picView.superview];
    
    //获取toVC中图片的位置
    LTLsongSheetCell *cell = (LTLsongSheetCell *)[toVC.CollectionView cellForItemAtIndexPath:fromVC.indexPath];
    cell.icon.hidden = YES;
    ///关闭toVC中图片显示
    fromVC.infoView.picView.hidden = YES;
    //添加快照
    [containView addSubview:snapShotView];
    
    ///layer层动画
    [self addPathAnimateWithView:fromVC.view fromPoint:snapShotView.frame view:snapShotView  Transition:transitionContext];
    
    //用延时执行动画就是等layer层动画执行完再执行延时动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:[self transitionDuration:transitionContext] options:UIViewAnimationOptionLayoutSubviews  animations:^{
        //执行的动画
        snapShotView.frame   = fromVC.finalCellRect;
        
        _visualEffectView.alpha =0;
        
    } completion:^(BOOL finished) {
        ///打开图片显示
        cell.icon.hidden = NO;
        ///移除快照
        [snapShotView removeFromSuperview];
        //移除毛玻璃
        [self.visualEffectView removeFromSuperview];
        //告诉 iOS 这个 transition 完成
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        
    }];
}
 #pragma mark -收合动画
//加入收合动画
- (void)addPathAnimateWithView:(UIView *)toView fromPoint:(CGRect)Rect  view:(UIView *)view Transition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
    ///路径
    UIBezierPath *maskStartBP =  [UIBezierPath bezierPathWithOvalInRect:Rect];
    UIBezierPath *maskStartBP2 =  [UIBezierPath bezierPathWithOvalInRect:CGRectInset(Rect, 50, 50)];

    ///半径
    CGFloat radius =  LTL_WindowH;

    
    ///路径
    UIBezierPath *maskFinalBP = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(Rect, -radius, -radius)];
    
    //创建一个 CAShapeLayer 来负责展示圆形遮盖
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    
    maskLayer.path = maskFinalBP.CGPath; //将它的 path 指定为最终的 path 来避免在动画完成后会回弹
    ///CAShapeLayer赋值给mask,mask类似于 PS 的遮罩
    toView.layer.mask = maskLayer;
    ///layer层动画
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    ///layer层动画初始位置
    maskLayerAnimation.fromValue = (_type == LTLanimate_push) ?  (__bridge id)(maskStartBP.CGPath) :  (__bridge id)((maskFinalBP.CGPath));
    ///layer层动画最终位置
    maskLayerAnimation.toValue =  (_type == LTLanimate_push) ? (__bridge id)((maskFinalBP.CGPath)) : (__bridge id)(maskStartBP2.CGPath) ;
    
    ///layer层动画时间
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    ///timingFunction为动画速度控制函数，控制动画运行的节奏
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    ///执行动画后不恢复初始状态
    maskLayerAnimation.removedOnCompletion = NO;
    maskLayerAnimation.fillMode = kCAFillModeForwards;
    
    
    maskLayerAnimation.delegate = self;
    ///往maskLayer添加动画
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}
#pragma mark - CABasicAnimation的Delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (!_type)
    {
        ///移除毛玻璃
        [self.visualEffectView removeFromSuperview];
        //告诉 iOS 这个 transition 完成
        [self.transitionContext completeTransition:![self. transitionContext transitionWasCancelled]];
    }
    
}

@end
