//
//  LTLHeaderView.h
//  音乐播放器
//
//  Created by LiTaiLiang on 16/10/30.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTLHeaderView : UIImageView
//歌单数据
@property (nonatomic,strong) XMAlbum *XMAlbumModel;

@property (nonatomic) CGRect visualEffectFrame;


@end
