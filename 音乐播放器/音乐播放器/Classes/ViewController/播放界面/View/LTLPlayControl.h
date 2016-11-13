//
//  LTLPlayControl.h
//  音乐播放器
//
//  Created by LiTaiLiang on 16/11/4.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol LTLPlayControlDelegate <NSObject>
//
//-(void)disPlayController:(UIView*)PlayControl;
//
//@end

@interface LTLPlayControl : UIView
///歌图片
@property (weak, nonatomic) IBOutlet UIImageView *songImage;
//@property (nonatomic,weak) id<LTLPlayControlDelegate>delegate;
///加载进度条
@property (weak, nonatomic) IBOutlet UIProgressView *jingDu;
///播放进度
@property (weak, nonatomic) IBOutlet UIProgressView *playProgress;
///是否播放
@property (nonatomic) BOOL musicIsPlaying;
///更新
-(void)setData;
@end
