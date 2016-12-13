//
//  LTLSongViewController.h
//  音乐播放器
//
//  Created by LiTaiLiang on 16/10/30.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
// 头部展示页
#import "LTLHeaderView.h"

@interface LTLSongViewController : UIViewController

//显示的图片
@property (nonatomic,strong) UIImageView *Image;
//歌单数据
@property (nonatomic,strong) XMAlbum *XMAlbumModel;
//头视图
@property (nonatomic,strong) LTLHeaderView  *infoView;
///保存点击的itme的索引
@property(nonatomic,strong)NSIndexPath *indexPath;
///保存点击的itme的frame
@property(nonatomic,assign)CGRect finalCellRect;



@end
