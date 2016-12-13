//
//  LTLHeaderView.h
//  音乐播放器
//
//  Created by LiTaiLiang on 16/10/30.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTLPicView.h"
@class LTLHeaderView;
@protocol LTLHeaderViewDelegate <NSObject>

///播放全部歌曲
-(void)playAllSongHeaderView:(LTLHeaderView*)headerView;

///下载全部歌曲
-(void)downloadAllSongHeaderView:(LTLHeaderView*)headerView;

@end

@interface LTLHeaderView : UIImageView
//歌单数据
@property (nonatomic,strong) XMAlbum *XMAlbumModel;
//歌单数据
@property (nonatomic,strong) XMBanner *banner;

@property (nonatomic) CGRect visualEffectFrame;
/// 背景图 和 方向图
@property (nonatomic,strong) PicView *picView;

@property (nonatomic,weak) id<LTLHeaderViewDelegate>delegate;

@end
