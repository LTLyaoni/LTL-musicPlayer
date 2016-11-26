//
//  LTLheadView.h
//  音乐播放器
//
//  Created by LiTaiLiang on 16/8/1.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LTLCarouselView;
@protocol LTLCarouselViewDelegate <NSObject>

-(void)didLTLCarouselView:(LTLCarouselView *)CarouselView tag :(NSUInteger)tag;

@end

@interface LTLCarouselView : UIView
//代理
@property (nonatomic,weak) id<LTLCarouselViewDelegate>LTLDelegate;

///滑动
-(void)huangDong:(CGFloat)X;
///获取数据
-(void)DataAcquisition;
@end
