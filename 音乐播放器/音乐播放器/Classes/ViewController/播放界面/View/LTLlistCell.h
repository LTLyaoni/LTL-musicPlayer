//
//  LTLlistCell.h
//  音乐播放器
//
//  Created by LiTaiLiang on 16/12/7.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NAKPlaybackIndicatorView.h"

@interface LTLlistCell : UITableViewCell

@property (nonatomic,weak) XMTrack *data;

@property (nonatomic,assign) NAKPlaybackIndicatorViewState state;


@end
