//
//  LTLCarousel.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/11/23.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "LTLCarousel.h"
#define LTLCarouselWidth self.bounds.size.width   //轮播器的宽度
#define LTLCarouselHeight  self.bounds.size.height//轮播器的高度
@interface LTLCarousel ()<UIScrollViewDelegate>
///轮播器页码
@property(strong,nonatomic) UIPageControl * pageControl;
///定时器
@property(nonatomic,strong) NSTimer * timer;

@end
///记录中间图片的下标,开始总是为1
static NSUInteger currentImage = 1;

@implementation LTLCarousel

-(UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]init];
        
        [self.superview addSubview:_pageControl];
        [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom);
            make.centerX.equalTo(self.mas_centerX);
        }];
    }
    return _pageControl;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}
///加载完 XIB
-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setUI];
}
//控件
-(void)setUI
{
    //可滑动
    self.scrollEnabled = YES;
    //分页
    self.pagingEnabled = YES;
    //去除弹簧
    self.bounces = NO;
    //添加图片
    for (NSUInteger i = 0 ; i < 3; i++)
    {
        UIButton *btn = [[UIButton alloc]init];
        btn.backgroundColor = LTLrandomColor;
        btn.tag = i;
        [self addSubview:btn];
        [btn addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectOffset(self.bounds, LTLCarouselWidth * i, 0);
    }
    //滑动距离
     self.contentSize = CGSizeMake(LTLCarouselWidth * 3, 0);
    //初始便宜
    self.contentOffset = CGPointMake( LTLCarouselWidth, 0);
    //代理
    self.delegate = self;
    //定时
    [self addTimer:nil];
}
//代理方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (_dadtArryr.count == 0) {
        return;
    }
    if (self.contentOffset.x == 0)
    {
        //当等currentImage-1 就等于0;否则还是currentImage-1
        currentImage = (currentImage-1)%_dadtArryr.count;
        
    }
    else if(self.contentOffset.x == LTLCarouselWidth * 2)
    {
        //当等currentImage+1 就等于0;否则还是currentImage+1
        currentImage = (currentImage+1)%_dadtArryr.count;
    }
    else
    {
        return;
    }
    _pageControl.currentPage = currentImage;
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = obj;
        
        NSUInteger Image = 0;
        
        switch (idx) {
            case 0:
                Image = (currentImage-1)%_dadtArryr.count;
                break;
            case 1:
                Image = currentImage;
                break;
            case 2:
                Image = (currentImage+1)%_dadtArryr.count;
                break;
        }
        
        XMBanner *model = _dadtArryr[Image];
        NSURL *url = [NSURL URLWithString:model.bannerUrl] ;
        [button sd_setImageWithURL:url forState:UIControlStateNormal];
        
    }];
    
    self.contentOffset = CGPointMake(LTLCarouselWidth, 0);
}
-(void)didButton:(UIButton *)btn
{
    XMBanner *model = _dadtArryr[currentImage];
    if ([self.LTLdelegate respondsToSelector:@selector(didLTLCarousel:Banner:)]) {
        [self.LTLdelegate didLTLCarousel:self Banner:model];
    }
}
#pragma mark - 定时器轮播图片
///定时器
-(void)addTimer:(NSSet *)objects
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(nexImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}

///移除定时器
-(void)removeTimer:(NSSet *)objects
{
    [self.timer invalidate];
    self.timer = nil;
}
///定时器调用方法
-(void)nexImage
{
   //偏移
    [self setContentOffset:CGPointMake(LTLCarouselWidth * 2 , 0) animated:YES];
    
    [NSTimer scheduledTimerWithTimeInterval:0.35f target:self selector:@selector(scrollViewDidEndDecelerating:) userInfo:nil repeats:NO];
}
//用手滑动时移除定时器
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer:nil];
}
//停止用手滑动时添加定时器
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer:nil];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    //调整高度
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.highly = LTLCarouselHeight;
    }];
    
}

-(void)setDadtArryr:(NSArray<XMBanner *> *)dadtArryr
{
    _dadtArryr = dadtArryr;
    self.pageControl.numberOfPages = _dadtArryr.count;
    self.pageControl.currentPage = 1;
    if (_dadtArryr.count == 1) {
        self.pageControl.currentPage = 0;
        self.scrollEnabled = NO;
        [self removeTimer:nil];
        //设置图片
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *button = obj;
            if (idx == 1) {
                XMBanner *model = _dadtArryr[idx-1];
                NSURL *url = [NSURL URLWithString:model.bannerUrl] ;
                [button sd_setImageWithURL:url forState:UIControlStateNormal];
            }
        }];
    }
    else if (_dadtArryr.count > 1)
    {
        //设置图片
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *button = obj;
            //idx%_dadtArryr.count依次下标
            XMBanner *model = _dadtArryr[idx%_dadtArryr.count];
            NSURL *url = [NSURL URLWithString:model.bannerUrl] ;
            [button sd_setImageWithURL:url forState:UIControlStateNormal];
            
        }];
    }
//    if (_dadtArryr.count == 2)
//    {
//        //设置图片
//        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            UIButton *button = obj;
//            if (idx > 1) {
//                XMBanner *model = _dadtArryr[idx-2];
//                NSURL *url = [NSURL URLWithString:model.bannerUrl] ;
//                [button sd_setImageWithURL:url forState:UIControlStateNormal];
//            }
//            else
//            {
//                XMBanner *model = _dadtArryr[idx];
//                NSURL *url = [NSURL URLWithString:model.bannerUrl] ;
//                [button sd_setImageWithURL:url forState:UIControlStateNormal];
//            }
//        }];
//    }else
//    {
//        //设置图片
//        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            UIButton *button = obj;
//            
//            XMBanner *model = _dadtArryr[idx];
//            NSURL *url = [NSURL URLWithString:model.bannerUrl] ;
//            [button sd_setImageWithURL:url forState:UIControlStateNormal];
//            
//        }];
//    
//    }

}

@end
