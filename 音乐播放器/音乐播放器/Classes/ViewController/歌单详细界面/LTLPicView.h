//
//  LTLPicView.h
//  音乐播放器
//
//  Created by LiTaiLiang on 16/10/30.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  方形图片
 */
@interface PicView : UIView
// 方图
@property (nonatomic,strong) UIImageView *coverView;
// 透明图层
@property (nonatomic,strong) UIImageView *bgView;
// 播放数
@property (nonatomic,strong) UIButton *playCountBtn;

@end
