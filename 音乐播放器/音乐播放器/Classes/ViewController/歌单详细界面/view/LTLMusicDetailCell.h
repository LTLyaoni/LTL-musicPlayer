//
//  LTLMusicDetailCell.h
//  音乐播放器
//
//  Created by LiTaiLiang on 16/10/30.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTLMusicDetailCell : UITableViewCell

/** 原则上 .h文件中只存放需要被调用get或者set方法的属性 */

///歌数据
@property (nonatomic,weak) XMTrack *TrackData;


@end
