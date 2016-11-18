

//
//  LTLheadView.m
//  团购
//
//  Created by LiTaiLiang on 16/8/1.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "LTLCarouselView.h"

@interface LTLCarouselView ()<UIScrollViewAccessibilityDelegate>

///轮播器
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
///轮播器页码
@property(weak,nonatomic) IBOutlet  UIPageControl * pageControl;
///定时器
@property(nonatomic,strong) NSTimer * timer;
//高度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *gao;

@end

@implementation LTLCarouselView
#pragma mark - 初始化
//xib 加载
///在-(instancetype)initWithCoder:(NSCoder *)aDecoder 此方法初始化才有效
//-(instancetype)initWithCoder:(NSCoder *)aDecoder
//{
//    if (self == [super initWithCoder:aDecoder]) {
//        self.backgroundColor = [UIColor orangeColor];
////        [self ScrollView];
////        [self PageControl];
//        self.gao.constant = mainWidth*300.0/640.0;
//        [self DataAcquisition];
//        [self addTimer:nil];
//    }
//    return self;
//}
//加载完XB做的事
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.gao.constant = LTL_WindowW *300.0/640.0;
    [self DataAcquisition];
    [self addTimer:nil];
    _scrollView.delegate = self;
}

#pragma mark - 数据传送过来做处理
-(void)setArryr:(NSArray *)arryr
{
    _arryr = arryr;
    //清除scrollView子控件
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //图片宽度
    CGFloat imageW = self.scrollView.width;
    //第一张图片Frame
    CGRect rect = CGRectMake(0, 0, imageW, self.scrollView.highly);

    //添加图片
    for (int i=0; i<arryr.count; i++)
    {
        //创建按钮
        UIButton *imageButton = [[UIButton alloc]init];
        imageButton.tag = i;
        imageButton.frame = CGRectOffset(rect, i*imageW, 0);
        //取出图片链接
        XMBanner *model = arryr[i];
        NSURL *url = [NSURL URLWithString:model.bannerUrl];
        //设置图片
        [imageButton sd_setBackgroundImageWithURL:url forState:UIControlStateNormal];
        //点击图片
        [imageButton addTarget:self action:@selector(Carousel:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:imageButton];
    }
    //滑动大小
    self.scrollView.contentSize = CGSizeMake(_arryr.count*imageW, 0);
    //指示器数
    self.pageControl.numberOfPages = _arryr.count;
}
///获取数据
-(void)DataAcquisition
{
    //取焦点图
    [LTLNetworkRequest CategoryBanner:^(NSMutableArray * _Nullable modelArray, XMErrorModel * _Nullable error) {
        if (modelArray.count != 0) {
            self.arryr = modelArray;
            //            [self.CollectionView reloadData];
        }
    }];
}
#pragma mark - 点击轮播图片
-(void)Carousel:(UIButton *)buttom
{
//    NSLog(@"%ld",buttom.tag);
}
#pragma mark - 定时器轮播图片
///定时器
-(void)addTimer:(NSSet *)objects
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(nexImage) userInfo:nil repeats:YES];
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
    //页数
    NSInteger count = _arryr.count;
    //当前页数
    NSInteger page = 0;
    
    if (self.pageControl.currentPage == count-1) {
        page = 0;
    }
    else
    {
        page = self.pageControl.currentPage+1;
    }
    //设置中心
    CGFloat offsetX = page*self.scrollView.frame.size.width;
    CGPoint offset=CGPointMake(offsetX, 0);
    
    //偏移
    [self.scrollView setContentOffset:offset animated:YES];
}
//监听滑动范围来设置指示器
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat w = scrollView .frame.size.width;
    int page = (scrollView.contentOffset.x+w*0.5)/w;
    self.pageControl.currentPage = page;
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
@end
