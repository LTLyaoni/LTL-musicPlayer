//
//  LTLPageControl.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/11/23.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "LTLPageControl.h"

@interface LTLPageControl ()

@property(nonatomic,strong)UIView * smallCircleView;
@property (strong, nonatomic) UIView  *selectCircle;

@property (nonatomic, assign) CGFloat smallCircleR;
@property (nonatomic, assign) CGFloat distance;

@property (nonatomic, assign) CGFloat H;
@property (nonatomic, assign) CGFloat W;

@property(nonatomic,assign)NSUInteger count;

@end

@implementation LTLPageControl

- (instancetype)initWithFrame:(CGRect)frame andPageCount:(NSInteger)count
{
    self = [super initWithFrame:frame];
    if (self) {
        self.count = count;
        self.H = frame.size.height;
        self.W = frame.size.width;
        [self setUI];
    }
    return self;
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.count = 3;
    
    self.W = self.bounds.size.width;
    self.H = self.bounds.size.height;
    
    [self setUI];
}



-(void)layoutSubviews
{
    [super layoutSubviews];

    if (self.W != self.bounds.size.width || self.H != self.bounds.size.height) {
        self.W = self.bounds.size.width;
        self.H = self.bounds.size.height;
        
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self setUI];
    }
    
}

-(void)setPageControlSelectColor:(UIColor *)pageControlSelectColor
{
    _pageControlSelectColor = pageControlSelectColor;
    self.selectCircle.backgroundColor =_pageControlSelectColor;
}

-(void)setUI
{
//    ///页面控件正常颜色
//    self.pageControlNormalColor = [UIColor colorWithWhite:0.816 alpha:1.000];
    ///页面控件选择颜色
//    self.pageControlSelectColor = [UIColor redColor];
    ///宽度
    CGFloat w = self.frame.size.width / (2 * _count);
    self.distance = w;
    ///高度
    CGFloat h = self.frame.size.height;
//    //位置
    CGRect rect = CGRectMake(w/2, 0, w, h);
//    ///添加底控件
//    for (int i = 0; i < _count; i++) {
//        //设置位置及位移
//        UIView * pageControl = [[UIView alloc]initWithFrame:CGRectOffset(rect, w * i*2, 0)];
//        //弧度
//        pageControl.layer.cornerRadius = h/2;
//        //颜色
//        pageControl.backgroundColor = self.pageControlNormalColor;
//        [self addSubview:pageControl];
//        
//    }
    //选择的指示
    self.selectCircle = [[UIView alloc] initWithFrame:rect];
    //颜色
    self.selectCircle.backgroundColor = self.pageControlSelectColor;
    //弧度
    self.selectCircle.layer.cornerRadius = h/2;
    //添加
    [self addSubview:self.selectCircle];
//    ///选择的指示用来做动画
//    self.smallCircleView = [[UIView alloc] initWithFrame:rect];
//    //颜色
//    self.smallCircleView.backgroundColor = self.pageControlSelectColor;
//    //弧度
//    self.smallCircleView.layer.cornerRadius = self.selectCircle.frame.size.height/2;
//    
//    [self addSubview:self.smallCircleView];
//    //半径
//    self.smallCircleR = self.selectCircle.frame.size.height/2;
    

}

-(void)huangDong:(CGFloat)X
{
    if (X == 0) {
        return;
    }
    
    CGPoint center = self.smallCircleView.center;
    
    //    center.x = x/SFactor * 375/[UIScreen mainScreen].bounds.size.width;
    
    center.x = X * self.distance / [UIScreen mainScreen].bounds.size.width * 2 + self.distance;
    
    self.selectCircle.center = center;
    self.selectCircle.y = 0;
//    CGFloat newR = self.smallCircleR - _distance / 20;
//    
//    self.smallCircleView.bounds = CGRectMake(0, 0, self.distance, newR * 2);
//    
//    self.smallCircleView.layer.cornerRadius = newR;

}
@end
