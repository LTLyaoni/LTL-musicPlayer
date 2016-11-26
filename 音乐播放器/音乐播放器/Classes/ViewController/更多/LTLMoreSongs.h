//
//  LTLMoreSongs.h
//  音乐播放器
//
//  Created by LiTaiLiang on 16/11/23.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTLMoreSongs : UITableViewController
///数据
@property (nonatomic,weak) LTLRecommendAlbums *model;
///标签
@property (nonatomic,weak)  XMTag *data;
@end
