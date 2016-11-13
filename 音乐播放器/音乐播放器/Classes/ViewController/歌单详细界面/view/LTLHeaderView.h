//
//  LTLHeaderView.h
//  音乐播放器
//
//  Created by LiTaiLiang on 16/10/30.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTLPicView.h"

@interface LTLHeaderView : UIImageView
//歌单数据
@property (nonatomic,strong) XMAlbum *XMAlbumModel;

@property (nonatomic) CGRect visualEffectFrame;
/// 背景图 和 方向图
@property (nonatomic,strong) PicView *picView;

@end
