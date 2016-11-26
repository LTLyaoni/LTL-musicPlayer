//
//  LTLCarousel.h
//  音乐播放器
//
//  Created by LiTaiLiang on 16/11/23.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LTLCarousel;
@protocol LTLCarouselDelegate <NSObject>

@optional
-(void)didLTLCarousel:(LTLCarousel*)Carousel Banner:(XMBanner *)Banner;

@end

@interface LTLCarousel : UIScrollView
////数据
@property(nonatomic,strong)NSArray <XMBanner *> *dadtArryr;
///代理
@property(nonatomic,weak)id<LTLCarouselDelegate>LTLdelegate;

@end
