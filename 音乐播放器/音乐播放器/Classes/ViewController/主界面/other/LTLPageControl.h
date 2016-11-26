//
//  LTLPageControl.h
//  音乐播放器
//
//  Created by LiTaiLiang on 16/11/23.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTLPageControl : UIView
@property (strong, nonatomic) UIColor  *pageControlSelectColor;
@property (strong, nonatomic) UIColor  *pageControlNormalColor;

-(instancetype)initWithFrame:(CGRect)frame andPageCount:(NSInteger)count;

-(void)huangDong:(CGFloat)X;

@end
