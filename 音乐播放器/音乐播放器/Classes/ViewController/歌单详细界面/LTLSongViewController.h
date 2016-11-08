//
//  LTLSongViewController.h
//  音乐播放器
//
//  Created by LiTaiLiang on 16/10/30.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTLSongViewController : UIViewController

//显示的图片
@property (nonatomic,strong) UIImageView *Image;
//歌单数据
@property (nonatomic,strong) XMAlbum *XMAlbumModel;


@end
