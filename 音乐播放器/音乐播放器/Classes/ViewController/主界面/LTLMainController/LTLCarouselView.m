//
//  LTLheadView.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/8/1.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "LTLCarouselView.h"
#import "LTLCarousel.h"
#import "LTLPageControl.h"
#import "LTLButtonBorder.h"

@interface LTLCarouselView ()<UIScrollViewAccessibilityDelegate>

/////轮播器
@property(weak,nonatomic) IBOutlet  LTLCarousel * Carousel;
///页数
@property(nonatomic, weak)  IBOutlet LTLPageControl * Page;
//高度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *gao;
///按钮
@property(nonatomic, weak)  IBOutlet  UIView * View;
///高度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerViewHeight;
@end

@implementation LTLCarouselView
#pragma mark - 初始化
//加载完XB做的事
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.gao.constant = LTL_WindowW *300.0/640.0;
    
    self.Page.pageControlSelectColor = [LTLThemeManager sharedManager].themeColor;
//    self.Page.pageControlNormalColor = [LTLThemeManager sharedManager].themeColor;
    
    self.headerViewHeight.constant = self.gao.constant * 1.262933;
    
    [self setButtom];
    [self DataAcquisition];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DataAcquisition) name:LTLRefreshKey object:nil];
    
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

///获取数据
-(void)DataAcquisition
{
    //取焦点图
    [LTLNetworkRequest CategoryBanner:^(NSArray<XMBanner *> * _Nullable modelArray, XMErrorModel * _Nullable error) {
        _Carousel.dadtArryr = modelArray;
    }];
}

-(void)huangDong:(CGFloat)X
{
    [_Page huangDong:X];
}

-(void)setButtom
{
    for (int i = 0; i<3; i++) {
        
        UIButton *btn = [[UIButton alloc]init];
        btn.tag = i;
        NSString *title;
        switch (i) {
            case 0:
                title = @"音乐台";
                break;
            case 1:
                 title = @"推荐";
                break;
            case 2:
                 title = @"乐库";
                break;
        }
        [btn setTitle:title forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitleColor:[LTLThemeManager sharedManager].themeColor forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
        [_View addSubview:btn];
    }
}
//点击
-(void)didButton:(UIButton*)btn
{
    if ([self.LTLDelegate respondsToSelector:@selector(didLTLCarouselView:tag:)])
    {
        [self.LTLDelegate didLTLCarouselView:self tag:btn.tag];
    }
}
//布局
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat W = _View.width /3;
    CGFloat h = _View.highly;
    CGRect rect = CGRectMake(0, 0, W, h);
    
    [_View.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIImage *bg = [LTLButtonBorder imageOfArtboardWithSize:rect.size resizing:LTLButtonBorderResizingBehaviorStretch];
        
        [obj setBackgroundImage:bg forState:UIControlStateNormal];
        
        obj.frame = CGRectOffset(rect, idx * W, 0);
    }];
    
}

@end
