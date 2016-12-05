//
//  XMTrack+LTLXMTrack.h
//  音乐播放器
//
//  Created by LiTaiLiang on 16/11/1.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "XMTrack.h"

@interface XMTrack (LTLXMTrack)
///播放次数
@property(nonatomic,strong)NSString *playNumber;
///添加时间
@property (nonatomic,strong) NSString *addTime;
///添加播放时长
@property (nonatomic,strong) NSString *playTime;
///时间处理方法
-(void)TimeProcessing:(double)time;

@end
